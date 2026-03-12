import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/app_language.dart';
import '../models/timeline_event.dart';
import '../services/timeline_storage.dart';
import '../widgets/timeline_card.dart';
import '../widgets/timeline_editor_dialog.dart';
import '../widgets/timeline_year_header.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({
    super.key,
    required this.language,
    TimelineStorage? storage,
  }) : storage = storage ?? InMemoryTimelineStorage.instance;

  final AppLanguage language;
  final TimelineStorage storage;

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<TimelineEvent> _events = <TimelineEvent>[];
  bool _isLoading = true;

  AppLanguage get _lang => widget.language;
  bool get _isZh => _lang == AppLanguage.zh;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final List<TimelineEvent> events = await widget.storage.loadEvents();
    if (!mounted) return;
    setState(() {
      _events = events;
      _isLoading = false;
    });
  }

  Future<void> _persistEvents() async {
    await widget.storage.saveEvents(_events);
  }

  // ---------------------------------------------------------------------------
  // Year grouping helpers
  // ---------------------------------------------------------------------------

  List<String> _sortedYears() {
    final List<String> years =
        _events.map((e) => e.year).toSet().toList(growable: false);
    years.sort((a, b) {
      final int? av = int.tryParse(a);
      final int? bv = int.tryParse(b);
      if (av != null && bv != null) return av.compareTo(bv);
      return a.compareTo(b);
    });
    return years;
  }

  List<_ListItem> _buildItems() {
    final List<_ListItem> items = <_ListItem>[];
    for (final String year in _sortedYears()) {
      items.add(_ListItem.header(year));
      for (final TimelineEvent e
          in _events.where((item) => item.year == year)) {
        items.add(_ListItem.event(e));
      }
    }
    return items;
  }

  String _earlierYear(String earliest, String fallback) {
    final int? v = int.tryParse(earliest);
    return v == null ? fallback : (v - 1).toString();
  }

  // ---------------------------------------------------------------------------
  // CRUD
  // ---------------------------------------------------------------------------

  Future<void> _openEditor({TimelineEvent? event}) async {
    final TimelineEvent? result = await TimelineEditorDialog.show(
      context,
      language: _lang,
      initialEvent: event,
    );
    if (!mounted || result == null) return;

    setState(() {
      if (event == null) {
        _events = <TimelineEvent>[result, ..._events];
      } else {
        final int i = _events.indexWhere((e) => e.id == result.id);
        if (i != -1) _events[i] = result;
      }
    });
    await _persistEvents();
  }

  Future<void> _deleteEvent(TimelineEvent event) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_isZh ? '刪除事件？' : 'Delete event?'),
        content: Text(_isZh ? '確定要移除嗎？' : 'Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(_isZh ? '取消' : 'Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(_isZh ? '刪除' : 'Delete'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    setState(() => _events.removeWhere((e) => e.id == event.id));
    await _persistEvents();
  }

  // ---------------------------------------------------------------------------
  // Reorder with automatic year detection
  // ---------------------------------------------------------------------------

  String _resolveYear(List<_ListItem> items, int idx, String fallback) {
    if (items.isEmpty) return fallback;
    if (idx < items.length && items[idx].isHeader) return items[idx].year!;
    for (int i = idx - 1; i >= 0; i--) {
      if (items[i].isHeader) return items[i].year!;
    }
    for (int i = idx; i < items.length; i++) {
      if (items[i].isHeader) return items[i].year!;
    }
    return fallback;
  }

  int _resolveInsert(List<_ListItem> items, int idx) {
    if (idx < 0) return 0;
    if (idx > items.length) return items.length;
    if (idx < items.length && items[idx].isHeader) {
      return (idx + 1).clamp(0, items.length);
    }
    return idx;
  }

  Future<void> _reorder(int oldIndex, int newIndex) async {
    final List<_ListItem> items = _buildItems();
    final _ListItem moving = items.removeAt(oldIndex);
    if (!moving.isEvent || moving.event == null) return;

    if (newIndex > oldIndex) newIndex -= 1;
    final int bounded = newIndex.clamp(0, items.length);

    final bool goesAboveFirst =
        bounded == 0 &&
        items.isNotEmpty &&
        items.first.isHeader &&
        items.first.year != null;

    final String targetYear = goesAboveFirst
        ? _earlierYear(items.first.year!, moving.event!.year)
        : _resolveYear(items, bounded, moving.event!.year);

    final int insertAt =
        goesAboveFirst ? 0 : _resolveInsert(items, bounded);

    items.insert(
      insertAt,
      _ListItem.event(moving.event!.copyWith(year: targetYear)),
    );

    setState(() {
      _events = items
          .where((i) => i.isEvent)
          .map((i) => i.event!)
          .toList(growable: false);
    });
    await _persistEvents();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isZh ? 'Timeline' : 'Timeline'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : () => _openEditor(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_events.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timeline_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 12),
            Text(
              _isZh ? '開始記錄你的故事' : 'Start your story',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    final List<_ListItem> items = _buildItems();

    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.headerTopPadding,
        AppSpacing.pagePadding,
        AppSpacing.bottomSafeArea + 56,
      ),
      buildDefaultDragHandles: false,
      itemCount: items.length,
      proxyDecorator: (child, _, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (ctx, _) {
            final double elev =
                Tween<double>(begin: 0, end: 6).transform(animation.value);
            return Material(
              elevation: elev,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.cardRadius),
              child: child,
            );
          },
        );
      },
      onReorder: _reorder,
      itemBuilder: (context, index) {
        final _ListItem item = items[index];

        if (item.isHeader) {
          return TimelineYearHeader(
            key: ValueKey('year-${item.year}'),
            year: item.year!,
            isFirst: index == 0,
          );
        }

        final TimelineEvent event = item.event!;
        return Padding(
          key: ValueKey(event.id),
          padding: const EdgeInsets.only(bottom: 14),
          child: TimelineCard(
            event: event,
            onEdit: () => _openEditor(event: event),
            onDelete: () => _deleteEvent(event),
            dragHandle: ReorderableDragStartListener(
              index: index,
              child: Icon(
                Icons.drag_indicator,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Internal list-item union type
// ---------------------------------------------------------------------------

enum _ListItemType { yearHeader, event }

class _ListItem {
  const _ListItem.header(this.year)
      : event = null,
        type = _ListItemType.yearHeader;

  const _ListItem.event(this.event)
      : year = null,
        type = _ListItemType.event;

  final _ListItemType type;
  final String? year;
  final TimelineEvent? event;

  bool get isHeader => type == _ListItemType.yearHeader;
  bool get isEvent => type == _ListItemType.event;
}

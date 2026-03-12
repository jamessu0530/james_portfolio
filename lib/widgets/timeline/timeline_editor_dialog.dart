import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';
import '../../models/app_language.dart';
import '../../models/timeline_event.dart';
import 'timeline_image.dart';

class TimelineEditorDialog extends StatefulWidget {
  const TimelineEditorDialog({
    super.key,
    required this.language,
    this.initialEvent,
  });

  final AppLanguage language;
  final TimelineEvent? initialEvent;

  static Future<TimelineEvent?> show(
    BuildContext context, {
    required AppLanguage language,
    TimelineEvent? initialEvent,
  }) {
    return showModalBottomSheet<TimelineEvent>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TimelineEditorDialog(
          language: language,
          initialEvent: initialEvent,
        );
      },
    );
  }

  @override
  State<TimelineEditorDialog> createState() => _TimelineEditorDialogState();
}

class _TimelineEditorDialogState extends State<TimelineEditorDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  late final TextEditingController _yearController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imagePathController;
  late final TextEditingController _locationUrlController;

  bool get _isEditing => widget.initialEvent != null;
  AppLanguage get _lang => widget.language;
  bool get _isZh => _lang == AppLanguage.zh;

  @override
  void initState() {
    super.initState();
    _yearController = TextEditingController(
      text: widget.initialEvent?.year ?? '',
    );
    _titleController = TextEditingController(
      text: widget.initialEvent?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialEvent?.description ?? '',
    );
    _imagePathController = TextEditingController(
      text: widget.initialEvent?.imagePath ?? '',
    );
    _locationUrlController = TextEditingController(
      text: widget.initialEvent?.locationUrl ?? '',
    );
    _imagePathController.addListener(_refresh);
  }

  @override
  void dispose() {
    _imagePathController.removeListener(_refresh);
    _yearController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _imagePathController.dispose();
    _locationUrlController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _pickFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1600,
    );
    if (file == null) return;
    _imagePathController.text = file.path;
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final TimelineEvent result = TimelineEvent(
      id: widget.initialEvent?.id ?? TimelineEvent.createId(),
      year: _yearController.text.trim(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imagePath: _imagePathController.text.trim().isEmpty
          ? 'assets/timeline/placeholder.jpg'
          : _imagePathController.text.trim(),
      locationUrl: _locationUrlController.text.trim(),
    );

    Navigator.of(context).pop(result);
  }

  String _required(String? v) =>
      (v == null || v.trim().isEmpty) ? (_isZh ? '必填' : 'Required') : '';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Material(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.cardRadius),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.outlineVariant,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isEditing
                        ? (_isZh ? '編輯事件' : 'Edit Event')
                        : (_isZh ? '新增事件' : 'New Event'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90,
                        child: TextFormField(
                          controller: _yearController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: _isZh ? '年份' : 'Year',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) {
                            final msg = _required(v);
                            return msg.isEmpty ? null : msg;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: _isZh ? '標題' : 'Title',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) {
                            final msg = _required(v);
                            return msg.isEmpty ? null : msg;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: _isZh ? '描述' : 'Description',
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final msg = _required(v);
                      return msg.isEmpty ? null : msg;
                    },
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _locationUrlController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: _isZh ? 'Google Maps 連結' : 'Google Maps URL',
                      hintText: 'https://maps.app.goo.gl/...',
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _isZh ? '封面圖片' : 'Cover Image',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: _pickFromGallery,
                        icon: const Icon(Icons.photo_library_outlined, size: 18),
                        label: Text(_isZh ? '從相簿選擇' : 'Gallery'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  TimelineImage(
                    imagePath: _imagePathController.text.isEmpty
                        ? 'assets/timeline/placeholder.jpg'
                        : _imagePathController.text,
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(_isZh ? '取消' : 'Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _handleSave,
                          child: Text(_isZh ? '儲存' : 'Save'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

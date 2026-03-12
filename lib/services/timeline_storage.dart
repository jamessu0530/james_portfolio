import '../models/timeline_event.dart';

abstract class TimelineStorage {
  Future<List<TimelineEvent>> loadEvents();

  Future<void> saveEvents(List<TimelineEvent> events);
}

class InMemoryTimelineStorage implements TimelineStorage {
  InMemoryTimelineStorage._();

  static final InMemoryTimelineStorage instance = InMemoryTimelineStorage._();

  final List<TimelineEvent> _events = <TimelineEvent>[
    const TimelineEvent(
      id: 'timeline-2023-australia',
      year: '2023',
      title: 'Study Abroad in Australia',
      description:
          'Expanded my English communication skills and adapted to a new '
          'learning environment.',
      imagePath: 'assets/timeline/australia.jpg',
    ),
    const TimelineEvent(
      id: 'timeline-2024-hokkaido',
      year: '2024',
      title: 'Hokkaido University STEM Program',
      description:
          'Joined an international STEM program and explored academic exchange '
          'beyond Taiwan.',
      imagePath: 'assets/timeline/hokkaido.jpg',
    ),
    const TimelineEvent(
      id: 'timeline-2025-camino',
      year: '2025',
      title: 'Camino Pilgrimage Walk',
      description:
          'Completed a long-distance pilgrimage journey that strengthened my '
          'discipline, resilience, and independence.',
      imagePath: 'assets/timeline/camino.jpg',
    ),
    const TimelineEvent(
      id: 'timeline-2025-care-ai',
      year: '2025',
      title: 'Joined Prof. Ma\'s AI Lab',
      description:
          'Started developing the CARE RAG AI system for healthcare support, '
          'information retrieval, and medical misinformation detection.',
      imagePath: 'assets/timeline/care-ai.jpg',
    ),
  ];

  @override
  Future<List<TimelineEvent>> loadEvents() async {
    return _copyEvents();
  }

  @override
  Future<void> saveEvents(List<TimelineEvent> events) async {
    // Keep the API async so this service can later be replaced by Hive,
    // SharedPreferences, or any other persistent storage without changing UI code.
    _events
      ..clear()
      ..addAll(
        events.map(
          (event) => event.copyWith(),
        ),
      );
  }

  List<TimelineEvent> _copyEvents() {
    return _events.map((event) => event.copyWith()).toList(growable: true);
  }
}

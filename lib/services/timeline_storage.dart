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
      locationUrl: 'https://maps.app.goo.gl/australia',
    ),
    const TimelineEvent(
      id: 'timeline-2024-hokkaido',
      year: '2024',
      title: 'Hokkaido University STEM Program',
      description:
          'Joined an international STEM program and explored academic exchange '
          'beyond Taiwan.',
      imagePath: 'assets/timeline/hokkaido.jpg',
      locationUrl: 'https://maps.app.goo.gl/HokkaidoUniversity',
    ),
    const TimelineEvent(
      id: 'timeline-2025-camino',
      year: '2025',
      title: 'Camino Pilgrimage Walk',
      description:
          'Completed a long-distance pilgrimage journey that strengthened my '
          'discipline, resilience, and independence.',
      imagePath: 'assets/timeline/camino.jpg',
      locationUrl:
          'https://www.google.com.tw/maps/place/01100%E7%BE%A9%E5%A4%A7%E5%88%A9%E7%B6%AD%E6%B3%B0%E5%8D%9A/@42.4212357,12.0960028,15.06z/data=!4m6!3m5!1s0x132f2cf9a622dfcf:0xb50255953c6f6b43!8m2!3d42.4204278!4d12.1075465!16zL20vMG4xN24?entry=ttu&g_ep=EgoyMDI2MDMxMC4wIKXMDSoASAFQAw%3D%3D',
    ),
    const TimelineEvent(
      id: 'timeline-2025-care-ai',
      year: '2025',
      title: "Joined Prof. Ma's AI Lab",
      description:
          'Started developing the CARE RAG AI system for healthcare support, '
          'information retrieval, and medical misinformation detection.',
      imagePath: 'assets/timeline/care-ai.jpg',
      locationUrl: 'https://maps.app.goo.gl/NTOU',
    ),
  ];

  @override
  Future<List<TimelineEvent>> loadEvents() async {
    return _copyEvents();
  }

  @override
  Future<void> saveEvents(List<TimelineEvent> events) async {
    _events
      ..clear()
      ..addAll(events.map((e) => TimelineEvent.fromMap(e.toMap())));
  }

  List<TimelineEvent> _copyEvents() {
    return _events
        .map((e) => TimelineEvent.fromMap(e.toMap()))
        .toList(growable: true);
  }
}

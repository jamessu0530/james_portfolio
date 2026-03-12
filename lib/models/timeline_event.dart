class TimelineEvent {
  const TimelineEvent({
    required this.id,
    required this.year,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String id;
  final String year;
  final String title;
  final String description;
  final String imagePath;

  TimelineEvent copyWith({
    String? id,
    String? year,
    String? title,
    String? description,
    String? imagePath,
  }) {
    return TimelineEvent(
      id: id ?? this.id,
      year: year ?? this.year,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'title': title,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory TimelineEvent.fromMap(Map<String, dynamic> map) {
    return TimelineEvent(
      id: map['id'] as String? ?? '',
      year: map['year'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imagePath: map['imagePath'] as String? ?? '',
    );
  }

  static String createId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}

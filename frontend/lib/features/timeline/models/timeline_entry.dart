class TimelineEntry {
  final int? id;
  final String title;
  final String subtitle;
  final String category;
  final DateTime timestamp;

  TimelineEntry({
    this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.timestamp,
  });

  factory TimelineEntry.fromJson(Map<String, dynamic> json) {
    return TimelineEntry(
      id: json['id'],
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? json['description'] ?? '',
      category: json['category'] ?? 'general',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'category': category,
        'timestamp': timestamp.toIso8601String(),
      };
}

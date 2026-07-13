class TimelineEntryModel {
  final int id;
  final int userId;
  final String sourceType;
  final int? sourceId;
  final String title;
  final String? content;
  final DateTime occurredAt;
  final DateTime createdAt;

  TimelineEntryModel({
    required this.id,
    required this.userId,
    required this.sourceType,
    this.sourceId,
    required this.title,
    this.content,
    required this.occurredAt,
    required this.createdAt,
  });

  factory TimelineEntryModel.fromJson(Map<String, dynamic> json) {
    return TimelineEntryModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      sourceType: json['source_type'] as String,
      sourceId: json['source_id'] as int?,
      title: json['title'] as String,
      content: json['content'] as String?,
      occurredAt: DateTime.parse(json['occurred_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'source_type': sourceType,
      'source_id': sourceId,
      'title': title,
      'content': content,
      'occurred_at': occurredAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

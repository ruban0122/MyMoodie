class JournalEntity {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime date;

  JournalEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
  });

  JournalEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    DateTime? date,
  }) {
    return JournalEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  factory JournalEntity.fromMap(Map<String, dynamic> map) {
    return JournalEntity(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
    );
  }
}

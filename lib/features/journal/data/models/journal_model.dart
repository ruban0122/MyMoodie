import '../../domain/entities/journal_entity.dart';

class JournalModel extends JournalEntity {
  JournalModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }
}

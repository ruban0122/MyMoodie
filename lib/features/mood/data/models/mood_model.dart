import '../../domain/entities/mood_entity.dart';

class MoodModel extends MoodEntity {
  MoodModel({
    required super.id,
    required super.userId,
    required super.moodType,
    required super.note,
    required super.date,
  });

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moodType': moodType,
      'note': note,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      moodType: json['moodType'] as String,
      note: json['note'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'moodType': moodType,
      'note': note,
      'date': date.toIso8601String(),
    };
  }
}

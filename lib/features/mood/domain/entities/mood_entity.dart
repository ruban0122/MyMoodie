class MoodEntity {
  final String id;
  final String userId;
  final String moodType; // e.g. "happy", "sad", "angry"
  final String note;
  final DateTime date;

  MoodEntity({
    required this.id,
    required this.userId,
    required this.moodType,
    required this.note,
    required this.date,
  });
}

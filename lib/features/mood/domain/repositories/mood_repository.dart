import '../entities/mood_entity.dart';

abstract class MoodRepository {
  Future<void> addMood(MoodEntity mood);
  Future<List<MoodEntity>> getMoods(String userId);
  Future<void> updateMood(MoodEntity mood);
  Future<void> deleteMood(String id);
}

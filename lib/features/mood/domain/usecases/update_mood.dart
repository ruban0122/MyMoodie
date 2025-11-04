import 'package:mymoodie/features/mood/domain/entities/mood_entity.dart';
import '../repositories/mood_repository.dart';

class UpdateMoodEntry {
  final MoodRepository repository;

  UpdateMoodEntry(this.repository);

  Future<void> call(MoodEntity moodEntry) async {
    return await repository.updateMood(moodEntry);
  }
}

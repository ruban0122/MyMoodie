import '../entities/mood_entity.dart';
import '../repositories/mood_repository.dart';

class AddMood {
  final MoodRepository repository;

  AddMood(this.repository);

  Future<void> call(MoodEntity mood) async {
    return await repository.addMood(mood);
  }
}

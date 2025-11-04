import '../repositories/mood_repository.dart';

class DeleteMood {
  final MoodRepository repository;

  DeleteMood(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteMood(id);
  }
}

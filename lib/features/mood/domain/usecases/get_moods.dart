import '../entities/mood_entity.dart';
import '../repositories/mood_repository.dart';

class GetMoods {
  final MoodRepository repository;

  GetMoods(this.repository);

  Future<List<MoodEntity>> call(String userId) async {
    return await repository.getMoods(userId);
  }
}

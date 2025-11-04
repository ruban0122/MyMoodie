import '../../domain/entities/mood_entity.dart';
import '../../domain/repositories/mood_repository.dart';
import '../data_sources/mood_remote_data_source.dart';
import '../models/mood_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource remoteDataSource;

  MoodRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addMood(MoodEntity mood) async {
    final model = MoodModel(
      id: mood.id,
      userId: mood.userId,
      moodType: mood.moodType,
      note: mood.note,
      date: mood.date,
    );
    await remoteDataSource.addMood(model);
  }

  @override
  Future<List<MoodEntity>> getMoods(String userId) async {
    return await remoteDataSource.getMoods(userId);
  }

    @override
  Future<void> updateMood(MoodEntity moodEntry) async {
    final model = MoodModel(
      id: moodEntry.id,
      moodType: moodEntry.moodType,
      note: moodEntry.note,
      date: moodEntry.date,
      userId: moodEntry.userId,
    );
    await remoteDataSource.updateMood(model);
  }

  @override
  Future<void> deleteMood(String id) async {
    await remoteDataSource.deleteMood(id);
  }
}

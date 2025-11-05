import '../entities/journal_entity.dart';
import '../repositories/journal_repository.dart';

class GetJournals {
  final JournalRepository repository;

  GetJournals(this.repository);

  Future<List<JournalEntity>> call(String userId) async {
    return await repository.getJournals(userId);
  }
}

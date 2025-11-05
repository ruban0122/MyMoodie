import '../entities/journal_entity.dart';
import '../repositories/journal_repository.dart';

class AddJournal {
  final JournalRepository repository;

  AddJournal(this.repository);

  Future<void> call(JournalEntity journal) async {
    await repository.addJournal(journal);
  }
}

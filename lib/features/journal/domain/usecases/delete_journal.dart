import '../repositories/journal_repository.dart';

class DeleteJournal {
  final JournalRepository repository;

  DeleteJournal(this.repository);

  Future<void> call(String journalId) async {
    await repository.deleteJournal(journalId);
  }
}

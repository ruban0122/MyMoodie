import '../entities/journal_entity.dart';

abstract class JournalRepository {
  Future<void> addJournal(JournalEntity journal);
  Future<List<JournalEntity>> getJournals(String userId);
  Future<void> deleteJournal(String journalId);
}

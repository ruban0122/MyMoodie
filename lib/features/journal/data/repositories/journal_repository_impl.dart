import 'package:mymoodie/features/journal/data/data_sources/journal_firebase_datasource.dart';

import '../../domain/entities/journal_entity.dart';
import '../../domain/repositories/journal_repository.dart';


class JournalRepositoryImpl implements JournalRepository {
  final JournalFirebaseDataSource dataSource;

  JournalRepositoryImpl(this.dataSource);

  @override
  Future<void> addJournal(JournalEntity journal) async {
    await dataSource.addJournal(journal);
  }

  @override
  Future<List<JournalEntity>> getJournals(String userId) async {
    return await dataSource.getJournals(userId);
  }

  @override
  Future<void> deleteJournal(String journalId) async {
    await dataSource.deleteJournal(journalId);
  }
}

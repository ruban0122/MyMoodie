import '../../domain/entities/journal_entity.dart';

abstract class JournalEvent {}

class AddJournalEvent extends JournalEvent {
  final JournalEntity journal;
  AddJournalEvent(this.journal);
}

class GetJournalsEvent extends JournalEvent {
  final String userId;
  GetJournalsEvent(this.userId);
}

class DeleteJournalEvent extends JournalEvent {
  final String journalId;
  DeleteJournalEvent(this.journalId);
}

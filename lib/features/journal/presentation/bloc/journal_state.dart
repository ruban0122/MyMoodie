import '../../domain/entities/journal_entity.dart';

abstract class JournalState {}

class JournalInitial extends JournalState {}

class JournalLoading extends JournalState {}

class JournalLoaded extends JournalState {
  final List<JournalEntity> journals;
  JournalLoaded(this.journals);
}

class JournalSuccess extends JournalState {}

class JournalFailure extends JournalState {
  final String error;
  JournalFailure(this.error);
}

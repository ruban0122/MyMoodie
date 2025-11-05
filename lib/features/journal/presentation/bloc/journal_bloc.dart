import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymoodie/features/journal/data/data_sources/journal_firebase_datasource.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/journal_entity.dart';
import 'journal_event.dart';
import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalFirebaseDataSource dataSource;

  JournalBloc(this.dataSource) : super(JournalInitial()) {
    on<AddJournalEvent>(_onAddJournal);
    on<GetJournalsEvent>(_onGetJournals);
    on<DeleteJournalEvent>(_onDeleteJournal);
  }

  Future<void> _onAddJournal(
      AddJournalEvent event, Emitter<JournalState> emit) async {
    emit(JournalLoading());
    try {
      final newJournal = event.journal.copyWith(id: const Uuid().v4());
      await dataSource.addJournal(newJournal);
      emit(JournalSuccess());
    } catch (e) {
      emit(JournalFailure(e.toString()));
    }
  }

  Future<void> _onGetJournals(
      GetJournalsEvent event, Emitter<JournalState> emit) async {
    emit(JournalLoading());
    try {
      final journals = await dataSource.getJournals(event.userId);
      emit(JournalLoaded(journals));
    } catch (e) {
      emit(JournalFailure(e.toString()));
    }
  }

  Future<void> _onDeleteJournal(
      DeleteJournalEvent event, Emitter<JournalState> emit) async {
    try {
      await dataSource.deleteJournal(event.journalId);
      emit(JournalSuccess());
    } catch (e) {
      emit(JournalFailure(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/mood_entity.dart';
import '../../domain/usecases/add_mood.dart';
import '../../domain/usecases/get_moods.dart';
import '../../domain/usecases/delete_mood.dart';
import 'mood_event.dart';

part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final AddMood addMood;
  final GetMoods getMoods;
  final DeleteMood deleteMood;

  MoodBloc({
    required this.addMood,
    required this.getMoods,
    required this.deleteMood,
  }) : super(MoodInitial()) {
    on<AddMoodEvent>(_onAddMood);
    on<GetMoodsEvent>(_onGetMoods);
    on<DeleteMoodEvent>(_onDeleteMood);
  }

  Future<void> _onAddMood(AddMoodEvent event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      final mood = MoodEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: event.userId,
        moodType: event.moodType,
        note: event.note,
        date: DateTime.now(),
      );
      await addMood(mood);
      emit(MoodSuccess());
    } catch (e) {
      emit(MoodFailure(e.toString()));
    }
  }

  Future<void> _onGetMoods(GetMoodsEvent event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      final moods = await getMoods(event.userId);
      emit(MoodLoaded(moods));
    } catch (e) {
      emit(MoodFailure(e.toString()));
    }
  }

  Future<void> _onDeleteMood(
      DeleteMoodEvent event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      await deleteMood(event.moodId);
      emit(MoodSuccess());
    } catch (e) {
      emit(MoodFailure(e.toString()));
    }
  }
}

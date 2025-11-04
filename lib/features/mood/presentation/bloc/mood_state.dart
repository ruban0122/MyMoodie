part of 'mood_bloc.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object?> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<MoodEntity> moods;
  const MoodLoaded(this.moods);

  @override
  List<Object?> get props => [moods];
}

class MoodSuccess extends MoodState {}

class MoodFailure extends MoodState {
  final String error;
  const MoodFailure(this.error);

  @override
  List<Object?> get props => [error];
}

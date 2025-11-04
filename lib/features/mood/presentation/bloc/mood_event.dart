
import 'package:equatable/equatable.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object?> get props => [];
}

class AddMoodEvent extends MoodEvent {
  final String moodType;
  final String note;
  final String userId;

  const AddMoodEvent({
    required this.moodType,
    required this.note,
    required this.userId,
  });
}

class GetMoodsEvent extends MoodEvent {
  final String userId;

  const GetMoodsEvent(this.userId);
}

class DeleteMoodEvent extends MoodEvent {
  final String moodId;

  const DeleteMoodEvent(this.moodId);
}

part of 'timetable_bloc.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();
}


class SetTimetable extends TimetableEvent {
  final List<TimetableModel> timetables;

  SetTimetable({
    required this.timetables,
  });

  @override
  List<Object> get props => [timetables];

  @override
  String toString() => 'LoadTimetable { timetables: $timetables}';
}

class LoadTimetable extends TimetableEvent {
  @override
  List<Object> get props => [];
}

class ReverseTimetableSelect extends TimetableEvent {
  final String timetableId;
  ReverseTimetableSelect({required this.timetableId});

  @override
  List<Object> get props => [timetableId];
}

class CreateTimetable extends TimetableEvent {
  final String timetableName;
  CreateTimetable({required this.timetableName});
  @override
  List<Object?> get props => [timetableName];
}

class DeleteTimetable extends TimetableEvent {
  final String timetableId;
  DeleteTimetable({required this.timetableId});
  @override
  List<Object?> get props => [timetableId];
}

class CompleteCreateTimetable extends TimetableEvent {
  CompleteCreateTimetable();
  @override
  List<Object?> get props => [];
}




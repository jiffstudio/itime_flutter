part of 'timetable_bloc.dart';
enum LoadTimetableStatus {initial, loading, success, failure}
enum CreateTimetableStatus {initial, loading, success, failure}
enum DeleteTimetableStatus {initial, loading, success, failure}
class TimetableState extends Equatable {

  final List<BasicEvent> events;
  final List<BasicEvent> allEvents;
  final List<TimetableModel> timetables;
  final Map<String, bool> isSelected;
  final LoadTimetableStatus load;
  final CreateTimetableStatus create;
  final DeleteTimetableStatus delete;

  TimetableState({
    this.events = const [],
    this.allEvents = const [],
    this.timetables = const [],
    this.isSelected = const {},
    this.load = LoadTimetableStatus.initial,
    this.create = CreateTimetableStatus.initial,
    this.delete = DeleteTimetableStatus.initial,
  });

  @override
  List<Object> get props => [events, allEvents, timetables, isSelected, load, create, delete];

  @override
  String toString() => 'TimetableState {load: $load, create: $create}';

  TimetableState copyWith({
    List<BasicEvent>? events,
    List<BasicEvent>? allEvents,
    List<TimetableModel>? timetables,
    Map<String, bool>? isSelected,
    LoadTimetableStatus? load,
    CreateTimetableStatus? create,
    DeleteTimetableStatus? delete,
  }) => TimetableState(
    events: events ?? this.events,
    allEvents: allEvents ?? this.allEvents,
    timetables: timetables ?? this.timetables,
    isSelected: isSelected ?? this.isSelected,
    load: load ?? this.load,
    create: create ?? this.create,
    delete: delete ?? this.delete,
  );
}


import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itime_frontend/blocs/user/user_bloc.dart';
import 'package:itime_frontend/data/timetable_api.dart';
import 'package:itime_frontend/models/create_table_model.dart';
import 'package:itime_frontend/models/get_all_tables_model.dart';
import 'package:itime_frontend/models/permission_model.dart';
import 'package:itime_frontend/models/timetable_model.dart';
import 'package:itime_frontend/utils/iterable_utils.dart';
import 'package:itime_frontend/views/widgets/positioning_demo.dart';
import 'package:itime_frontend/views/widgets/term.dart';
import 'package:timetable/timetable.dart';

import '../../utils/date_utils.dart';

part 'timetable_event.dart';

part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  UserBloc userBloc;

  TimetableBloc({required this.userBloc}) : super(TimetableState());

  @override
  Stream<TimetableState> mapEventToState(
    TimetableEvent event,
  ) async* {
    if (event is SetTimetable) {
      yield* _mapSetTimetableToState(event, state);
    } else if (event is LoadTimetable) {
      yield* _mapLoadTimetableToState(event, state);
    } else if (event is ReverseTimetableSelect) {
      yield* _mapSelectTimetableToState(event, state);
    } else if (event is CreateTimetable) {
      yield* _mapCreateTimetableToState(event, state);
    } else if (event is CompleteCreateTimetable) {
      yield* _mapFinishCreateTimetableToState(event, state);
    } else if (event is DeleteTimetable) {
      yield* _mapDeleteTimetableToState(event, state);
    }
  }

  Stream<TimetableState> _mapSetTimetableToState(
      SetTimetable event, TimetableState state) async* {
    List<LessonEvent> events = event.timetables
        .map((table) => table.events.map((event) => event.time.map((time) {
              print(
                  "${event.name}: 第${time.week}周, 周${time.day}, eventId:${time.eventId}, timeId:${time.eventTimeId}, ${time.startTime}-${time.endTime}");
              return time.startTime != null
                  ? LessonEvent(
                      term: Term.byId(event.termId),
                      title: event.name,
                      week: time.week,
                      day: time.day,
                      eventId: time.eventId,
                      timeId: time.eventTimeId,
                      startTime: time.startTime!.toDuration(),
                      endTime: time.endTime!.toDuration(),
                      timetableId: table.tableId,
                    )
                  : LessonEvent.allDay(
                      time.eventId,
                      0,
                      3,
                      title: event.name,
                      week: time.week,
                      day: time.day,
                      eventId: time.eventId,
                      timeId: time.eventTimeId,
                      term: Term.byId(event.termId),
                      timetableId: table.tableId,
                    );
            })))
        .flatten<LessonEvent>()
        .toSet()
        .toList();
    yield TimetableState().copyWith(
      load: LoadTimetableStatus.success,
      allEvents: events,
      timetables: event.timetables,
      events: events,
    );
  }

  Stream<TimetableState> _mapLoadTimetableToState(
      LoadTimetable event, TimetableState state) async* {
    try {
      yield state.copyWith(load: LoadTimetableStatus.loading);
      GetAllTablesModel response = await TimetableApi()
          .getAllTimetables(termId: "2021-20221", pwd: 'Jiff99++');
      yield* _mapSetTimetableToState(
          SetTimetable(timetables: response.data), state);
    } catch (e) {
      addError(e);
      yield state.copyWith(load: LoadTimetableStatus.failure);
    }
  }

  Stream<TimetableState> _mapSelectTimetableToState(
      ReverseTimetableSelect event, TimetableState state) async* {
    bool select = state.isSelected[event.timetableId] ?? true;
    Map<String, bool> isSelected = Map.from(state.isSelected);
    select = !select;
    isSelected[event.timetableId] = select;
    List<BasicEvent> events = state.allEvents
        .where(
            (event) => isSelected[(event as LessonEvent).timetableId] ?? true)
        .toList();
    yield state.copyWith(events: events, isSelected: isSelected);
  }

  Stream<TimetableState> _mapCreateTimetableToState(
      CreateTimetable event, TimetableState state) async* {
    try {
      yield state.copyWith(create: CreateTimetableStatus.loading);
      CreateTableModel response = await TimetableApi()
          .createTimetable(tableName: event.timetableName, tableType: "个人活动表");
      List<TimetableModel> timetables = List.from(state.timetables);
      String userId = (userBloc.state as UserLogged).data.id;
      timetables.add(TimetableModel(
        tableName: event.timetableName,
        type: "个人活动表",
        tableId: response.data.tableId,
        events: [],
        permission: [
          PermissionModel(
              userId: userId,
              tableId: response.data.tableId,
              read: true,
              edit: true,
              insert: true,
              delete: true)
        ],
        ownerId: userId,
      ));
      yield state.copyWith(
          timetables: timetables, create: CreateTimetableStatus.success);
    } catch (e) {
      addError(e);
      yield state.copyWith(create: CreateTimetableStatus.failure);
    }
  }

  Stream<TimetableState> _mapFinishCreateTimetableToState(
      CompleteCreateTimetable event, TimetableState state) async* {
    yield state.copyWith(create: CreateTimetableStatus.initial);
  }

  Stream<TimetableState> _mapDeleteTimetableToState(
      DeleteTimetable event, TimetableState state) async* {
    try {
      yield state.copyWith(delete: DeleteTimetableStatus.loading);
      await TimetableApi()
          .deleteTimetable(tableId: event.timetableId);
      List<TimetableModel> timetables = List.from(state.timetables);
      timetables.removeWhere((table) => table.tableId == event.timetableId);
      yield state.copyWith(
          timetables: timetables, delete: DeleteTimetableStatus.success);
    } catch (e) {
      addError(e);
      yield state.copyWith(delete: DeleteTimetableStatus.failure);
    }
  }
// Stream<TimetableState> _mapLoadTimetableWeekToState(
//     Settings settings,
//     DateTime weekStart,
//     ) async* {
//   if (settings.semester == null ||
//       settings.course == null ||
//       settings.lectures == null ||
//       settings.lectures!.length == 0) {
//     yield TimetableEmpty();
//   } else {
//     final timetable = <int, List<TimetableEntry>>{};
//
//     final newTimetable = await SplanApi().getTimetableWeek(
//       // Hard coded due to disabled location selection.
//       location: Location(id: 3),
//       semester: settings.semester!,
//       lectures: settings.lectures!,
//       weekStart: weekStart,
//     );
//
//     if (state is TimetableLoaded) {
//       final oldState = (state as TimetableLoaded);
//       // Only add old data if the same settings were used to load it
//       if (oldState.loadedWithSettings.semester == settings.semester &&
//           oldState.loadedWithSettings.course == settings.course &&
//           listEquals(
//             oldState.loadedWithSettings.lectures,
//             settings.lectures,
//           )) {
//         timetable.addAll((state as TimetableLoaded).timetable);
//       }
//     }
//
//     final baseInt = settings.semester!.startDate
//         .differenceInDaysWithoutWeekends(weekStart);
//
//     if (newTimetable != null) {
//       for (final entry in newTimetable.entries) {
//         timetable[baseInt + entry.key] = entry.value;
//       }
//     }
//
//     yield TimetableLoaded(
//       loadedWithSettings: settings,
//       timetable: timetable,
//     );
//   }
// }
}

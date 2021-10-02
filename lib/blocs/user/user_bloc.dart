import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:itime_frontend/data/user_api.dart';
import 'package:itime_frontend/models/login_model.dart';
import 'package:itime_frontend/views/widgets/term.dart';
import 'package:timetable/timetable.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is Login) {
      yield* _mapUserLoginToState(event, state);
    } else if (event is Unauthorize) yield UserInitial();
  }

  Stream<UserState> _mapUserLoginToState(Login event, UserState state) async* {
    late LoginModel response;
    try {
      yield UserLogging();
      response = await UserApi()
          .login(studentId: event.studentId, pwd: event.password);

      List<Term> terms = response.data.timeNodes.map(
        (timeNode) {
          print('Term Info:');
          print(timeNode.startDate);
          print(Week.forDate(timeNode.startDate).getDayOfWeek(1));
          return Term.fromWeek(Week.forDate(timeNode.startDate),
              weeks: timeNode.weekNum,
              termId: timeNode.termId,
              name: timeNode.termId);
        },
      ).toList();
      Term.terms = terms;
      yield UserLogged(response.data);
    } catch (e) {
      addError(e);
      yield UserLoginFail();
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty)
      return UserLogged(Data.fromJson(json));
    else
      return UserInitial();
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserLogged)
      return state.data.toJson();
    else
      return null;
  }
}

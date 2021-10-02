part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLogging extends UserState {
  @override
  List<Object> get props => [];
}

class UserLogged extends UserState{

  final Data data;

  UserLogged(this.data);

  @override
  List<Object?> get props => [data];
}

class UserLoginFail extends UserState{
  @override
  List<Object?> get props => [];
}
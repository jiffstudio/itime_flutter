part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class Login extends UserEvent {
  Login(this.studentId, this.password);

  final String studentId;
  final String password;

  @override
  List<Object?> get props => [studentId, password];
}

class Unauthorize extends UserEvent {
  Unauthorize();

  @override
  List<Object?> get props => [];
}
part of 'token_cubit.dart';

abstract class TokenState extends Equatable {
  const TokenState();
}

class TokenInitial extends TokenState {
  @override
  List<Object> get props => [];
}

class TokenLoaded extends TokenState {
  final TokenModel token;

  TokenLoaded(this.token);

  @override
  List<Object?> get props => [token];

}

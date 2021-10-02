import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:itime_frontend/models/token_model.dart';

part 'token_state.dart';

class TokenCubit extends HydratedCubit<TokenState> {
  TokenCubit() : super(TokenInitial());

  void setToken(TokenModel token) => emit(TokenLoaded(token));

  @override
  TokenState fromJson(Map<String, dynamic> json) {
    return TokenLoaded(TokenModel.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(TokenState state) {
    if (state is TokenLoaded)
      return state.token.toJson();
    return Map();
  }
}

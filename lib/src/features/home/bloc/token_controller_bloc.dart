import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication_repository.dart';
import 'package:flutter_bloc_auth/src/authentication/token_data_source.dart';

part 'token_controller_event.dart';
part 'token_controller_state.dart';

class TokenControllerBloc
    extends Bloc<TokenControllerEvent, TokenControllerState> {
  final TokenDataSource tokenDataSource = TokenDataSource();
  final AuthenticationRepository authenticationRepository;

  TokenControllerBloc({required this.authenticationRepository})
      : super(TokenControllerInitial()) {
    on<RetrieveTokens>(_onRetrieveTokens);
    on<RefreshTokens>(_onRefreshTokens);
    on<VerifyAccessToken>(_onVerifyAccessToken);
  }

  _onRetrieveTokens(
    RetrieveTokens event,
    Emitter<TokenControllerState> emit,
  ) async {
    emit(TokenControllerLoading());
    final accessToken = await tokenDataSource.getAccessToken();
    final refreshToken = await tokenDataSource.getRefreshToken();
    emit(TokenControllerLoaded(
      accessToken: accessToken ?? 'no token',
      refreshToken: refreshToken ?? 'no token',
    ));
  }

  _onRefreshTokens(
    RefreshTokens event,
    Emitter<TokenControllerState> emit,
  ) async {
    emit(TokenControllerLoading());
    await authenticationRepository.refreshToken();
    final accessToken = await tokenDataSource.getAccessToken();
    final refreshToken = await tokenDataSource.getRefreshToken();
    emit(TokenControllerLoaded(
      accessToken: accessToken ?? 'no token',
      refreshToken: refreshToken ?? 'no token',
    ));
  }

  _onVerifyAccessToken(
    VerifyAccessToken event,
    Emitter<TokenControllerState> emit,
  ) async {
    await authenticationRepository.verifyAccessToken();
  }
}

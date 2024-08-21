import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_auth/src/authentication/repository.dart';
import 'package:flutter_bloc_auth/src/authentication/data/token_data_source.dart';
import 'package:flutter_bloc_auth/src/features/hello/hello_repository.dart';

part 'token_controller_event.dart';
part 'token_controller_state.dart';

class TokenControllerBloc
    extends Bloc<TokenControllerEvent, TokenControllerState> {
  final TokenDataSource tokenDataSource = TokenDataSource();
  final AuthenticationRepository authenticationRepository;
  final HelloRepository helloRepository;

  TokenControllerBloc({
    required this.authenticationRepository,
    required this.helloRepository,
  }) : super(TokenControllerInitial()) {
    on<RetrieveTokens>(_onRetrieveTokens);
    on<RefreshTokens>(_onRefreshTokens);
    on<VerifyAccessToken>(_onVerifyAccessToken);
    on<GetRequest>(_onGetRequest);
    on<ExpireSession>(_onExpireSession);
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

  _onGetRequest(
    GetRequest event,
    Emitter<TokenControllerState> emit,
  ) async {
    await helloRepository.hello();
  }

  _onExpireSession(
    ExpireSession event,
    Emitter<TokenControllerState> emit,
  ) async {
    await authenticationRepository.expireSession();
  }
}

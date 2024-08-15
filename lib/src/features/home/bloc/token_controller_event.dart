part of 'token_controller_bloc.dart';

sealed class TokenControllerEvent extends Equatable {
  const TokenControllerEvent();

  @override
  List<Object> get props => [];
}

final class RetrieveTokens extends TokenControllerEvent {}

final class RefreshTokens extends TokenControllerEvent {}

final class VerifyAccessToken extends TokenControllerEvent {}

part of 'token_controller_bloc.dart';

sealed class TokenControllerState extends Equatable {
  const TokenControllerState();

  @override
  List<Object> get props => [];
}

final class TokenControllerInitial extends TokenControllerState {}

final class TokenControllerLoading extends TokenControllerState {}

final class TokenControllerLoaded extends TokenControllerState {
  const TokenControllerLoaded({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  @override
  List<Object> get props => [accessToken, refreshToken];
}

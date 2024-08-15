import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication_repository.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';
import 'package:flutter_bloc_auth/src/core/widgets.dart';
import 'package:flutter_bloc_auth/src/features/hello/hello_repository.dart';
import 'package:flutter_bloc_auth/src/features/home/bloc/token_controller_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = RouteName.homePage;
  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HelloRepository(),
      child: BlocProvider(
        create: (context) => TokenControllerBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          helloRepository: RepositoryProvider.of<HelloRepository>(context),
        )..add(RetrieveTokens()),
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TokenInfoBuilder(),
            Spacer(),
            TokenControllerButtons(),
            Spacer(),
            Logout(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class TokenInfoBuilder extends StatelessWidget {
  const TokenInfoBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenControllerBloc, TokenControllerState>(
      builder: (context, state) {
        switch (state) {
          case TokenControllerInitial():
            return Text('Press \'Retrieve Tokens\' button to get tokens');
          case TokenControllerLoading():
            return const CircularProgressIndicator();
          case TokenControllerLoaded():
            return TokenInfo(
              accessToken: state.accessToken,
              refreshToken: state.refreshToken,
            );
        }
      },
    );
  }
}

class TokenInfo extends StatelessWidget {
  const TokenInfo({
    super.key,
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Wrap(children: [Text('Access: $accessToken')]),
          SizedBox(height: 8),
          Wrap(children: [Text('Refresh: $refreshToken')]),
        ],
      ),
    );
  }
}

class TokenControllerButtons extends StatelessWidget {
  const TokenControllerButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DisplayButtonWidget(
          text: 'Get Request',
          onPressed: () {
            BlocProvider.of<TokenControllerBloc>(context).add(GetRequest());
          },
        ),
        SizedBox(height: 4),
        DisplayButtonWidget(
          text: 'Refresh',
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            BlocProvider.of<TokenControllerBloc>(context).add(RefreshTokens());
          },
        ),
        SizedBox(height: 4),
        DisplayButtonWidget(
          text: 'Verify',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            BlocProvider.of<TokenControllerBloc>(context)
                .add(VerifyAccessToken());
          },
        ),
      ],
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DisplayButtonWidget(
      text: 'Logout',
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationLogoutRequested());
      },
    );
  }
}

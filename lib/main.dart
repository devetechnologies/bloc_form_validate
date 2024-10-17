import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_form_validate/authentication/bloc/authentication_bloc.dart';
import 'splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'home/home.dart';
import 'login/view/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationrepository;
  late final UserRepository _userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticationrepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _authenticationrepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationrepository,
      child: BlocProvider(
          lazy: false,
          create: (context) => AuthenticationBloc(
              authenticationRepository: _authenticationrepository,
              userRepository: _userRepository)
            ..add(AuthenticationSubscriptionRequested()),
          child: const AppView()),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.autheticated:
                  _navigator.pushAndRemoveUntil<void>(
                      HomePage.route(), (route) => false);

                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(), (route) => false);
                case AuthenticationStatus.uknown:
                  print('Intooooo');
                  break;
                // TODO: Handle this case.
              }
            },
            child: const SplashPage());
      },
      onGenerateRoute: (settings) {
        return null;
      },
    );
  }
}

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.uknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  FutureOr<void> _onSubscriptionRequested(
      AuthenticationSubscriptionRequested event,
      Emitter<AuthenticationState> emit) {
    return emit.onEach(_authenticationRepository.status,
        onData: (status) async {
      switch (status) {
        case AuthenticationStatus.unauthenticated:
          return emit(const AuthenticationState.unauthenticated());
        case AuthenticationStatus.autheticated:
          final user = await _tryGetUser();
          return emit(user != null
              ? AuthenticationState.autheticated(user)
              : const AuthenticationState.unauthenticated());
        case AuthenticationStatus.uknown:
          return emit(const AuthenticationState.uknown());
        default:
      }
    }, onError: addError);
  }

  FutureOr<void> _onLogoutPressed(
      AuthenticationLogoutPressed event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}

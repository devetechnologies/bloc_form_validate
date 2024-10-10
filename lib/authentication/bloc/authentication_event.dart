part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationSubscriptionRequested extends AuthenticationEvent {}

final class AuthenticationLogoutPressed extends AuthenticationEvent {}

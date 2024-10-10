part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.uknown,
    this.user = User.empty,
  });

  final AuthenticationStatus status;
  final User user;

  const AuthenticationState.uknown() : this._();

  const AuthenticationState.autheticated(User user)
      : this._(status: AuthenticationStatus.autheticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}

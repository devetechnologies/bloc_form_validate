import 'dart:async';

enum AuthenticationStatus {
  uknown,
  autheticated,
  unathenticated,
  unauthenticated
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unathenticated;
    yield* _controller.stream;
  }

  Future login({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.autheticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unathenticated);
  }

  void dispose() => _controller.close();
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository authenticationrepositoryl;
  late final UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

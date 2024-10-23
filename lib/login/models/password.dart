import 'package:formz/formz.dart';

enum PasswordvalidationError { empty }

class Password extends FormzInput<String, PasswordvalidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();
  @override
  PasswordvalidationError? validator(String value) {
    if (value.isEmpty) return PasswordvalidationError.empty;
    return null;
  }
}

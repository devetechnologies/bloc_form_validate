import 'package:formz/formz.dart';

enum EmainValidationError { empty }

class Email extends FormzInput<String, EmainValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  // Define a regex for basic email validation
  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  @override
  EmainValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmainValidationError.empty;
  }
}

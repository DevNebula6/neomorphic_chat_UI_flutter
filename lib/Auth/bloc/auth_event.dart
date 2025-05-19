
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
 const AuthEvent();
}

class AuthEventInitialise extends AuthEvent {
  const AuthEventInitialise();
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventSignIn({required this.email,required this.password});
}
class AuthEventRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const AuthEventRegister({required this.name,required this.email,required this.password});
}

class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();
}
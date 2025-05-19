
import 'package:flutter/material.dart';
import 'package:neomorphic_chat_flutter/models/user_model.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}


class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}


class AuthStateLoggedIn extends AuthState {
  final UserModel user;
  final Exception? exception;
  
  const AuthStateLoggedIn({
    required this.user,
    required super.isLoading,
    this.exception,
  });
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;

  const AuthStateLoggedOut({
    required super.isLoading,
    this.exception,
  });
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  
  const AuthStateRegistering({
    required super.isLoading,
    super.loadingText = null,
    this.exception,
  });
}
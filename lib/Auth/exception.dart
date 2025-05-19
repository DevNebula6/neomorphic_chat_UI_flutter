/// Base exception class for authentication-related errors
class AuthException implements Exception {
  final String message;
  
  AuthException(this.message);
  
  @override
  String toString() => 'AuthException: $message';
}

/// Exception thrown when user provides invalid credentials
class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException([super.message = 'Invalid username or password']);
}

/// Exception thrown when user is not found
class UserNotFoundException extends AuthException {
  UserNotFoundException([super.message = 'User not found']);
}

/// Exception thrown during registration process
class RegistrationException extends AuthException {
  RegistrationException([super.message = 'Registration failed']);
}

class UserAlreadyExistsException extends AuthException {
  UserAlreadyExistsException([super.message = 'User already exists']);
}
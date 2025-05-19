import 'package:neomorphic_chat_flutter/Auth/auth_provider.dart';
import 'package:neomorphic_chat_flutter/Auth/cache_manager.dart';
import 'package:neomorphic_chat_flutter/Auth/exception.dart';
import 'package:neomorphic_chat_flutter/models/user_model.dart';

class MockAuthProvider implements AuthProvider {
  final CacheManager _cacheManager;
  UserModel? _currentUser;
  bool _isInitialized = false;

  MockAuthProvider(this._cacheManager);

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Future<void> initialize() async {
    // Check if user is already logged in from cached data
    final userData = _cacheManager.getCurrentUserData();
    
    // If we have cached user data, restore the current user
    if (userData['id'] != null && userData['email'] != null) {
      _currentUser = UserModel(
        id: userData['id']!,
        name: userData['name'] ?? 'User',
        email: userData['email']!,
      );
      print('User restored from cache: ${_currentUser?.name}');
    }

    // Print all cached users for debugging
    _cacheManager.printAllUsers();

    _isInitialized = true;
  }

  @override
  Future<void> logout() async {
    await _cacheManager.clearCurrentUser();
    _currentUser = null;
    print('User logged out');
  }
  
  // Login with email and password
  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      if (!_isInitialized) {
        print('WARNING: Provider not initialized before login/register call');
        await initialize();
      }
      print('Attempting login with email: $email');
      
      // Verify credentials
      if (_cacheManager.verifyCredentials(email, password)) {
        // Get user data
        final user = _cacheManager.getUserByEmail(email);
        if (user != null) {
          // Create user model
          _currentUser = UserModel(
            id: user['id'],
            name: user['name'],
            email: user['email'],
            password: password,
          );
          
          // Save current user to cache
          await _cacheManager.saveCurrentUser(
            _currentUser!.id,
            _currentUser!.name,
            _currentUser!.email,
          );

          print('Login successful for user: ${_currentUser!.email}');

          return _currentUser!;
        }
      }
      return null; // Login failed
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }
  
  // Register new user
  @override
  Future<UserModel?> register(String name, String email, String password) async {
    try {
      if (!_isInitialized) {
        print('WARNING: Provider not initialized before login/register call');
        await initialize();
      }
      print('Attempting registration for email: $email');
      
      // Check if user already exists
      if (_cacheManager.getUserByEmail(email) != null) {
        print('User already exists with email: $email');
        throw UserAlreadyExistsException();
      }
      
      // Save user to cache
      final success = await _cacheManager.saveUser(name, email, password);
      
      if (!success) {
        print('Unknown error during user registration');
        throw RegistrationException('Failed to save user data');
      }
      
      // Get user data (should not be null at this point)
      final user = _cacheManager.getUserByEmail(email);
      if (user == null) {
        print('Unexpected: User not found after registration');
        throw RegistrationException('User saved but not retrievable');
      }
      
      // Create user model
      _currentUser = UserModel(
        id: user['id'],
        name: user['name'],
        email: user['email'],
      );
      
      // Save current user to cache
      await _cacheManager.saveCurrentUser(
        _currentUser!.id,
        _currentUser!.name,
        _currentUser!.email,
      );
      
      print('Registration successful for user: ${_currentUser!.email}');
      return _currentUser;
    } catch (e) {
      print('Registration error: $e');
      rethrow; // Important: rethrow to let AuthBloc handle it
    }
  }
}
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  final SharedPreferences _prefs;
  
  CacheManager(this._prefs) {
    initializeCache();
  }
  
  void initializeCache() {
    // Check if this is the first time initializing the cache
    if (!_prefs.containsKey('cache_initialized')) {
      // Set default values for first-time initialization
      _prefs.setBool('cache_initialized', true);
      _prefs.setString('last_cache_init', DateTime.now().toIso8601String());
      
      // Initialize empty users list if not exists
      if (!_prefs.containsKey('users')) {
        _prefs.setString('users', jsonEncode([]));
      }
    } else {
      // Update the last initialization timestamp
      _prefs.setString('last_cache_init', DateTime.now().toIso8601String());
    }
  }
  
  // User authentication methods
  Future<void> saveCurrentUser(String id, String name, String email) async {
    await _prefs.setString('user_id', id);
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
  }
  
  Future<void> clearCurrentUser() async {
    await _prefs.remove('user_id');
    await _prefs.remove('user_name');
    await _prefs.remove('user_email');
  }
  
  // Get current user data
  Map<String, String?> getCurrentUserData() {
    return {
      'id': _prefs.getString('user_id'),
      'name': _prefs.getString('user_name'),
      'email': _prefs.getString('user_email'),
    };
  }
  
  // User registration and credential storage
  Future<bool> saveUser(String name, String email, String password) async {
    try {
      // Check if user already exists
      if (getUserByEmail(email) != null) {
        print("User already exists");
        return false; // User already exists
      }
      
      // Get current users list
      List<dynamic> users = jsonDecode(_prefs.getString('users') ?? '[]');
      
      // Add new user
      users.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'email': email,
        'password': password,
      });
      
      // Save updated users list
      await _prefs.setString('users', jsonEncode(users));
      return true;
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }
  
  // Find user by email
  Map<String, dynamic>? getUserByEmail(String email) {
    try {
      List<dynamic> users = jsonDecode(_prefs.getString('users') ?? '[]');
      for (var user in users) {
        if (user['email'] == email) {
          return user;
        }
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
  
  // Verify user credentials
  bool verifyCredentials(String email, String password) {
    final user = getUserByEmail(email);
    if (user != null && user['password'] == password) {
      return true;
    }
    return false;
  }

  // Get current users list for debugging
  List<Map<String, dynamic>> getAllUsers() {
    try {
      List<dynamic> users = jsonDecode(_prefs.getString('users') ?? '[]');
      return List<Map<String, dynamic>>.from(users);
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }

  // Debug method to print all users
  void printAllUsers() {
    final users = getAllUsers();
    print('------ All Users in Cache ------');
    print('Total users: ${users.length}');
    for (var user in users) {
      print('User: ${user['name']} (${user['email']}-pass(${user['password']}))');
    }
    print('-------------------------------');
  }
}
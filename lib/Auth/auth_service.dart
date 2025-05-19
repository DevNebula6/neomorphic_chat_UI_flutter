import 'package:neomorphic_chat_flutter/Auth/auth_provider.dart';
import 'package:neomorphic_chat_flutter/Auth/cache_manager.dart';
import 'package:neomorphic_chat_flutter/Auth/mock_auth_provider.dart';
import 'package:neomorphic_chat_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);
  
static Future<AuthService> mockBackend() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheManager = CacheManager(prefs);
    return AuthService(MockAuthProvider(cacheManager));
  }
  @override
  Future<void> initialize() => (provider.initialize());

  @override
  UserModel? get currentUser => provider.currentUser;
  
  @override
  Future<void> logout() => provider.logout();
  
  @override
  Future<UserModel?> login(String email, String password) => provider.login(email, password);

  @override
  Future<UserModel?> register(String name,String email, String password) => provider.register(name, email, password);
}
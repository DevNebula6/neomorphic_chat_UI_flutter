
import 'package:neomorphic_chat_flutter/models/user_model.dart';

abstract class AuthProvider {
  
  Future<void> initialize();
  UserModel? get currentUser;
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> register(String name,String email, String password);
  Future<void> logout();

}

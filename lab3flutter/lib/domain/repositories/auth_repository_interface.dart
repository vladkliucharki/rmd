import 'package:lab2flutter/domain/models/user_model.dart';

abstract class IAuthRepository {
  Future<bool> register(User user);
  Future<User?> login(String email, String password);
  Future<User?> getCurrentUser();
  Future<void> logout();
}

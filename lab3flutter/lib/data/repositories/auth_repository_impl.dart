// lib/data/repositories/auth_repository_impl.dart
import 'package:lab2flutter/domain/models/user_model.dart';
import 'package:lab2flutter/domain/repositories/auth_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements IAuthRepository {
  static const String _allUsersKey = 'all_users_database';
  static const String _currentUserKey = 'current_active_user';

  @override
  Future<bool> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    
    final List<String> usersJsonList = prefs.getStringList(_allUsersKey) ?? [];

    for (String userStr in usersJsonList) {
      final existingUser = User.fromJson(userStr);
      if (existingUser.email == user.email) {
        return false; 
      }
    }

    usersJsonList.add(user.toJson());

    return await prefs.setStringList(_allUsersKey, usersJsonList);
  }

  @override
  Future<User?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    final List<String> usersJsonList = prefs.getStringList(_allUsersKey) ?? [];

    User? foundUser;
    try {
      // firstWhere знайде першого, хто підходить під умову
      final userStr = usersJsonList.firstWhere((str) {
        final u = User.fromJson(str);
        return u.email == email && u.password == password;
      });
      foundUser = User.fromJson(userStr);
    } catch (e) {
      return null;
    }

    await prefs.setString(_currentUserKey, foundUser.toJson());
    return foundUser;
  
  }

  @override
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_currentUserKey);
    
    if (userString != null) {
      return User.fromJson(userString);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }
}

import 'package:flutter/material.dart';
import 'package:lab2flutter/data/repositories/auth_repository_impl.dart';
import 'package:lab2flutter/domain/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final _repo = AuthRepositoryImpl();
  
  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkAuth() async {
    _user = await _repo.getCurrentUser();
    notifyListeners(); // Оновити всі екрани, які слухають цей провайдер
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    _user = await _repo.login(email, password);

    _isLoading = false;
    notifyListeners();
    
    return _user != null; // Повертає true, якщо вхід успішний
  }

  Future<bool> register(User newUser) async {
    _isLoading = true;
    notifyListeners();

    final success = await _repo.register(newUser);

    _isLoading = false;
    notifyListeners();
    
    return success;
  }

  Future<void> logout() async {
    await _repo.logout();
    _user = null;
    notifyListeners();
  }
}

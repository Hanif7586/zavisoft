import 'package:flutter/material.dart';
import '../core/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;
  bool isLoggedIn = false;

  Future<void> login(String username, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      isLoggedIn = await _api.login(username, password);
    } catch (_) {
      isLoggedIn = false;
    }

    isLoading = false;
    notifyListeners();
  }
}
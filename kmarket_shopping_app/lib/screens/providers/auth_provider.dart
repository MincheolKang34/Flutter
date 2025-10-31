import 'package:flutter/material.dart';
import 'package:kmarket_shopping/services/token_storage_service.dart';

class AuthProvider with ChangeNotifier {
  final _tokenStorageService = TokenStorageService();

  // 로그인 여부 상태
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    // 앱 실행 시 로그인 여부 검사
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await _tokenStorageService.readToken();

    if (token != null) {
      _isLoggedIn = true;
      // 해당 Provider를 구독하고 있는 Consumer 알림
      notifyListeners();
    }
  }

  Future<void> login(String token) async {
    await _tokenStorageService.saveToken(token);
    _isLoggedIn = true;

    // 해당 Provider를 구독하고 있는 Consumer 알림
    notifyListeners();
  }

  Future<void> logout() async {
    await _tokenStorageService.deleteToken();
    _isLoggedIn = false;
    notifyListeners();
  }
}
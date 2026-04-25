// lib/services/auth_service.dart
import 'package:modernlogintute/services/api_services.dart';

class AuthService {
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> logout() async {
    await ApiService.logout();
  }
}

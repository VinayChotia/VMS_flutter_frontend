// lib/services/auth_service.dart
import 'package:modernlogintute/services/api_services.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static Future<bool> isLoggedIn() async {
    // Try to get token with a small retry mechanism for Flutter Web refresh resilience
    int retries = 3;
    while (retries > 0) {
      final token = await ApiService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        return true;
      }
      
      if (kIsWeb) {
        // On web, give SharedPreferences a tiny bit of time to sync if it returned null
        await Future.delayed(const Duration(milliseconds: 100));
      } else {
        break; // No retry on mobile for now
      }
      retries--;
    }
    
    return false;
  }

  static Future<void> logout() async {
    await ApiService.logout();
  }
}

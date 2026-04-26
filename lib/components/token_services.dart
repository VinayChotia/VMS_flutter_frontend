// // lib/services/token_service.dart
// import 'package:shared_preferences/shared_preferences.dart';

// class TokenService {
//   static const String _accessTokenKey = 'access_token';
//   static const String _refreshTokenKey = 'refresh_token';

//   // Save tokens after login
//   static Future<void> saveTokens(String accessToken, String refreshToken) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_accessTokenKey, accessToken);
//     await prefs.setString(_refreshTokenKey, refreshToken);
//   }

//   // Get access token
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_accessTokenKey);
//   }

//   // Get refresh token
//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_refreshTokenKey);
//   }

//   // Clear tokens on logout
//   static Future<void> clearTokens() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_accessTokenKey);
//     await prefs.remove(_refreshTokenKey);
//   }

//   // Check if user is logged in
//   static Future<bool> isLoggedIn() async {
//     final token = await getAccessToken();
//     return token != null && token.isNotEmpty;
//   }
// }

// lib/services/token_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  // static const String baseUrl = 'http://127.0.0.1:8000/account';
  static const String baseUrl = 'https://vms-backend-drf-avdygnb6afcchbhg.centralindia-01.azurewebsites.net/account';

  // Save tokens after login
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Clear tokens on logout
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Get visitor access matrix to check section approvals
  static Future<Map<String, dynamic>> getVisitorAccessMatrix(
      int visitorId) async {
    final token = await getAccessToken();
    if (token == null) throw Exception('No token found');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/visitors/$visitorId/access-matrix/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to get access matrix: ${response.statusCode}');
        return {'sections': []};
      }
    } catch (e) {
      print('Error getting access matrix: $e');
      return {'sections': []};
    }
  }

  // Get pending sections for a visitor
  static Future<Map<String, dynamic>> getVisitorPendingSections(
      int visitorId) async {
    final token = await getAccessToken();
    if (token == null) throw Exception('No token found');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/visitors/$visitorId/pending-sections/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to get pending sections: ${response.statusCode}');
        return {'pending_sections': []};
      }
    } catch (e) {
      print('Error getting pending sections: $e');
      return {'pending_sections': []};
    }
  }
}

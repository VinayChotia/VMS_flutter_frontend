// lib/services/api_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  // static const String baseUrl = 'http://127.0.0.1:8000';
  static const String baseUrl = 'https://vms-backend-drf-new.azurewebsites.net';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Store tokens using SharedPreferences (works on web)
  static Future<void> storeTokens(
      String accessToken, String refreshToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, accessToken);
      await prefs.setString(_refreshTokenKey, refreshToken);
      print('✅ Tokens stored successfully in SharedPreferences');
      print(
          'Access token preview: ${accessToken.substring(0, accessToken.length > 30 ? 30 : accessToken.length)}...');

      // Verify immediately
      final verifyToken = await getAccessToken();
      print('Verification - Token exists: ${verifyToken != null}');
    } catch (e) {
      print('❌ Error storing tokens: $e');
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_accessTokenKey);
      print(
          'Getting access token: ${token != null ? "✅ Found" : "❌ Not found"}');
      return token;
    } catch (e) {
      print('❌ Error getting token: $e');
      return null;
    }
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshTokenKey);
    } catch (e) {
      print('Error getting refresh token: $e');
      return null;
    }
  }

  // Clear tokens on logout
  static Future<void> clearTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_refreshTokenKey);
      print('✅ Tokens cleared');
    } catch (e) {
      print('Error clearing tokens: $e');
    }
  }

  // Get headers with authorization
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getAccessToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Refresh token
  static Future<bool> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/account/auth/refresh/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await storeTokens(data['access'], refreshToken);
        print('✅ Token refreshed successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }

  // Make authenticated request with automatic token refresh
  static Future<http.Response> authenticatedRequest(
    Future<http.Response> Function() requestFn,
  ) async {
    try {
      final response = await requestFn();

      // If unauthorized, try to refresh token and retry
      if (response.statusCode == 401) {
        print('Token expired, attempting refresh...');
        final refreshed = await refreshToken();
        if (refreshed) {
          print('Token refreshed, retrying request...');
          return await requestFn();
        } else {
          await clearTokens();
          throw Exception('Session expired. Please login again.');
        }
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Get dashboard counts
  static Future<Map<String, dynamic>> getDashboardCounts() async {
    print('📊 Fetching dashboard counts...');
    final token = await getAccessToken();
    if (token == null) {
      print('❌ No token available for dashboard counts');
      throw Exception('No authentication token found. Please login first.');
    }

    print('✅ Token available, making API call...');
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/dashboard-counts/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('✅ Dashboard counts loaded: $data');
      return data;
    } else {
      print('❌ Failed to load dashboard counts: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to load dashboard counts: ${response.statusCode}');
    }
  }

  // Get my pending section approvals
  static Future<Map<String, dynamic>> getMyPendingSectionApprovals() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/api/my-pending-section-approvals/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load approvals: ${response.statusCode}');
      throw Exception(
          'Failed to load pending approvals: ${response.statusCode}');
    }
  }

  // Login method
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    print('🔐 Attempting login for email: $email');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/account/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Login status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ Login successful!');
        print('Response contains access token: ${data.containsKey('access')}');
        print(
            'Response contains refresh token: ${data.containsKey('refresh')}');

        final String accessToken = data['access'];
        final String refreshToken = data['refresh'];

        if (accessToken.isEmpty || refreshToken.isEmpty) {
          throw Exception('Tokens are empty in response');
        }

        await storeTokens(accessToken, refreshToken);

        final savedToken = await getAccessToken();
        if (savedToken == null) {
          throw Exception('Failed to save tokens');
        }

        print('✅ Login completed successfully with token storage');
        return data;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Login failed';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('❌ Login error: $e');
      rethrow;
    }
  }

  // Logout method
  static Future<void> logout() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        await http.post(
          Uri.parse('$baseUrl/account/auth/logout/'),
          headers: await getAuthHeaders(),
          body: json.encode({'refresh': refreshToken}),
        );
      }
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      await clearTokens();
    }
  }

  // ==================== NOTIFICATION METHODS ====================

  static Future<List<dynamic>> getNotifications() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/api/notifications/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  static Future<void> markNotificationRead(int notificationId) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/api/notifications/$notificationId/mark-read/'),
        headers: headers,
      );
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to mark notification as read');
    }
  }

  static Future<void> markAllNotificationsRead() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/api/notifications/mark-all-read/'),
        headers: headers,
      );
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to mark all notifications as read');
    }
  }

  static Future<int> getUnreadNotificationCount() async {
    try {
      final token = await getAccessToken();
      if (token == null) return 0;

      final response = await http.get(
        Uri.parse('$baseUrl/api/notifications/unread-count/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['unread_count'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Error getting unread count: $e');
      return 0;
    }
  }

  // ==================== VISITOR ACCESS METHODS ====================

  static Future<Map<String, dynamic>> getVisitorAccessMatrix(
      int visitorId) async {
    print('Fetching access matrix for visitor: $visitorId');
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/access-matrix/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Access matrix loaded for visitor $visitorId');
      return data;
    } else {
      print('Failed to load access matrix: ${response.statusCode}');
      return {'sections': []};
    }
  }

  static Future<Map<String, dynamic>> getVisitorPendingSections(
      int visitorId) async {
    print('Fetching pending sections for visitor: $visitorId');
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/pending-sections/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Pending sections for visitor $visitorId');
      return data;
    } else {
      return {'pending_sections': []};
    }
  }

  // ==================== SITE METHODS ====================

  static Future<List<dynamic>> getSites() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/api/sites/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load sites: ${response.statusCode}');
    }
  }

  // ==================== EMPLOYEE METHODS ====================

  static Future<List<dynamic>> getEmployees() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/employees/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getCurrentEmployee() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/employees/me/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load current employee: ${response.statusCode}');
    }
  }

  // ==================== SECTION METHODS ====================

  static Future<List<dynamic>> getSectionsBySite(int siteId) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/api/sites/$siteId/available-sections/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load sections: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getAllSections() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/api/sections/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load all sections: ${response.statusCode}');
    }
  }

  // ==================== VISITOR CRUD METHODS ====================

  static Future<Map<String, dynamic>> createVisitor(
      Map<String, dynamic> visitorData) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/account/visitors/'),
        headers: headers,
        body: json.encode(visitorData),
      );
    });
    print('request body is $visitorData');
    print('response body is $response.body');
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Failed to create visitor');
    }
  }

  static Future<Map<String, dynamic>> getVisitor(int visitorId) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/visitors/$visitorId/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load visitor: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getAllVisitors() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/visitors/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load visitors: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> searchVisitors(String searchQuery) async {
    try {
      if (searchQuery.trim().isEmpty) {
        return {'success': true, 'query': '', 'count': 0, 'visitors': []};
      }

      final response = await authenticatedRequest(() async {
        final headers = await getAuthHeaders();
        return await http.get(
          Uri.parse(
              '$baseUrl/account/api/visitors/search/?q=${Uri.encodeComponent(searchQuery)}'),
          headers: headers,
        );
      });

      print('Search response status: ${response.statusCode}');
      print('Search response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search visitors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching visitors: $e');
      rethrow;
    }
  }

  // ==================== VISITOR CHECK-IN/OUT METHODS ====================

  static Future<Map<String, dynamic>> checkInVisitor(int visitorId,
      {String? notes}) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/account/visitors/$visitorId/check-in/'),
        headers: headers,
        body: json.encode({'notes': notes ?? ''}),
      );
    });
    print('visitor id is $visitorId');
    print('request body $notes');
    print('response for check in is $response.body');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check in visitor: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> checkOutVisitor(int visitorId,
      {String? notes}) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/account/visitors/$visitorId/check-out/'),
        headers: headers,
        body: json.encode({'notes': notes ?? ''}),
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check out visitor: ${response.statusCode}');
    }
  }

  // ==================== SECTION TRACKING METHODS ====================

  static Future<Map<String, dynamic>> sectionCheckIn(
      int visitorId, int sectionId,
      {String? notes}) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/section-checkin/'),
        headers: headers,
        body: json.encode({'section_id': sectionId, 'notes': notes ?? ''}),
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check in to section: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> sectionCheckOut(
      int visitorId, int sectionId,
      {String? notes}) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/section-checkout/'),
        headers: headers,
        body: json.encode({'section_id': sectionId, 'notes': notes ?? ''}),
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to check out from section: ${response.statusCode}');
    }
  }

  // ==================== APPROVAL METHODS ====================

  static Future<Map<String, dynamic>> approveVisitorSections(
      int visitorId, List<int> sectionIds, String status,
      {String? comments}) async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.post(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/approve-sections/'),
        headers: headers,
        body: json.encode({
          'section_ids': sectionIds,
          'status': status,
          'comments': comments ?? '',
        }),
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to approve sections: ${response.statusCode}');
    }
  }

  // ==================== STATS METHODS ====================

  static Future<Map<String, dynamic>> getVisitorStats() async {
    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse('$baseUrl/account/visitor-stats/'),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load visitor stats: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getDailyCapacity(int? siteId) async {
    final url = siteId != null
        ? '$baseUrl/account/api/daily-capacity/$siteId/'
        : '$baseUrl/account/api/daily-capacity/';

    final response = await authenticatedRequest(() async {
      final headers = await getAuthHeaders();
      return await http.get(
        Uri.parse(url),
        headers: headers,
      );
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load daily capacity: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> approveSection(
    int visitorId,
    int sectionId,
    String status, {
    String? comments,
  }) async {
    try {
      final token = await getAccessToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Ensure comments has a value (never empty)
      String finalComments;
      if (status == 'approved') {
        finalComments = 'Approved by approver';
      } else {
        finalComments = (comments != null && comments.trim().isNotEmpty)
            ? comments.trim()
            : 'Rejected by approver';
      }

      // Build the request body
      final Map<String, dynamic> requestBody = {
        'section_approvals': [
          {
            'section_id': sectionId,
            'status': status,
            'comments': finalComments,
          }
        ]
      };

      // Convert to JSON string
      final String jsonBody = jsonEncode(requestBody);

      // Debug logging - this will show the actual JSON
      print('=' * 60);
      print('APPROVE SECTION REQUEST:');
      print('URL: $baseUrl/account/api/visitors/$visitorId/approve-sections/');
      print('Raw JSON Body: $jsonBody');
      print('Formatted Body:');
      print(JsonEncoder.withIndent('  ').convert(requestBody));
      print('=' * 60);

      final response = await http.post(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/approve-sections/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonBody,
      );

      print('RESPONSE:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('=' * 60);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ??
            errorData['message'] ??
            'Failed to process approval');
      }
    } catch (e) {
      print('Error in approveSection: $e');
      rethrow;
    }
  }

  static Future<Uint8List?> exportVisitorsReport(
    DateTime startDate,
    DateTime endDate, {
    String status = 'all',
  }) async {
    try {
      final token = await getAccessToken();
      if (token == null) throw Exception('No authentication token found');

      // Format dates
      final startDateStr = startDate.toIso8601String().split('T')[0];
      final endDateStr = endDate.toIso8601String().split('T')[0];

      // Build URL
      final url = Uri.parse(
          '$baseUrl/account/api/export/visitors/?start_date=$startDateStr&end_date=$endDateStr&status=$status');

      print('📊 Export Report Request:');
      print('URL: $url');
      print('Start Date: $startDateStr');
      print('End Date: $endDateStr');
      print('Status: $status');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('📊 Export Report Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ Report exported successfully');
        return response.bodyBytes;
      } else if (response.statusCode == 404) {
        // Parse the warning message from backend
        try {
          final errorData = jsonDecode(response.body);
          final warningMessage = errorData['warning'] ??
              'No visitors found for the selected date range';
          throw Exception(warningMessage);
        } catch (e) {
          throw Exception(
              'No visitors found for the selected date range. Please try different dates.');
        }
      } else {
        // Handle other error codes
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage = errorData['error'] ??
              errorData['warning'] ??
              'Failed to export report';
          throw Exception(errorMessage);
        } catch (e) {
          throw Exception(
              'Failed to export report (Status: ${response.statusCode})');
        }
      }
    } catch (e) {
      print('❌ Error exporting report: $e');
      rethrow;
    }
  }

  static Future<Uint8List?> downloadQRCode(int visitorId) async {
    try {
      final token = await getAccessToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.get(
        Uri.parse('$baseUrl/account/api/visitors/$visitorId/qr-code/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to download QR code');
      }
    } catch (e) {
      print('Error downloading QR code: $e');
      rethrow;
    }
  }

  static Future<Uint8List?> downloadIDCard(int visitorId,
      {bool withPhoto = false}) async {
    try {
      final token = await getAccessToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.get(
        Uri.parse(
            '$baseUrl/account/api/visitors/$visitorId/id-card/?with_photo=$withPhoto'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to download ID card');
      }
    } catch (e) {
      print('Error downloading ID card: $e');
      rethrow;
    }
  }

  static Future<Uint8List?> bulkDownloadIDCards(List<int> visitorIds) async {
    try {
      final token = await getAccessToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.post(
        Uri.parse('$baseUrl/account/api/visitors/bulk-id-cards/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'visitor_ids': visitorIds}),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to download bulk ID cards');
      }
    } catch (e) {
      print('Error downloading bulk ID cards: $e');
      rethrow;
    }
  }

// Add this method to your ApiService class (add it before the last closing brace)
  static Future<Map<String, dynamic>> createVisitorWithPhoto(
    Map<String, dynamic> data,
    File? photoFile,
  ) async {
    if (photoFile != null) {
      // Get token first
      final token = await getAccessToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Use multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/account/visitors/'),
      );

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';
      // Don't set Content-Type, it will be set automatically with boundary

      // Add text fields
      data.forEach((key, value) {
        if (key != 'photo' && value != null) {
          print('Adding field: $key = $value');
          if (value is List) {
            // For list values, add each item as separate field with same key
            for (var item in value) {
              request.fields[key] = item.toString();
            }
          } else {
            request.fields[key] = value.toString();
          }
        }
      });

      // Add photo file
      request.files
          .add(await http.MultipartFile.fromPath('photo', photoFile.path));

      print('📤 Sending multipart request to create visitor with photo');
      print('Fields: ${request.fields}');
      print('Has photo file: true');
      print('Photo path: ${photoFile.path}');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to create visitor with photo: $responseBody');
      }
    } else {
      // Use regular JSON post
      return createVisitor(data);
    }
  }

  static Future<Map<String, dynamic>> createVisitorWithPhotoWeb(
    Map<String, dynamic> data,
    dynamic photoData,
  ) async {
    // Get token first
    final token = await getAccessToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    // Use multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/account/visitors/'),
    );

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Add text fields - FIX: Handle list values properly without overwriting
    data.forEach((key, value) {
      if (key != 'photo' && value != null) {
        print('Processing field: $key = $value (type: ${value.runtimeType})');

        if (value is List) {
          // For list values, add each item as a separate field with the same key
          // IMPORTANT: Use fields.add() or direct assignment? Let's use a different approach
          print('  This is a list with ${value.length} items');
          for (var item in value) {
            // Add each item as a separate field - this will create multiple entries
            // But HttpMultiPartRequest doesn't support multiple values directly
            // So we need to send them as comma-separated string
            if (key == 'selected_approvers_ids' ||
                key == 'requested_section_ids') {
              // For array fields, store as list in request.fields as comma-separated
              if (request.fields.containsKey(key)) {
                // Append to existing
                request.fields[key] =
                    '${request.fields[key]},${item.toString()}';
              } else {
                request.fields[key] = item.toString();
              }
              print('  Added to $key: $item');
            } else {
              request.fields[key] = item.toString();
            }
          }
        } else {
          request.fields[key] = value.toString();
          print('  Added: $key = $value');
        }
      }
    });

    // Add photo file
    if (photoData != null) {
      String fileName;
      List<int> fileBytes;

      if (photoData is http.MultipartFile) {
        request.files.add(photoData);
      } else {
        fileName = photoData['name'] ?? 'photo.jpg';
        fileBytes = photoData['bytes'];

        String extension = fileName.split('.').last.toLowerCase();
        String contentType = 'image/jpeg';
        if (extension == 'png')
          contentType = 'image/png';
        else if (extension == 'gif')
          contentType = 'image/gif';
        else if (extension == 'webp') contentType = 'image/webp';

        request.files.add(
          http.MultipartFile.fromBytes(
            'photo',
            fileBytes,
            filename: fileName,
            contentType: MediaType.parse(contentType),
          ),
        );
      }
    }

    // Debug: Print all fields after processing
    print('📤 Final fields being sent:');
    request.fields.forEach((key, value) {
      print('  $key: $value');
    });
    print('Has photo file: true');

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to create visitor with photo: $responseBody');
    }
  }

  // Add these methods to your ApiService class

// Cooldown Management (Superadmin only)
  static Future<List<dynamic>> getCooldownPeriods() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('No access token available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/account/api/admin/cooldowns/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load cooldown periods: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getCooldownPeriodDetail(int id) async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('No access token available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/account/api/admin/cooldowns/$id/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load cooldown period details: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> createCooldownPeriod(
      Map<String, dynamic> data) async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('No access token available');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/account/api/admin/cooldowns/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Failed to create cooldown period');
    }
  }

  static Future<void> savePendingVisitorId(int visitorId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('pending_visitor_id', visitorId);
      print('Saved pending visitor ID: $visitorId');
    } catch (e) {
      print('Error saving pending visitor ID: $e');
    }
  }

// Get and clear pending visitor ID
  static Future<int?> getAndClearPendingVisitorId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final visitorId = prefs.getInt('pending_visitor_id');
      if (visitorId != null) {
        await prefs.remove('pending_visitor_id');
        print('Retrieved and cleared pending visitor ID: $visitorId');
      }
      return visitorId;
    } catch (e) {
      print('Error getting pending visitor ID: $e');
      return null;
    }
  }
}

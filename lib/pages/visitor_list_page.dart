// // // lib/pages/visitors_list_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:modernlogintute/components/token_services.dart';
// // import 'package:modernlogintute/pages/visitor_page.dart';
// // import 'package:modernlogintute/pages/visitor_view.dart';
// // import 'dart:convert';

// // class VisitorsListPage extends StatefulWidget {
// //   const VisitorsListPage({super.key});

// //   @override
// //   State<VisitorsListPage> createState() => _VisitorsListPageState();
// // }

// // class _VisitorsListPageState extends State<VisitorsListPage> {
// //   List<dynamic> visitors = [];
// //   bool isLoading = true;
// //   String errorMessage = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchVisitors();
// //   }

// //   Future<void> _fetchVisitors() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });

// //     try {
// //       final String? token = await TokenService.getAccessToken();

// //       if (token == null) {
// //         setState(() {
// //           errorMessage = 'Please login again';
// //           isLoading = false;
// //         });
// //         return;
// //       }

// //       final response = await http.get(
// //         Uri.parse('http://127.0.0.1:8000/account/visitors/'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         setState(() {
// //           visitors = data is List ? data : [];
// //           isLoading = false;
// //         });
// //       } else if (response.statusCode == 401) {
// //         // Token expired
// //         await _refreshTokenAndRetry();
// //       } else {
// //         setState(() {
// //           errorMessage = 'Failed to load visitors';
// //           isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         errorMessage = 'Error: $e';
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   Future<void> _refreshTokenAndRetry() async {
// //     try {
// //       final String? refreshToken = await TokenService.getRefreshToken();

// //       if (refreshToken == null) {
// //         _redirectToLogin();
// //         return;
// //       }

// //       final response = await http.post(
// //         Uri.parse('http://127.0.0.1:8000/account/auth/refresh/'),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({'refresh': refreshToken}),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         await TokenService.saveTokens(data['access'], refreshToken);
// //         await _fetchVisitors();
// //       } else {
// //         _redirectToLogin();
// //       }
// //     } catch (e) {
// //       _redirectToLogin();
// //     }
// //   }

// //   void _redirectToLogin() {
// //     TokenService.clearTokens();
// //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F6F9),
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: const Text(
// //           "Visitors",
// //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.refresh, color: Colors.white),
// //             onPressed: _fetchVisitors,
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.add, color: Colors.white),
// //             onPressed: () async {
// //               await Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => const CreateVisitorPage(),
// //                 ),
// //               );
// //               _fetchVisitors(); // Refresh list when returning
// //             },
// //           ),
// //         ],
// //       ),
// //       body: isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : errorMessage.isNotEmpty
// //               ? _buildErrorWidget()
// //               : visitors.isEmpty
// //                   ? _buildEmptyWidget()
// //                   : _buildVisitorsList(),
// //     );
// //   }

// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
// //           const SizedBox(height: 16),
// //           Text(
// //             errorMessage,
// //             style: TextStyle(color: Colors.grey[600]),
// //             textAlign: TextAlign.center,
// //           ),
// //           const SizedBox(height: 16),
// //           ElevatedButton(
// //             onPressed: _fetchVisitors,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.black,
// //               foregroundColor: Colors.white,
// //             ),
// //             child: const Text("Retry"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
// //           const SizedBox(height: 16),
// //           Text(
// //             "No Visitors Yet",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Text(
// //             "Tap the + button to add a visitor",
// //             style: TextStyle(
// //               fontSize: 14,
// //               color: Colors.grey[500],
// //             ),
// //           ),
// //           const SizedBox(height: 24),
// //           ElevatedButton.icon(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.black,
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //             ),
// //             onPressed: () async {
// //               await Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => const CreateVisitorPage(),
// //                 ),
// //               );
// //               _fetchVisitors();
// //             },
// //             icon: const Icon(Icons.add, size: 18),
// //             label: const Text("Create Visitor"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildVisitorsList() {
// //     return ListView.builder(
// //       padding: const EdgeInsets.all(16),
// //       itemCount: visitors.length,
// //       itemBuilder: (context, index) {
// //         final visitor = visitors[index];
// //         return _VisitorCard(visitor: visitor);
// //       },
// //     );
// //   }
// // }

// // class _VisitorCard extends StatelessWidget {
// //   final Map<String, dynamic> visitor;

// //   const _VisitorCard({required this.visitor});

// //   Color _getStatusColor(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'approved':
// //         return Colors.green;
// //       case 'pending':
// //         return Colors.orange;
// //       case 'rejected':
// //         return Colors.red;
// //       case 'checked_in':
// //         return Colors.blue;
// //       case 'checked_out':
// //         return Colors.grey;
// //       default:
// //         return Colors.grey;
// //     }
// //   }

// //   String _formatDate(String? dateTimeString) {
// //     if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
// //     try {
// //       DateTime dateTime = DateTime.parse(dateTimeString);
// //       return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
// //     } catch (e) {
// //       return dateTimeString;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final status = visitor['status'] ?? 'pending';
// //     final statusColor = _getStatusColor(status);

// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.03),
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         child: InkWell(
// //           onTap: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => VisitorViewPage(visitorData: visitor),
// //               ),
// //             );
// //           },
// //           borderRadius: BorderRadius.circular(16),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Container(
// //                       width: 48,
// //                       height: 48,
// //                       decoration: BoxDecoration(
// //                         color: Colors.blue.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: const Icon(Icons.person,
// //                           color: Colors.blue, size: 28),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             visitor['full_name'] ?? 'Unknown',
// //                             style: const TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             visitor['email'] ?? 'No email',
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: Colors.grey[600],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 10,
// //                         vertical: 4,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: statusColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: Text(
// //                         status.toUpperCase(),
// //                         style: TextStyle(
// //                           fontSize: 11,
// //                           fontWeight: FontWeight.w600,
// //                           color: statusColor,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 12),
// //                 const Divider(height: 1),
// //                 const SizedBox(height: 12),
// //                 Row(
// //                   children: [
// //                     Icon(Icons.calendar_today,
// //                         size: 14, color: Colors.grey[500]),
// //                     const SizedBox(width: 6),
// //                     Text(
// //                       'Check-in: ${_formatDate(visitor['designated_check_in'])}',
// //                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
// //                     const SizedBox(width: 6),
// //                     Text(
// //                       'Check-out: ${_formatDate(visitor['designated_check_out'])}',
// //                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// //                     ),
// //                   ],
// //                 ),
// //                 if (visitor['purpose_of_visit'] != null &&
// //                     visitor['purpose_of_visit'].toString().isNotEmpty) ...[
// //                   const SizedBox(height: 8),
// //                   Row(
// //                     children: [
// //                       Icon(Icons.info_outline,
// //                           size: 14, color: Colors.grey[500]),
// //                       const SizedBox(width: 6),
// //                       Expanded(
// //                         child: Text(
// //                           visitor['purpose_of_visit'],
// //                           style:
// //                               TextStyle(fontSize: 12, color: Colors.grey[600]),
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // *********************************

// // lib/pages/visitors_list_page.dart
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:modernlogintute/components/token_services.dart';
// import 'package:modernlogintute/pages/visitor_page.dart';
// import 'package:modernlogintute/pages/visitor_view.dart';
// import 'package:modernlogintute/services/api_services.dart';
// import 'dart:convert';

// class VisitorsListPage extends StatefulWidget {
//   const VisitorsListPage({super.key});

//   @override
//   State<VisitorsListPage> createState() => _VisitorsListPageState();
// }

// class _VisitorsListPageState extends State<VisitorsListPage> {
//   List<dynamic> visitors = [];
//   List<dynamic> searchResults = [];
//   bool isLoading = true;
//   bool isSearching = false;
//   String errorMessage = '';
//   String searchQuery = '';
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchVisitors();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     final query = _searchController.text;
//     if (query != searchQuery) {
//       setState(() {
//         searchQuery = query;
//       });
//       if (query.isEmpty) {
//         setState(() {
//           searchResults = [];
//           isSearching = false;
//         });
//       } else {
//         _performSearch(query);
//       }
//     }
//   }

//   Future<void> _performSearch(String query) async {
//     setState(() {
//       isSearching = true;
//     });

//     try {
//       final response = await ApiService.searchVisitors(query);

//       setState(() {
//         searchResults = response['visitors'] ?? [];
//         isSearching = false;
//       });
//     } catch (e) {
//       print('Search error: $e');
//       setState(() {
//         isSearching = false;
//       });
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Search failed: $e'), backgroundColor: Colors.red),
//         );
//       }
//     }
//   }

//   void _clearSearch() {
//     _searchController.clear();
//     setState(() {
//       searchResults = [];
//       isSearching = false;
//       searchQuery = '';
//     });
//   }

//   Future<void> _fetchVisitors() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       final String? token = await TokenService.getAccessToken();

//       if (token == null) {
//         setState(() {
//           errorMessage = 'Please login again';
//           isLoading = false;
//         });
//         return;
//       }

//       final response = await http.get(
//         Uri.parse('http://127.0.0.1:8000/account/visitors/'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           visitors = data is List ? data : [];
//           isLoading = false;
//         });
//       } else if (response.statusCode == 401) {
//         // Token expired
//         await _refreshTokenAndRetry();
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load visitors';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _refreshTokenAndRetry() async {
//     try {
//       final String? refreshToken = await TokenService.getRefreshToken();

//       if (refreshToken == null) {
//         _redirectToLogin();
//         return;
//       }

//       final response = await http.post(
//         Uri.parse('http://127.0.0.1:8000/account/auth/refresh/'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'refresh': refreshToken}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         await TokenService.saveTokens(data['access'], refreshToken);
//         await _fetchVisitors();
//       } else {
//         _redirectToLogin();
//       }
//     } catch (e) {
//       _redirectToLogin();
//     }
//   }

//   void _redirectToLogin() {
//     TokenService.clearTokens();
//     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool hasSearchQuery = searchQuery.isNotEmpty;
//     final bool showResults = hasSearchQuery && !isSearching;
//     final List<dynamic> displayList = showResults ? searchResults : visitors;
//     final bool isEmpty = !isLoading && displayList.isEmpty && !hasSearchQuery;
//     final bool noSearchResults =
//         showResults && displayList.isEmpty && !isLoading;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6F9),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Visitors",
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: _fetchVisitors,
//           ),
//           IconButton(
//             icon: const Icon(Icons.add, color: Colors.white),
//             onPressed: () async {
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CreateVisitorPage(),
//                 ),
//               );
//               _fetchVisitors();
//               _clearSearch();
//             },
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search visitors by name...',
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   suffixIcon: searchQuery.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(Icons.clear, color: Colors.grey),
//                           onPressed: _clearSearch,
//                         )
//                       : null,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: _buildBody(displayList, hasSearchQuery, noSearchResults, isEmpty),
//     );
//   }

//   Widget _buildBody(List<dynamic> displayList, bool hasSearchQuery,
//       bool noSearchResults, bool isEmpty) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (errorMessage.isNotEmpty) {
//       return _buildErrorWidget();
//     }

//     if (noSearchResults) {
//       return _buildNoSearchResultsWidget();
//     }

//     if (isEmpty) {
//       return _buildEmptyWidget();
//     }

//     if (isSearching && hasSearchQuery) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text('Searching...'),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: displayList.length,
//       itemBuilder: (context, index) {
//         final visitor = displayList[index];
//         return _VisitorCard(visitor: visitor);
//       },
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//           const SizedBox(height: 16),
//           Text(
//             errorMessage,
//             style: TextStyle(color: Colors.grey[600]),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _fetchVisitors,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text("Retry"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoSearchResultsWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             'No visitors found for "$searchQuery"',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try a different name or clear the search',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//           ),
//           const SizedBox(height: 24),
//           OutlinedButton.icon(
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.black,
//               side: const BorderSide(color: Colors.black),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             onPressed: _clearSearch,
//             icon: const Icon(Icons.clear, size: 18),
//             label: const Text("Clear Search"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             "No Visitors Yet",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Tap the + button to add a visitor",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             onPressed: () async {
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CreateVisitorPage(),
//                 ),
//               );
//               _fetchVisitors();
//               _clearSearch();
//             },
//             icon: const Icon(Icons.add, size: 18),
//             label: const Text("Create Visitor"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _VisitorCard extends StatelessWidget {
//   final Map<String, dynamic> visitor;

//   const _VisitorCard({required this.visitor});

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'rejected':
//         return Colors.red;
//       case 'checked_in':
//         return Colors.blue;
//       case 'checked_out':
//         return Colors.grey;
//       default:
//         return Colors.grey;
//     }
//   }

//   String _formatDate(String? dateTimeString) {
//     if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
//     } catch (e) {
//       return dateTimeString;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final status = visitor['status'] ?? 'pending';
//     final statusColor = _getStatusColor(status);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => VisitorViewPage(visitorData: visitor),
//               ),
//             );
//           },
//           borderRadius: BorderRadius.circular(16),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(Icons.person,
//                           color: Colors.blue, size: 28),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             visitor['full_name'] ?? 'Unknown',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             visitor['email'] ?? 'No email',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: statusColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         status.toUpperCase(),
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                           color: statusColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 const Divider(height: 1),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_today,
//                         size: 14, color: Colors.grey[500]),
//                     const SizedBox(width: 6),
//                     Text(
//                       'Check-in: ${_formatDate(visitor['designated_check_in'])}',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                     const SizedBox(width: 16),
//                     Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
//                     const SizedBox(width: 6),
//                     Text(
//                       'Check-out: ${_formatDate(visitor['designated_check_out'])}',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//                 if (visitor['purpose_of_visit'] != null &&
//                     visitor['purpose_of_visit'].toString().isNotEmpty) ...[
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.info_outline,
//                           size: 14, color: Colors.grey[500]),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           visitor['purpose_of_visit'],
//                           style:
//                               TextStyle(fontSize: 12, color: Colors.grey[600]),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // **********************************

// // lib/pages/visitors_list_page.dart
// // lib/pages/visitors_list_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:modernlogintute/components/token_services.dart';
// // import 'package:modernlogintute/pages/visitor_page.dart';
// // import 'package:modernlogintute/pages/visitor_view.dart';
// // import 'dart:convert';

// // class VisitorsListPage extends StatefulWidget {
// //   const VisitorsListPage({super.key});

// //   @override
// //   State<VisitorsListPage> createState() => _VisitorsListPageState();
// // }

// // class _VisitorsListPageState extends State<VisitorsListPage> {
// //   List<dynamic> visitors = [];
// //   bool isLoading = true;
// //   String errorMessage = '';
// //   Map<int, bool> sectionApprovalStatus =
// //       {}; // Cache for section approval status

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchVisitors();
// //   }

// //   Future<void> _fetchVisitors() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });

// //     try {
// //       final String? token = await TokenService.getAccessToken();

// //       if (token == null) {
// //         setState(() {
// //           errorMessage = 'Please login again';
// //           isLoading = false;
// //         });
// //         return;
// //       }

// //       final response = await http.get(
// //         Uri.parse('${TokenService.baseUrl}/visitors/'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         setState(() {
// //           visitors = data is List ? data : (data['results'] ?? []);
// //           isLoading = false;
// //         });

// //         // Fetch section approval status for each visitor
// //         await _fetchSectionApprovalStatus();
// //       } else if (response.statusCode == 401) {
// //         await _refreshTokenAndRetry();
// //       } else {
// //         setState(() {
// //           errorMessage = 'Failed to load visitors';
// //           isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         errorMessage = 'Error: $e';
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   // Fetch section approval status for all visitors
// //   Future<void> _fetchSectionApprovalStatus() async {
// //     Map<int, bool> tempStatus = {};

// //     for (var visitor in visitors) {
// //       final visitorId = visitor['id'];
// //       try {
// //         final accessMatrix =
// //             await TokenService.getVisitorAccessMatrix(visitorId);

// //         // Check if any section is approved
// //         bool hasApprovedSection = false;
// //         if (accessMatrix.containsKey('sections') &&
// //             accessMatrix['sections'] is List) {
// //           for (var section in accessMatrix['sections']) {
// //             if (section['is_approved'] == true) {
// //               hasApprovedSection = true;
// //               break;
// //             }
// //           }
// //         }

// //         // If no approved sections found, check if there are any pending sections
// //         if (!hasApprovedSection) {
// //           final pendingSections =
// //               await TokenService.getVisitorPendingSections(visitorId);
// //           if (pendingSections.containsKey('pending_sections')) {
// //             final pendingList = pendingSections['pending_sections'];
// //             // If there are no pending sections, that means all are approved
// //             if (pendingList is List && pendingList.isEmpty) {
// //               hasApprovedSection = true;
// //             }
// //           }
// //         }

// //         tempStatus[visitorId] = hasApprovedSection;
// //       } catch (e) {
// //         print('Error checking approval for visitor $visitorId: $e');
// //         tempStatus[visitorId] = false;
// //       }
// //     }

// //     if (mounted) {
// //       setState(() {
// //         sectionApprovalStatus = tempStatus;
// //       });
// //     }
// //   }

// //   Future<void> _refreshTokenAndRetry() async {
// //     try {
// //       final String? refreshToken = await TokenService.getRefreshToken();

// //       if (refreshToken == null) {
// //         _redirectToLogin();
// //         return;
// //       }

// //       final response = await http.post(
// //         Uri.parse('${TokenService.baseUrl}/auth/refresh/'),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({'refresh': refreshToken}),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         await TokenService.saveTokens(data['access'], refreshToken);
// //         await _fetchVisitors();
// //       } else {
// //         _redirectToLogin();
// //       }
// //     } catch (e) {
// //       _redirectToLogin();
// //     }
// //   }

// //   void _redirectToLogin() {
// //     TokenService.clearTokens();
// //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F6F9),
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: const Text(
// //           "Visitors",
// //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.refresh, color: Colors.white),
// //             onPressed: _fetchVisitors,
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.add, color: Colors.white),
// //             onPressed: () async {
// //               await Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => const CreateVisitorPage(),
// //                 ),
// //               );
// //               _fetchVisitors(); // Refresh list when returning
// //             },
// //           ),
// //         ],
// //       ),
// //       body: isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : errorMessage.isNotEmpty
// //               ? _buildErrorWidget()
// //               : visitors.isEmpty
// //                   ? _buildEmptyWidget()
// //                   : _buildVisitorsList(),
// //     );
// //   }

// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
// //           const SizedBox(height: 16),
// //           Text(
// //             errorMessage,
// //             style: TextStyle(color: Colors.grey[600]),
// //             textAlign: TextAlign.center,
// //           ),
// //           const SizedBox(height: 16),
// //           ElevatedButton(
// //             onPressed: _fetchVisitors,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.black,
// //               foregroundColor: Colors.white,
// //             ),
// //             child: const Text("Retry"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
// //           const SizedBox(height: 16),
// //           Text(
// //             "No Visitors Yet",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Text(
// //             "Tap the + button to add a visitor",
// //             style: TextStyle(
// //               fontSize: 14,
// //               color: Colors.grey[500],
// //             ),
// //           ),
// //           const SizedBox(height: 24),
// //           ElevatedButton.icon(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.black,
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //             ),
// //             onPressed: () async {
// //               await Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => const CreateVisitorPage(),
// //                 ),
// //               );
// //               _fetchVisitors();
// //             },
// //             icon: const Icon(Icons.add, size: 18),
// //             label: const Text("Create Visitor"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildVisitorsList() {
// //     return ListView.builder(
// //       padding: const EdgeInsets.all(16),
// //       itemCount: visitors.length,
// //       itemBuilder: (context, index) {
// //         final visitor = visitors[index];
// //         final isSectionApproved = sectionApprovalStatus[visitor['id']] ?? false;
// //         return _VisitorCard(
// //           visitor: visitor,
// //           isSectionApproved: isSectionApproved,
// //         );
// //       },
// //     );
// //   }
// // }

// // class _VisitorCard extends StatelessWidget {
// //   final Map<String, dynamic> visitor;
// //   final bool isSectionApproved;

// //   const _VisitorCard({
// //     required this.visitor,
// //     required this.isSectionApproved,
// //   });

// //   Color _getStatusColor(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'approved':
// //         return Colors.green;
// //       case 'pending':
// //         return Colors.orange;
// //       case 'rejected':
// //         return Colors.red;
// //       case 'checked_in':
// //         return Colors.blue;
// //       case 'checked_out':
// //         return Colors.grey;
// //       default:
// //         return Colors.grey;
// //     }
// //   }

// //   String _formatDate(String? dateTimeString) {
// //     if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
// //     try {
// //       DateTime dateTime = DateTime.parse(dateTimeString);
// //       return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
// //     } catch (e) {
// //       return dateTimeString;
// //     }
// //   }

// //   String _formatTime(String? dateTimeString) {
// //     if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
// //     try {
// //       DateTime dateTime = DateTime.parse(dateTimeString);
// //       return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
// //     } catch (e) {
// //       return dateTimeString;
// //     }
// //   }

// //   String _getApprovedByNames() {
// //     final approvedBy = visitor['approved_by_details'];
// //     if (approvedBy == null || approvedBy.isEmpty) return '';

// //     List<String> names = [];
// //     for (var approver in approvedBy) {
// //       names.add(approver['full_name'] ?? 'Unknown');
// //     }
// //     return names.join(', ');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final status = visitor['status'] ?? 'pending';
// //     final statusColor = _getStatusColor(status);
// //     final createdBy = visitor['created_by_details'];
// //     final approvedByNames = _getApprovedByNames();
// //     final hasApprovers = approvedByNames.isNotEmpty;

// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.03),
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         child: InkWell(
// //           onTap: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => VisitorViewPage(visitorData: visitor),
// //               ),
// //             );
// //           },
// //           borderRadius: BorderRadius.circular(16),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   children: [
// //                     // Avatar with section approval tick mark
// //                     Stack(
// //                       children: [
// //                         Container(
// //                           width: 48,
// //                           height: 48,
// //                           decoration: BoxDecoration(
// //                             color: isSectionApproved
// //                                 ? Colors.green.withOpacity(0.1)
// //                                 : Colors.blue.withOpacity(0.1),
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                           child: Icon(
// //                             Icons.person,
// //                             color:
// //                                 isSectionApproved ? Colors.green : Colors.blue,
// //                             size: 28,
// //                           ),
// //                         ),
// //                         // Green checkmark badge if sections are approved
// //                         if (isSectionApproved)
// //                           Positioned(
// //                             right: 0,
// //                             bottom: 0,
// //                             child: Container(
// //                               padding: const EdgeInsets.all(2),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.green,
// //                                 shape: BoxShape.circle,
// //                                 border:
// //                                     Border.all(color: Colors.white, width: 1.5),
// //                               ),
// //                               child: const Icon(
// //                                 Icons.check,
// //                                 size: 12,
// //                                 color: Colors.white,
// //                               ),
// //                             ),
// //                           ),
// //                       ],
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Expanded(
// //                                 child: Text(
// //                                   visitor['full_name'] ?? 'Unknown',
// //                                   style: const TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                   overflow: TextOverflow.ellipsis,
// //                                 ),
// //                               ),
// //                               // Show "Section Approved" badge if applicable
// //                               if (isSectionApproved)
// //                                 Container(
// //                                   margin: const EdgeInsets.only(left: 8),
// //                                   padding: const EdgeInsets.symmetric(
// //                                     horizontal: 6,
// //                                     vertical: 2,
// //                                   ),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.green.withOpacity(0.1),
// //                                     borderRadius: BorderRadius.circular(8),
// //                                   ),
// //                                   child: const Text(
// //                                     '✓ Section Approved',
// //                                     style: TextStyle(
// //                                       fontSize: 9,
// //                                       fontWeight: FontWeight.w600,
// //                                       color: Colors.green,
// //                                     ),
// //                                   ),
// //                                 ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             visitor['email'] ?? 'No email',
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: Colors.grey[600],
// //                             ),
// //                           ),
// //                           if (createdBy != null) ...[
// //                             const SizedBox(height: 2),
// //                             Text(
// //                               'Created by: ${createdBy['full_name'] ?? 'Unknown'}',
// //                               style: TextStyle(
// //                                 fontSize: 10,
// //                                 color: Colors.grey[500],
// //                               ),
// //                             ),
// //                           ],
// //                         ],
// //                       ),
// //                     ),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 10,
// //                         vertical: 4,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: statusColor.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: Text(
// //                         status.toUpperCase(),
// //                         style: TextStyle(
// //                           fontSize: 11,
// //                           fontWeight: FontWeight.w600,
// //                           color: statusColor,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 12),
// //                 const Divider(height: 1),
// //                 const SizedBox(height: 12),
// //                 // Check-in/Check-out times
// //                 Row(
// //                   children: [
// //                     Icon(Icons.calendar_today,
// //                         size: 14, color: Colors.grey[500]),
// //                     const SizedBox(width: 6),
// //                     Text(
// //                       'Check-in: ${_formatDate(visitor['designated_check_in'])} ${_formatTime(visitor['designated_check_in'])}',
// //                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
// //                     const SizedBox(width: 6),
// //                     Text(
// //                       'Check-out: ${_formatDate(visitor['designated_check_out'])} ${_formatTime(visitor['designated_check_out'])}',
// //                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// //                     ),
// //                   ],
// //                 ),
// //                 // Approvers info
// //                 if (hasApprovers) ...[
// //                   const SizedBox(height: 8),
// //                   Row(
// //                     children: [
// //                       Icon(Icons.verified, size: 14, color: Colors.green[400]),
// //                       const SizedBox(width: 6),
// //                       Expanded(
// //                         child: Text(
// //                           'Approved by: $approvedByNames',
// //                           style: TextStyle(
// //                             fontSize: 11,
// //                             color: Colors.green[700],
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //                 // Purpose of visit if available
// //                 if (visitor['purpose_of_visit'] != null &&
// //                     visitor['purpose_of_visit'].toString().isNotEmpty) ...[
// //                   const SizedBox(height: 8),
// //                   Row(
// //                     children: [
// //                       Icon(Icons.info_outline,
// //                           size: 14, color: Colors.grey[500]),
// //                       const SizedBox(width: 6),
// //                       Expanded(
// //                         child: Text(
// //                           visitor['purpose_of_visit'],
// //                           style:
// //                               TextStyle(fontSize: 12, color: Colors.grey[600]),
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //                 // Vehicle and ID info if available
// //                 if (visitor['vehicle_number'] != null &&
// //                     visitor['vehicle_number'].toString().isNotEmpty) ...[
// //                   const SizedBox(height: 8),
// //                   Row(
// //                     children: [
// //                       Icon(Icons.directions_car,
// //                           size: 14, color: Colors.grey[500]),
// //                       const SizedBox(width: 6),
// //                       Text(
// //                         'Vehicle: ${visitor['vehicle_number']}',
// //                         style: TextStyle(fontSize: 11, color: Colors.grey[600]),
// //                       ),
// //                       if (visitor['id_card_number'] != null &&
// //                           visitor['id_card_number'].toString().isNotEmpty) ...[
// //                         const SizedBox(width: 16),
// //                         Icon(Icons.badge, size: 14, color: Colors.grey[500]),
// //                         const SizedBox(width: 6),
// //                         Text(
// //                           'ID: ${visitor['id_card_number']}',
// //                           style:
// //                               TextStyle(fontSize: 11, color: Colors.grey[600]),
// //                         ),
// //                       ],
// //                     ],
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// lib/pages/visitors_list_page.dart
import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/visitor_page.dart';
import 'package:modernlogintute/pages/visitor_view.dart';
import 'package:modernlogintute/services/api_services.dart';
import 'dart:convert';

class VisitorsListPage extends StatefulWidget {
  const VisitorsListPage({super.key});

  @override
  State<VisitorsListPage> createState() => _VisitorsListPageState();
}

class _VisitorsListPageState extends State<VisitorsListPage> {
  List<dynamic> visitors = [];
  List<dynamic> searchResults = [];
  bool isLoading = true;
  bool isSearching = false;
  String errorMessage = '';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchVisitors();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query != searchQuery) {
      setState(() {
        searchQuery = query;
      });
      if (query.isEmpty) {
        setState(() {
          searchResults = [];
          isSearching = false;
        });
      } else {
        _performSearch(query);
      }
    }
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      isSearching = true;
    });

    try {
      final response = await ApiService.searchVisitors(query);

      setState(() {
        searchResults = response['visitors'] ?? [];
        isSearching = false;
      });
    } catch (e) {
      print('Search error: $e');
      setState(() {
        isSearching = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Search failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      searchResults = [];
      isSearching = false;
      searchQuery = '';
    });
  }

  Future<void> _fetchVisitors() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await ApiService.getAllVisitors();

      setState(() {
        visitors = response is List ? response : [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSearchQuery = searchQuery.isNotEmpty;
    final bool showResults = hasSearchQuery && !isSearching;
    final List<dynamic> displayList = showResults ? searchResults : visitors;
    final bool isEmpty = !isLoading && displayList.isEmpty && !hasSearchQuery;
    final bool noSearchResults =
        showResults && displayList.isEmpty && !isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Visitors",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchVisitors,
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateVisitorPage(),
                ),
              );
              _fetchVisitors();
              _clearSearch();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search visitors by name...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(displayList, hasSearchQuery, noSearchResults, isEmpty),
    );
  }

  Widget _buildBody(List<dynamic> displayList, bool hasSearchQuery,
      bool noSearchResults, bool isEmpty) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return _buildErrorWidget();
    }

    if (noSearchResults) {
      return _buildNoSearchResultsWidget();
    }

    if (isEmpty) {
      return _buildEmptyWidget();
    }

    if (isSearching && hasSearchQuery) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Searching...'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final visitor = displayList[index];
        return _VisitorCard(visitor: visitor);
      },
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchVisitors,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResultsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No visitors found for "$searchQuery"',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different name or clear the search',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _clearSearch,
            icon: const Icon(Icons.clear, size: 18),
            label: const Text("Clear Search"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No Visitors Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the + button to add a visitor",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateVisitorPage(),
                ),
              );
              _fetchVisitors();
              _clearSearch();
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Create Visitor"),
          ),
        ],
      ),
    );
  }
}

class _VisitorCard extends StatelessWidget {
  final Map<String, dynamic> visitor;

  const _VisitorCard({required this.visitor});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'partially_approved':
        return Colors.blue;
      case 'rejected':
        return Colors.red;
      case 'checked_in':
        return Colors.blue;
      case 'checked_out':
        return Colors.grey;
      case 'no_show':
        return Colors.brown;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = visitor['status'] ?? 'pending';
    final statusColor = _getStatusColor(status);
    final createdBy = visitor['created_by_details'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VisitorViewPage(visitorData: visitor),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Photo or Avatar
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: visitor['photo_display_url'] != null
                            ? Image.network(
                                visitor['photo_display_url'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person,
                                      color: Colors.blue, size: 28);
                                },
                              )
                            : const Icon(Icons.person,
                                color: Colors.blue, size: 28),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visitor['full_name'] ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            visitor['email'] ?? 'No email',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (createdBy != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              'Created by: ${createdBy['full_name'] ?? 'Unknown'}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status.toUpperCase().replaceAll('_', ' '),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                // Check-in/Check-out times
                Row(
                  children: [
                    Icon(Icons.login, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Check-in: ${_formatDateTime(visitor['designated_check_in'])}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.logout, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Check-out: ${_formatDateTime(visitor['designated_check_out'])}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // Purpose of visit if available
                if (visitor['purpose_of_visit'] != null &&
                    visitor['purpose_of_visit'].toString().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          visitor['purpose_of_visit'],
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                // Approval progress indicator
                if (visitor['approval_progress'] != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.verified, size: 14, color: Colors.green[400]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Access: ${visitor['approval_progress']['accessible_sections_count'] ?? 0}/${visitor['approval_progress']['total_sections'] ?? 0} sections',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // // lib/pages/profile_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:modernlogintute/components/token_services.dart';
// // import 'dart:convert';

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   Map<String, dynamic>? userData;
// //   bool isLoading = true;
// //   String errorMessage = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchProfileData();
// //   }

// //   Future<void> fetchProfileData() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });

// //     try {
// //       final String? token = await TokenService.getAccessToken();

// //       if (token == null || token.isEmpty) {
// //         setState(() {
// //           errorMessage = 'Please login again';
// //           isLoading = false;
// //         });
// //         return;
// //       }

// //       final response = await http.get(
// //         Uri.parse('http://127.0.0.1:8000/account/employees/me/'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         setState(() {
// //           userData = data;
// //           isLoading = false;
// //         });
// //       } else if (response.statusCode == 401) {
// //         setState(() {
// //           errorMessage = 'Session expired. Please login again.';
// //           isLoading = false;
// //         });
// //       } else {
// //         setState(() {
// //           errorMessage = 'Failed to load profile data';
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

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F6F9),
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: const Text(
// //           "Profile",
// //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.refresh, color: Colors.white),
// //             onPressed: fetchProfileData,
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.logout, color: Colors.white),
// //             onPressed: _showLogoutDialog,
// //           ),
// //         ],
// //       ),
// //       body: isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : errorMessage.isNotEmpty
// //               ? _buildErrorWidget()
// //               : userData == null
// //                   ? _buildErrorWidget()
// //                   : _buildProfileContent(),
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
// //             onPressed: fetchProfileData,
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

// //   Widget _buildProfileContent() {
// //     return SingleChildScrollView(
// //       child: Column(
// //         children: [
// //           // Profile Header with Avatar
// //           Container(
// //             width: double.infinity,
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: const BorderRadius.only(
// //                 bottomLeft: Radius.circular(30),
// //                 bottomRight: Radius.circular(30),
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.05),
// //                   blurRadius: 10,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             child: Column(
// //               children: [
// //                 const SizedBox(height: 30),

// //                 // Profile Picture
// //                 Stack(
// //                   children: [
// //                     Container(
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.1),
// //                             blurRadius: 10,
// //                             offset: const Offset(0, 5),
// //                           ),
// //                         ],
// //                       ),
// //                       child: CircleAvatar(
// //                         radius: 60,
// //                         backgroundColor: Colors.grey[200],
// //                         child: _buildProfileImage(),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 0,
// //                       right: 0,
// //                       child: Container(
// //                         padding: const EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                           color: Colors.blue,
// //                           shape: BoxShape.circle,
// //                           border: Border.all(color: Colors.white, width: 3),
// //                         ),
// //                         child: const Icon(
// //                           Icons.camera_alt,
// //                           color: Colors.white,
// //                           size: 20,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // User Name
// //                 Text(
// //                   userData?['full_name'] ?? 'User Name',
// //                   style: const TextStyle(
// //                     fontSize: 24,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black87,
// //                   ),
// //                 ),

// //                 const SizedBox(height: 4),

// //                 // User Email
// //                 Text(
// //                   userData?['email'] ?? 'user@example.com',
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     color: Colors.grey[600],
// //                   ),
// //                 ),

// //                 const SizedBox(height: 8),

// //                 // Availability Status
// //                 Container(
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// //                   decoration: BoxDecoration(
// //                     color: (userData?['is_available'] == true)
// //                         ? Colors.green.withOpacity(0.1)
// //                         : Colors.red.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   child: Row(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       Container(
// //                         width: 8,
// //                         height: 8,
// //                         decoration: BoxDecoration(
// //                           color: (userData?['is_available'] == true)
// //                               ? Colors.green
// //                               : Colors.red,
// //                           shape: BoxShape.circle,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 6),
// //                       Text(
// //                         (userData?['is_available'] == true)
// //                             ? 'Available'
// //                             : 'Unavailable',
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           fontWeight: FontWeight.w600,
// //                           color: (userData?['is_available'] == true)
// //                               ? Colors.green
// //                               : Colors.red,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),
// //               ],
// //             ),
// //           ),

// //           const SizedBox(height: 20),

// //           // Profile Details Card
// //           Container(
// //             margin: const EdgeInsets.symmetric(horizontal: 20),
// //             padding: const EdgeInsets.all(20),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(20),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.03),
// //                   blurRadius: 8,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Row(
// //                   children: [
// //                     Icon(Icons.person_outline, color: Colors.blue, size: 22),
// //                     SizedBox(width: 8),
// //                     Text(
// //                       "Personal Information",
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const Divider(height: 24),
// //                 _buildInfoTile(
// //                   icon: Icons.person,
// //                   label: "Full Name",
// //                   value: userData?['full_name'] ?? 'N/A',
// //                 ),
// //                 _buildInfoTile(
// //                   icon: Icons.email,
// //                   label: "Email Address",
// //                   value: userData?['email'] ?? 'N/A',
// //                 ),
// //                 _buildInfoTile(
// //                   icon: Icons.business_center,
// //                   label: "Department",
// //                   value: userData?['department']?.isNotEmpty == true
// //                       ? userData!['department']
// //                       : 'Not specified',
// //                 ),
// //                 _buildInfoTile(
// //                   icon: Icons.work_outline,
// //                   label: "Designation",
// //                   value: userData?['designation']?.isNotEmpty == true
// //                       ? userData!['designation']
// //                       : 'Not specified',
// //                 ),
// //                 _buildInfoTile(
// //                   icon: Icons.badge,
// //                   label: "Employee ID",
// //                   value: userData?['id']?.toString() ?? 'N/A',
// //                 ),
// //               ],
// //             ),
// //           ),

// //           const SizedBox(height: 20),

// //           // Account Information Card
// //           Container(
// //             margin: const EdgeInsets.symmetric(horizontal: 20),
// //             padding: const EdgeInsets.all(20),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(20),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.03),
// //                   blurRadius: 8,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Row(
// //                   children: [
// //                     Icon(Icons.account_circle_outlined,
// //                         color: Colors.orange, size: 22),
// //                     SizedBox(width: 8),
// //                     Text(
// //                       "Account Information",
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const Divider(height: 24),
// //                 _buildInfoTile(
// //                   icon: Icons.calendar_today,
// //                   label: "Member Since",
// //                   value: _formatDate(userData?['created_at']),
// //                 ),
// //                 _buildInfoTile(
// //                   icon: Icons.fingerprint,
// //                   label: "Account Type",
// //                   value: "Employee",
// //                 ),
// //                 _buildInfoTile(
// //                   icon: Icons.verified_user,
// //                   label: "Account Status",
// //                   value: "Active",
// //                   valueColor: Colors.green,
// //                 ),
// //               ],
// //             ),
// //           ),

// //           const SizedBox(height: 30),

// //           // Logout Button
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 20),
// //             child: SizedBox(
// //               width: double.infinity,
// //               height: 50,
// //               child: ElevatedButton.icon(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.red,
// //                   foregroundColor: Colors.white,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   elevation: 0,
// //                 ),
// //                 onPressed: _showLogoutDialog,
// //                 icon: const Icon(Icons.logout, size: 20),
// //                 label: const Text(
// //                   "Logout",
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           const SizedBox(height: 30),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildProfileImage() {
// //     // Direct image URL - replace with your actual working image URL
// //     const String profileImageUrl =
// //         'https://drive.google.com/file/d/1_PDkzjuO3mzWzM3PtvirHe-ZcNDMLYFa/view?usp=sharing'; // Working example URL

// //     return CircleAvatar(
// //       radius: 60,
// //       backgroundImage: NetworkImage(profileImageUrl),
// //       backgroundColor: Colors.grey[200],
// //       child: Container(), // Empty container as fallback
// //     );
// //   }

// //   Widget _buildDummyProfileImage() {
// //     // Get initials from full name
// //     String initials = '';
// //     if (userData?['full_name'] != null && userData!['full_name'].isNotEmpty) {
// //       List<String> nameParts = userData!['full_name'].split(' ');
// //       if (nameParts.length >= 2) {
// //         initials = '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
// //       } else {
// //         initials = nameParts[0][0].toUpperCase();
// //       }
// //     } else {
// //       initials = 'U';
// //     }

// //     return CircleAvatar(
// //       radius: 60,
// //       backgroundColor: Colors.blue.shade100,
// //       child: Text(
// //         initials,
// //         style: TextStyle(
// //           fontSize: 40,
// //           fontWeight: FontWeight.bold,
// //           color: Colors.blue.shade700,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoTile({
// //     required IconData icon,
// //     required String label,
// //     required String value,
// //     Color? valueColor,
// //   }) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 16),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Icon(icon, size: 20, color: Colors.grey[600]),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   label,
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.grey[500],
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(
// //                   value,
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w500,
// //                     color: valueColor ?? Colors.black87,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
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

// //   void _showLogoutDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text("Logout"),
// //         content: const Text("Are you sure you want to logout?"),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text("Cancel"),
// //           ),
// //           ElevatedButton(
// //             onPressed: () async {
// //               await TokenService.clearTokens();
// //               if (mounted) {
// //                 Navigator.pushNamedAndRemoveUntil(
// //                   context,
// //                   '/login',
// //                   (route) => false,
// //                 );
// //               }
// //             },
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.red,
// //               foregroundColor: Colors.white,
// //             ),
// //             child: const Text("Logout"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // lib/pages/profile_page.dart
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:modernlogintute/components/token_services.dart';
// import 'dart:convert';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Map<String, dynamic>? userData;
//   bool isLoading = true;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchProfileData();
//   }

//   Future<void> fetchProfileData() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       final String? token = await TokenService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         setState(() {
//           errorMessage = 'Please login again';
//           isLoading = false;
//         });
//         return;
//       }

//       final response = await http.get(
//         Uri.parse('http://127.0.0.1:8000/account/employees/me/'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           userData = data;
//           isLoading = false;
//         });
//       } else if (response.statusCode == 401) {
//         setState(() {
//           errorMessage = 'Session expired. Please login again.';
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load profile data';
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6F9),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Profile",
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: fetchProfileData,
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: _showLogoutDialog,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//               ? _buildErrorWidget()
//               : userData == null
//                   ? _buildErrorWidget()
//                   : _buildProfileContent(),
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
//             onPressed: fetchProfileData,
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

//   Widget _buildProfileContent() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Profile Header with Avatar
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),

//                 // Profile Picture
//                 Stack(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: _buildProfileImage(),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 3),
//                         ),
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // User Name
//                 Text(
//                   userData?['full_name'] ?? 'User Name',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 // User Email
//                 Text(
//                   userData?['email'] ?? 'user@example.com',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 // Availability Status
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: (userData?['is_available'] == true)
//                         ? Colors.green.withOpacity(0.1)
//                         : Colors.red.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 8,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: (userData?['is_available'] == true)
//                               ? Colors.green
//                               : Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         (userData?['is_available'] == true)
//                             ? 'Available'
//                             : 'Unavailable',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: (userData?['is_available'] == true)
//                               ? Colors.green
//                               : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Profile Details Card
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.03),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Row(
//                   children: [
//                     Icon(Icons.person_outline, color: Colors.blue, size: 22),
//                     SizedBox(width: 8),
//                     Text(
//                       "Personal Information",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(height: 24),
//                 _buildInfoTile(
//                   icon: Icons.person,
//                   label: "Full Name",
//                   value: userData?['full_name'] ?? 'N/A',
//                 ),
//                 _buildInfoTile(
//                   icon: Icons.email,
//                   label: "Email Address",
//                   value: userData?['email'] ?? 'N/A',
//                 ),
//                 _buildInfoTile(
//                   icon: Icons.business_center,
//                   label: "Department",
//                   value: userData?['department']?.isNotEmpty == true
//                       ? userData!['department']
//                       : 'Not specified',
//                 ),
//                 _buildInfoTile(
//                   icon: Icons.work_outline,
//                   label: "Designation",
//                   value: userData?['designation']?.isNotEmpty == true
//                       ? userData!['designation']
//                       : 'Not specified',
//                 ),
//                 _buildInfoTile(
//                   icon: Icons.badge,
//                   label: "Employee ID",
//                   value: userData?['id']?.toString() ?? 'N/A',
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Account Information Card
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.03),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Row(
//                   children: [
//                     Icon(Icons.account_circle_outlined,
//                         color: Colors.orange, size: 22),
//                     SizedBox(width: 8),
//                     Text(
//                       "Account Information",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(height: 24),
//                 _buildInfoTile(
//                   icon: Icons.calendar_today,
//                   label: "Member Since",
//                   value: _formatDate(userData?['created_at']),
//                 ),
//                 _buildInfoTile(
//                   icon: Icons.fingerprint,
//                   label: "Account Type",
//                   value: "Employee",
//                 ),
//                 _buildInfoTile(
//                   icon: Icons.verified_user,
//                   label: "Account Status",
//                   value: "Active",
//                   valueColor: Colors.green,
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 30),

//           // Logout Button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 onPressed: _showLogoutDialog,
//                 icon: const Icon(Icons.logout, size: 20),
//                 label: const Text(
//                   "Logout",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }

//   // Widget _buildProfileImage() {
//   //   // Use a reliable working image URL
//   //   // You can change this to any direct image URL
//   //   const String profileImageUrl =
//   //       'https://drive.google.com/file/d/1_PDkzjuO3mzWzM3PtvirHe-ZcNDMLYFa/view?usp=drive_link';

//   //   return CircleAvatar(
//   //     radius: 60,
//   //     backgroundImage: NetworkImage(profileImageUrl),
//   //     backgroundColor: Colors.grey[200],
//   //     onBackgroundImageError: (error, stackTrace) {
//   //       // If image fails to load, show initials
//   //       print('Failed to load image: $error');
//   //     },
//   //     child: _buildInitialsFallback(),
//   //   );
//   // }

// Widget _buildProfileImage() {
//   // For Android/Desktop - full file path
//   final String imagePath = ''; // Windows
//   // final String imagePath = '/Users/yourname/Pictures/profile.jpg'; // Mac/Linux

//   return CircleAvatar(
//     radius: 60,
//     backgroundImage: FileImage(File(imagePath)),
//     backgroundColor: Colors.grey[200],
//     child: _buildInitialsFallback(),
//   );
// }
//   Widget _buildInitialsFallback() {
//     // Get initials from full name
//     String initials = '';
//     if (userData?['full_name'] != null && userData!['full_name'].isNotEmpty) {
//       List<String> nameParts = userData!['full_name'].split(' ');
//       if (nameParts.length >= 2) {
//         initials = '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
//       } else {
//         initials = nameParts[0][0].toUpperCase();
//       }
//     } else {
//       initials = 'U';
//     }

//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.blue.shade100,
//       ),
//       child: Center(
//         child: Text(
//           initials,
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue.shade700,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoTile({
//     required IconData icon,
//     required String label,
//     required String value,
//     Color? valueColor,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 20, color: Colors.grey[600]),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[500],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: valueColor ?? Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
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

//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Logout"),
//         content: const Text("Are you sure you want to logout?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await TokenService.clearTokens();
//               if (mounted) {
//                 Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   '/login',
//                   (route) => false,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text("Logout"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modernlogintute/components/token_services.dart';
import 'dart:convert';

const String baseUrl = 'https://vms-backend-drf-new.azurewebsites.net';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final String? token = await TokenService.getAccessToken();

      if (token == null || token.isEmpty) {
        setState(() {
          errorMessage = 'Please login again';
          isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/account/employees/me/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data;
          isLoading = false;
        });
      } else if (response.statusCode == 401) {
        setState(() {
          errorMessage = 'Session expired. Please login again.';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load profile data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  /// Returns the asset path for the given employee ID.
  /// Place images at: lib/assets/images/employee_<id>.jpg
  /// e.g. lib/assets/images/employee_1.jpg
  // String? _assetPathForEmployee(int? id) {
  //   if (id == null) return null;
  //   return 'lib/assets/images/IMG_20220318_095144.jpg';
  // }
  String? _assetPathForEmployee(int? id) {
    if (id == 1) {
      return 'assets/images/IMG_20220318_095144.jpg';
    }
    return null; // all others → no image
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchProfileData,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? _buildErrorWidget()
              : userData == null
                  ? _buildErrorWidget()
                  : _buildProfileContent(),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Error state
  // ─────────────────────────────────────────────────────────────────────────

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
            onPressed: fetchProfileData,
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

  // ─────────────────────────────────────────────────────────────────────────
  // Main profile UI
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Header card ────────────────────────────────────────────────
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),

                // Avatar
                Stack(
                  children: [
                    _buildProfileAvatar(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Name
                Text(
                  userData?['full_name'] ?? 'User Name',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                // Email
                Text(
                  userData?['email'] ?? 'user@example.com',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),

                const SizedBox(height: 10),

                // Availability pill
                _buildAvailabilityBadge(),

                const SizedBox(height: 28),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Personal Information ───────────────────────────────────────
          _buildSectionCard(
            icon: Icons.person_outline,
            iconColor: Colors.blue,
            title: "Personal Information",
            children: [
              _buildInfoTile(
                icon: Icons.person,
                label: "Full Name",
                value: userData?['full_name'] ?? 'N/A',
              ),
              _buildInfoTile(
                icon: Icons.email,
                label: "Email Address",
                value: userData?['email'] ?? 'N/A',
              ),
              _buildInfoTile(
                icon: Icons.business_center,
                label: "Department",
                value: userData?['department']?.isNotEmpty == true
                    ? userData!['department']
                    : 'Not specified',
              ),
              _buildInfoTile(
                icon: Icons.work_outline,
                label: "Designation",
                value: userData?['designation']?.isNotEmpty == true
                    ? userData!['designation']
                    : 'Not specified',
              ),
              _buildInfoTile(
                icon: Icons.badge,
                label: "Employee ID",
                value: userData?['id']?.toString() ?? 'N/A',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Account Information ────────────────────────────────────────
          _buildSectionCard(
            icon: Icons.account_circle_outlined,
            iconColor: Colors.orange,
            title: "Account Information",
            children: [
              _buildInfoTile(
                icon: Icons.calendar_today,
                label: "Member Since",
                value: _formatDate(userData?['created_at']),
              ),
              _buildInfoTile(
                icon: Icons.fingerprint,
                label: "Account Type",
                value: "Employee",
              ),
              _buildInfoTile(
                icon: Icons.verified_user,
                label: "Account Status",
                value: "Active",
                valueColor: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ── Logout button ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: _showLogoutDialog,
                icon: const Icon(Icons.logout, size: 20),
                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Profile avatar — tries asset image, falls back to initials
  // ─────────────────────────────────────────────────────────────────────────

  // Widget _buildProfileAvatar() {
  //   final int? employeeId = userData?['id'] is int
  //       ? userData!['id'] as int
  //       : int.tryParse(userData?['id']?.toString() ?? '');

  //   final String? assetPath = _assetPathForEmployee(employeeId);

  //   // We use a raw Image.asset inside a CircleAvatar via foregroundImage.
  //   // If the asset doesn't exist, errorBuilder catches it and shows initials.
  //   if (assetPath != null) {
  //     return CircleAvatar(
  //       radius: 60,
  //       backgroundColor: Colors.blue.shade100,
  //       // foregroundImage tries to load; on error we fall through to child
  //       foregroundImage: AssetImage(assetPath),
  //       onForegroundImageError: (_, __) {
  //         // silently fall back to initials child
  //       },
  //       child: _initialsWidget(size: 40),
  //     );
  //   }

  //   // No ID available — show initials only
  //   return CircleAvatar(
  //     radius: 60,
  //     backgroundColor: Colors.blue.shade100,
  //     child: _initialsWidget(size: 40),
  //   );
  // }

  Widget _buildProfileAvatar() {
    final int? employeeId = userData?['id'] is int
        ? userData!['id'] as int
        : int.tryParse(userData?['id']?.toString() ?? '');
    print("Employee ID: ${userData?['id']}");

    // Show image only for employee_id = 1
    if (employeeId == 1) {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: Image.asset(
            'lib/images/IMG_20220318_095144.jpg', // SAME as your SquareTile style
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Fallback → initials
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.blue.shade100,
      child: _initialsWidget(size: 40),
    );
  }

  Widget _initialsWidget({double size = 36}) {
    String initials = 'U';
    final fullName = userData?['full_name']?.toString() ?? '';
    if (fullName.isNotEmpty) {
      final parts = fullName.trim().split(' ');
      if (parts.length >= 2) {
        initials = '${parts.first[0]}${parts.last[0]}'.toUpperCase();
      } else {
        initials = parts.first[0].toUpperCase();
      }
    }
    return Text(
      initials,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade700,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Availability badge
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildAvailabilityBadge() {
    final bool available = userData?['is_available'] == true;
    final Color color = available ? Colors.green : Colors.red;
    final String label = available ? 'Available' : 'Unavailable';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Reusable section card
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Info row
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────────────────────────

  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
    try {
      final dt = DateTime.parse(dateTimeString);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return dateTimeString;
    }
  }

//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Logout"),
//         content: const Text("Are you sure you want to logout?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await TokenService.clearTokens();
//               if (mounted) {
//                 Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   '/login',
//                   (route) => false,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text("Logout"),
//           ),
//         ],
//       ),
//     );
//   }
// }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // close dialog first

              try {
                final String? accessToken = await TokenService.getAccessToken();
                final String? refreshToken =
                    await TokenService.getRefreshToken();

                if (accessToken != null && refreshToken != null) {
                  await http.post(
                    Uri.parse('$baseUrl/account/auth/logout/'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $accessToken',
                    },
                    body: jsonEncode({
                      'refresh': refreshToken,
                    }),
                  );
                }
              } catch (e) {
                print("Logout API error: $e");
                // even if API fails → still logout locally
              }

              // Always clear tokens locally
              await TokenService.clearTokens();

              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:modernlogintute/pages/profile_page.dart';
// // import 'package:modernlogintute/pages/visitor_list_page.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   int _currentIndex = 0;

// //   // Create pages for each tab
// //   final List<Widget> _pages = [
// //     const DashboardContent(), // Your dashboard content
// //     const VisitorsListPage(), // Visitors list page (not create page)
// //     const ProfilePage(), // Profile page
// //   ];

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _pages[_currentIndex], // Show the selected page
// //       bottomNavigationBar: BottomNavigationBar(
// //         backgroundColor: Colors.white,
// //         selectedItemColor: Colors.black,
// //         unselectedItemColor: Colors.grey,
// //         currentIndex: _currentIndex,
// //         type: BottomNavigationBarType.fixed,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.people), label: "Visitors"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // Extract your dashboard content into a separate widget
// // class DashboardContent extends StatelessWidget {
// //   const DashboardContent({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF7F8FA),
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: const Text(
// //           "Dashboard",
// //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Header
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Text(
// //                     "Dashboard Overview",
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w700,
// //                       color: Colors.black87,
// //                     ),
// //                   ),
// //                   Container(
// //                     padding:
// //                         const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Text(
// //                       "Today, ${_formattedDate()}",
// //                       style: TextStyle(
// //                         fontSize: 11,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),

// //               // Stats
// //               GridView.count(
// //                 shrinkWrap: true,
// //                 crossAxisCount: 3,
// //                 crossAxisSpacing: 12,
// //                 mainAxisSpacing: 12,
// //                 childAspectRatio: 2.6,
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 children: const [
// //                   _StatCard(
// //                     title: "Employees",
// //                     value: "120",
// //                     color: Color(0xFF3B82F6),
// //                     icon: Icons.people,
// //                   ),
// //                   _StatCard(
// //                     title: "Visitors",
// //                     value: "45",
// //                     color: Color(0xFFF59E0B),
// //                     icon: Icons.group,
// //                   ),
// //                   _StatCard(
// //                     title: "Active",
// //                     value: "18",
// //                     color: Color(0xFF10B981),
// //                     icon: Icons.flash_on,
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),

// //               // Activity
// //               Expanded(
// //                 child: Container(
// //                   padding: const EdgeInsets.all(14),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(14),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "Recent Activity",
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.w700,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       Expanded(
// //                         child: ListView.builder(
// //                           itemCount: 5,
// //                           itemBuilder: (context, index) {
// //                             const items = [
// //                               "Visitor John checked in",
// //                               "Employee added",
// //                               "Visitor Jane checked out",
// //                               "Security alert triggered",
// //                               "Visitor Alex checked in",
// //                             ];
// //                             return _ActivityTile(items[index]);
// //                           },
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   String _formattedDate() {
// //     final now = DateTime.now();
// //     return "${now.day}/${now.month}/${now.year}";
// //   }
// // }

// // // Your existing StatCard and ActivityTile widgets remain the same
// // class _StatCard extends StatelessWidget {
// //   final String title;
// //   final String value;
// //   final Color color;
// //   final IconData icon;

// //   const _StatCard({
// //     required this.title,
// //     required this.value,
// //     required this.color,
// //     required this.icon,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //       decoration: BoxDecoration(
// //         color: color.withOpacity(0.08),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(icon, color: color, size: 18),
// //           const SizedBox(width: 10),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 value,
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   color: color,
// //                 ),
// //               ),
// //               Text(
// //                 title,
// //                 style: const TextStyle(
// //                   fontSize: 10,
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _ActivityTile extends StatelessWidget {
// //   final String text;
// //   const _ActivityTile(this.text);

// //   IconData get _icon {
// //     if (text.contains("checked in")) return Icons.login;
// //     if (text.contains("checked out")) return Icons.logout;
// //     if (text.contains("added")) return Icons.person_add;
// //     if (text.contains("alert")) return Icons.warning_amber_rounded;
// //     return Icons.info_outline;
// //   }

// //   Color get _color {
// //     if (text.contains("checked in")) return Colors.green;
// //     if (text.contains("checked out")) return Colors.orange;
// //     if (text.contains("added")) return Colors.blue;
// //     if (text.contains("alert")) return Colors.red;
// //     return Colors.grey;
// //   }

// //   String get _time {
// //     if (text.contains("John")) return "09:14 AM";
// //     if (text.contains("added")) return "09:02 AM";
// //     if (text.contains("Jane")) return "08:55 AM";
// //     if (text.contains("alert")) return "08:40 AM";
// //     if (text.contains("Alex")) return "08:30 AM";
// //     return "Recently";
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6),
// //       child: Row(
// //         children: [
// //           Container(
// //             width: 32,
// //             height: 32,
// //             decoration: BoxDecoration(
// //               color: _color.withOpacity(0.08),
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: Icon(_icon, size: 16, color: _color),
// //           ),
// //           const SizedBox(width: 10),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   text,
// //                   style: const TextStyle(
// //                     fontSize: 12,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black87,
// //                   ),
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   _time,
// //                   style: TextStyle(
// //                     fontSize: 10,
// //                     color: Colors.grey[500],
// //                     fontWeight: FontWeight.w400,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Container(
// //             width: 6,
// //             height: 6,
// //             decoration: BoxDecoration(
// //               color: _color,
// //               shape: BoxShape.circle,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // Simple Profile Page

// import 'package:flutter/material.dart';
// import 'package:modernlogintute/pages/profile_page.dart';
// import 'package:modernlogintute/pages/visitor_list_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const DashboardContent(),
//     const VisitorsListPage(),
//     const ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.people), label: "Visitors"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

// class DashboardContent extends StatelessWidget {
//   const DashboardContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Dashboard",
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Dashboard Overview",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       "Today, ${_formattedDate()}",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Enhanced Stats Cards - Using GridView with better proportions
//               GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 1.1, // Changed to make cards taller
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: const [
//                   _EnhancedStatCard(
//                     title: "Total Employees",
//                     value: "120",
//                     color: Color(0xFF3B82F6),
//                     icon: Icons.people,
//                     subtitle: "Active staff members",
//                     trend: "+12 this month",
//                     trendUp: true,
//                   ),
//                   _EnhancedStatCard(
//                     title: "Total Visitors",
//                     value: "45",
//                     color: Color(0xFFF59E0B),
//                     icon: Icons.group,
//                     subtitle: "Today's check-ins",
//                     trend: "+8 since yesterday",
//                     trendUp: true,
//                   ),
//                   _EnhancedStatCard(
//                     title: "Active Now",
//                     value: "18",
//                     color: Color(0xFF10B981),
//                     icon: Icons.flash_on,
//                     subtitle: "Currently on site",
//                     trend: "Peak hour: 2-3 PM",
//                     trendUp: true,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Activity Section
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Recent Activity",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "View All",
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: 5,
//                           itemBuilder: (context, index) {
//                             const items = [
//                               "Visitor John checked in",
//                               "Employee added",
//                               "Visitor Jane checked out",
//                               "Security alert triggered",
//                               "Visitor Alex checked in",
//                             ];
//                             return _EnhancedActivityTile(items[index]);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formattedDate() {
//     final now = DateTime.now();
//     return "${now.day}/${now.month}/${now.year}";
//   }
// }

// // Enhanced Stat Card with more content
// class _EnhancedStatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final Color color;
//   final IconData icon;
//   final String subtitle;
//   final String trend;
//   final bool trendUp;

//   const _EnhancedStatCard({
//     required this.title,
//     required this.value,
//     required this.color,
//     required this.icon,
//     required this.subtitle,
//     required this.trend,
//     required this.trendUp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             color.withOpacity(0.12),
//             color.withOpacity(0.06),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: color.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, color: color, size: 22),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: trendUp
//                       ? Colors.green.withOpacity(0.1)
//                       : Colors.red.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       trendUp ? Icons.trending_up : Icons.trending_down,
//                       size: 12,
//                       color: trendUp ? Colors.green : Colors.red,
//                     ),
//                     const SizedBox(width: 2),
//                     Text(
//                       trend.split(' ').first,
//                       style: TextStyle(
//                         fontSize: 9,
//                         fontWeight: FontWeight.w600,
//                         color: trendUp ? Colors.green : Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: color,
//               height: 1,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: 9,
//               color: Colors.grey[500],
//             ),
//           ),
//           const SizedBox(height: 6),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Text(
//               trend,
//               style: TextStyle(
//                 fontSize: 8,
//                 color: color,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Enhanced Activity Tile with better spacing and info
// class _EnhancedActivityTile extends StatelessWidget {
//   final String text;
//   const _EnhancedActivityTile(this.text);

//   IconData get _icon {
//     if (text.contains("checked in")) return Icons.login;
//     if (text.contains("checked out")) return Icons.logout;
//     if (text.contains("added")) return Icons.person_add;
//     if (text.contains("alert")) return Icons.warning_amber_rounded;
//     return Icons.info_outline;
//   }

//   Color get _color {
//     if (text.contains("checked in")) return Colors.green;
//     if (text.contains("checked out")) return Colors.orange;
//     if (text.contains("added")) return Colors.blue;
//     if (text.contains("alert")) return Colors.red;
//     return Colors.grey;
//   }

//   String get _time {
//     if (text.contains("John")) return "09:14 AM";
//     if (text.contains("added")) return "09:02 AM";
//     if (text.contains("Jane")) return "08:55 AM";
//     if (text.contains("alert")) return "08:40 AM";
//     if (text.contains("Alex")) return "08:30 AM";
//     return "Recently";
//   }

//   String get _location {
//     if (text.contains("John")) return "Main Entrance";
//     if (text.contains("added")) return "HR Department";
//     if (text.contains("Jane")) return "West Wing";
//     if (text.contains("alert")) return "Security Office";
//     if (text.contains("Alex")) return "North Entrance";
//     return "Unknown";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   _color.withOpacity(0.15),
//                   _color.withOpacity(0.05),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(_icon, size: 20, color: _color),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   text,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.access_time, size: 10, color: Colors.grey[400]),
//                     const SizedBox(width: 4),
//                     Text(
//                       _time,
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Icon(Icons.location_on, size: 10, color: Colors.grey[400]),
//                     const SizedBox(width: 4),
//                     Text(
//                       _location,
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: _color,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: _color.withOpacity(0.4),
//                   blurRadius: 4,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/profile_page.dart';
import 'package:modernlogintute/pages/visitor_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardContent(),
    const VisitorsListPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Visitors"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  String _formattedDate() {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ──────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dashboard Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      "Today, ${_formattedDate()}",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Stat cards ───────────────────────────────────────────────
              // Using a Row instead of GridView so each card sizes to content
              // and we avoid the "too-tall card" problem from childAspectRatio.
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Expanded(
                      child: _StatCard(
                        title: "Total\nEmployees",
                        value: "120",
                        color: Color(0xFF3B82F6),
                        icon: Icons.people,
                        trend: "+12",
                        trendLabel: "+12 this month",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        title: "Total\nVisitors",
                        value: "45",
                        color: Color(0xFFF59E0B),
                        icon: Icons.group,
                        trend: "+8",
                        trendLabel: "+8 since yesterday",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        title: "Active\nNow",
                        value: "18",
                        color: Color(0xFF10B981),
                        icon: Icons.flash_on,
                        trend: "Peak",
                        trendLabel: "Peak: 2–3 PM",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Recent Activity ──────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent Activity",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "View All",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const _ActivityTile("Visitor John checked in"),
                    const _ActivityTile("Employee added"),
                    const _ActivityTile("Visitor Jane checked out"),
                    const _ActivityTile("Security alert triggered"),
                    const _ActivityTile("Visitor Alex checked in"),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat Card
// ─────────────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final String trend;
  final String trendLabel;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.trend,
    required this.trendLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon + trend badge row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up,
                        size: 10, color: Colors.green.shade700),
                    const SizedBox(width: 2),
                    Text(
                      trend,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Big number
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),

          // Title (two lines allowed)
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),

          // Trend label pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              trendLabel,
              style: TextStyle(
                fontSize: 8,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Activity Tile
// ─────────────────────────────────────────────────────────────────────────────

class _ActivityTile extends StatelessWidget {
  final String text;
  const _ActivityTile(this.text);

  IconData get _icon {
    if (text.contains("checked in")) return Icons.login;
    if (text.contains("checked out")) return Icons.logout;
    if (text.contains("added")) return Icons.person_add;
    if (text.contains("alert")) return Icons.warning_amber_rounded;
    return Icons.info_outline;
  }

  Color get _color {
    if (text.contains("checked in")) return Colors.green;
    if (text.contains("checked out")) return const Color(0xFFF59E0B);
    if (text.contains("added")) return Colors.blue;
    if (text.contains("alert")) return Colors.red;
    return Colors.grey;
  }

  String get _time {
    if (text.contains("John")) return "09:14 AM";
    if (text.contains("added")) return "09:02 AM";
    if (text.contains("Jane")) return "08:55 AM";
    if (text.contains("alert")) return "08:40 AM";
    if (text.contains("Alex")) return "08:30 AM";
    return "Recently";
  }

  String get _location {
    if (text.contains("John")) return "Main Entrance";
    if (text.contains("added")) return "HR Department";
    if (text.contains("Jane")) return "West Wing";
    if (text.contains("alert")) return "Security Office";
    if (text.contains("Alex")) return "North Entrance";
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, size: 18, color: _color),
          ),
          const SizedBox(width: 12),

          // Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 10, color: Colors.grey[400]),
                    const SizedBox(width: 3),
                    Text(
                      _time,
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.location_on, size: 10, color: Colors.grey[400]),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        _location,
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status dot
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

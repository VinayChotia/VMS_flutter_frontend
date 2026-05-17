// // import 'package:flutter/material.dart';
// // import 'package:modernlogintute/pages/home_page.dart';
// // import 'package:modernlogintute/pages/login_page.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // // void main() {
// // //   runApp(const MyApp());
// // // }

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   // Initialize shared_preferences for web
// //   await SharedPreferences.getInstance();

// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       initialRoute: '/login',
// //       routes: {
// //         '/login': (context) => LoginPage(),
// //         '/home': (context) => const HomePage(),
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:modernlogintute/pages/home_page.dart';
// import 'package:modernlogintute/pages/login_page.dart';
// import 'package:modernlogintute/pages/visitor_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_strategy/url_strategy.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Remove hash from URLs (optional - for cleaner URLs)
//   setPathUrlStrategy();

//   // Initialize shared_preferences
//   await SharedPreferences.getInstance();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Visitor Management',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Poppins',
//       ),
//       initialRoute: '/',
//       onGenerateRoute: _generateRoute,
//     );
//   }

//   Route<dynamic> _generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case '/':
//       return MaterialPageRoute(builder: (_) => LoginPage());
//     case '/login':
//       return MaterialPageRoute(builder: (_) => LoginPage());
//     case '/home':
//       return MaterialPageRoute(builder: (_) => const HomePage());
//     case '/visitor':
//       // This handles deep links like /visitor?id=123
//       final uri = Uri.parse(settings.name!);
//       final queryParams = uri.queryParameters;
//       final visitorId = queryParams['id'] != null
//           ? int.tryParse(queryParams['id']!)
//           : (settings.arguments as Map<String, dynamic>?)?['id'];

//       if (visitorId != null) {
//         return MaterialPageRoute(
//           builder: (_) => VisitorViewPage(
//             visitorId: visitorId,
//             fetchData: true,
//           ),
//         );
//       }
//       return MaterialPageRoute(builder: (_) => const HomePage());
//     default:
//       // Also handle /visitor/123 format
//       if (settings.name != null && settings.name!.startsWith('/visitor/')) {
//         final idStr = settings.name!.replaceFirst('/visitor/', '');
//         final visitorId = int.tryParse(idStr);
//         if (visitorId != null) {
//           return MaterialPageRoute(
//             builder: (_) => VisitorViewPage(
//               visitorId: visitorId,
//               fetchData: true,
//             ),
//           );
//         }
//       }
//       return MaterialPageRoute(builder: (_) => LoginPage());
//   }
// }
// }

import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/home_page.dart';
import 'package:modernlogintute/pages/login_page.dart';
import 'package:modernlogintute/pages/visitor_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Remove url_strategy import - we'll use hash routing
// import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DO NOT use setPathUrlStrategy() - keep hash routing for Azure Storage
  // setPathUrlStrategy(); // <-- COMMENT THIS OUT or REMOVE IT

  // Initialize shared_preferences
  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    // Get the full URL path including hash
    String path = settings.name ?? '/';

    // Handle hash-based routing (for Azure Static Web Apps)
    // Check if the path contains a hash and extract the route
    if (path.contains('#')) {
      // Extract everything after the #
      final hashIndex = path.indexOf('#');
      if (hashIndex + 1 < path.length) {
        path = path.substring(hashIndex + 1);
      } else {
        path = '/';
      }
    }

    print('🔄 Route path: $path'); // Debug log

    // Handle different routes
    if (path == '/' || path == '/login') {
      return MaterialPageRoute(builder: (_) => LoginPage());
    }

    if (path == '/home') {
      return MaterialPageRoute(builder: (_) => const HomePage());
    }

    // Handle /visitor/123 format
    if (path.startsWith('/visitor/')) {
      final idStr = path.replaceFirst('/visitor/', '');
      final visitorId = int.tryParse(idStr);
      if (visitorId != null) {
        print('✅ Navigating to visitor page for ID: $visitorId');
        return MaterialPageRoute(
          builder: (_) => VisitorViewPage(
            visitorId: visitorId,
            fetchData: true,
          ),
        );
      }
    }

    // Handle /visitor?id=123 format
    if (path.startsWith('/visitor')) {
      try {
        final uri = Uri.parse(path);
        final visitorId = uri.queryParameters['id'] != null
            ? int.tryParse(uri.queryParameters['id']!)
            : null;
        if (visitorId != null) {
          print('✅ Navigating to visitor page for ID: $visitorId');
          return MaterialPageRoute(
            builder: (_) => VisitorViewPage(
              visitorId: visitorId,
              fetchData: true,
            ),
          );
        }
      } catch (e) {
        print('Error parsing visitor route: $e');
      }
    }

    // Default to login page
    print('⚠️ Unknown route: $path, redirecting to login');
    return MaterialPageRoute(builder: (_) => LoginPage());
  }
}

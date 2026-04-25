// // lib/router/app_router.dart
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:modernlogintute/components/auth_service.dart';
// import 'package:modernlogintute/pages/home_page.dart';
// import 'package:modernlogintute/pages/login_page.dart';
// import 'package:modernlogintute/pages/profile_page.dart';
// import 'package:modernlogintute/pages/visitor_list_page.dart';
// import 'package:modernlogintute/pages/visitor_view.dart';
// import 'package:modernlogintute/pages/visitor_page.dart';
// import 'package:modernlogintute/pages/pending_approvals_page.dart';

// class AppRouter {
//   static const String login = '/login';
//   static const String home = '/home';
//   static const String visitors = '/visitors';
//   static const String createVisitor = '/visitors/create';
//   static const String visitorDetails = '/visitors/:id';
//   static const String profile = '/profile';
//   static const String pendingApprovals = '/pending-approvals';

//   static final GoRouter router = GoRouter(
//     initialLocation: login,
//     redirect: _redirect,
//     routes: [
//       GoRoute(
//         name: 'login',
//         path: login,
//         builder: (context, state) => const LoginPage(),
//       ),
//       GoRoute(
//         name: 'home',
//         path: home,
//         builder: (context, state) => const HomePage(),
//       ),
//       GoRoute(
//         name: 'visitors',
//         path: visitors,
//         builder: (context, state) => const VisitorsListPage(),
//       ),
//       GoRoute(
//         name: 'createVisitor',
//         path: createVisitor,
//         builder: (context, state) => const CreateVisitorPage(),
//       ),
//       GoRoute(
//         name: 'visitorDetails',
//         path: visitorDetails,
//         builder: (context, state) {
//           final id = int.parse(state.pathParameters['id']!);
//           final extra = state.extra as Map<String, dynamic>?;
//           return VisitorViewPage(visitorData: extra ?? {});
//         },
//       ),
//       GoRoute(
//         name: 'profile',
//         path: profile,
//         builder: (context, state) => const ProfilePage(),
//       ),
//       GoRoute(
//         name: 'pendingApprovals',
//         path: pendingApprovals,
//         builder: (context, state) => const PendingApprovalsPage(),
//       ),
//     ],
//   );

//   static Future<String?> redirect(BuildContext context, GoRouterState state) async {
//     final isLoggedIn = await AuthService.isLoggedIn();
//     final isLoginRoute = state.matchedLocation == login;

//     if (!isLoggedIn && !isLoginRoute) {
//       return login;
//     }
//     if (isLoggedIn && isLoginRoute) {
//       return home;
//     }
//     return null;
//   }
// }
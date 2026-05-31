import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modernlogintute/components/auth_service.dart';
import 'package:modernlogintute/pages/home_page.dart';
import 'package:modernlogintute/pages/login_page.dart';
import 'package:modernlogintute/pages/profile_page.dart';
import 'package:modernlogintute/pages/visitor_list_page.dart';
import 'package:modernlogintute/pages/visitor_view.dart';
import 'package:modernlogintute/pages/visitor_page.dart';
import 'package:modernlogintute/pages/pending_approvals_page.dart';
import 'package:modernlogintute/pages/register_page.dart';
import 'package:modernlogintute/pages/qr_code_scanner_page.dart';
import 'package:modernlogintute/pages/cooldown_period.dart';
import 'package:modernlogintute/services/api_services.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String visitors = '/visitors';
  static const String createVisitor = '/visitors/create';
  static const String visitorDetails = '/visitor/:id';
  static const String profile = '/profile';
  static const String pendingApprovals = '/pending-approvals';
  static const String qrScanner = '/qr-scanner';
  static const String reports = '/reports';
  static const String cooldownPeriods = '/cooldown-periods';
  static const String createCooldown = '/cooldown-periods/create';

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    debugLogDiagnostics: true,
    redirect: _redirect,
    routes: [
      GoRoute(
        name: 'login',
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'register',
        path: register,
        builder: (context, state) => const SignupPage(),
      ),
      // ShellRoute for bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            name: 'home',
            path: home,
            builder: (context, state) => const DashboardContent(),
          ),
          GoRoute(
            name: 'visitors',
            path: visitors,
            builder: (context, state) => const VisitorsListPage(),
          ),
          GoRoute(
            name: 'profile',
            path: profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        name: 'createVisitor',
        path: createVisitor,
        builder: (context, state) => const CreateVisitorPage(),
      ),
      GoRoute(
        name: 'visitorDetails',
        path: visitorDetails,
        builder: (context, state) {
          final idStr = state.pathParameters['id'];
          final id = idStr != null ? int.tryParse(idStr) : null;
          return VisitorViewPage(
            visitorId: id,
            fetchData: true,
          );
        },
      ),
      GoRoute(
        name: 'pendingApprovals',
        path: pendingApprovals,
        builder: (context, state) => const PendingApprovalsPage(),
      ),
      GoRoute(
        name: 'qrScanner',
        path: qrScanner,
        builder: (context, state) => const QRScannerPage(),
      ),
      GoRoute(
        name: 'reports',
        path: reports,
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        name: 'cooldownPeriods',
        path: cooldownPeriods,
        builder: (context, state) => const CooldownPeriodsPage(),
      ),
      GoRoute(
        name: 'createCooldown',
        path: createCooldown,
        builder: (context, state) => const CreateCooldownPeriodPage(),
      ),
    ],
  );

  static Future<String?> _redirect(
      BuildContext context, GoRouterState state) async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final isLoginRoute = state.matchedLocation == login;
    final isRegisterRoute = state.matchedLocation == register;

    if (!isLoggedIn) {
      if (isLoginRoute || isRegisterRoute) {
        return null;
      }
      return login;
    }

    if (isLoggedIn && (isLoginRoute || isRegisterRoute)) {
      return home;
    }

    return null;
  }
}

// A wrapper widget that provides the common layout (BottomNavigationBar, Drawer, AppBar)
class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  Map<String, dynamic>? _currentEmployee;
  bool _isLoadingEmployee = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchCurrentEmployee();
  }

  Future<void> _fetchCurrentEmployee() async {
    try {
      final employee = await ApiService.getCurrentEmployee();
      if (mounted) {
        setState(() {
          _currentEmployee = employee;
          _isLoadingEmployee = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching employee: $e');
      if (mounted) {
        setState(() {
          _isLoadingEmployee = false;
        });
      }
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppRouter.home)) {
      return 0;
    }
    if (location.startsWith(AppRouter.visitors)) {
      return 1;
    }
    if (location.startsWith(AppRouter.profile)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.visitors);
        break;
      case 2:
        context.go(AppRouter.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);
    final bool isHomePage = selectedIndex == 0;

    return Scaffold(
      key: _scaffoldKey,
      appBar: isHomePage
          ? AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                "Visitor Management",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                  onPressed: () => context.push(AppRouter.qrScanner),
                  tooltip: 'Scan QR Code',
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    _fetchCurrentEmployee();
                    // You might want a way to refresh the child page too
                  },
                  tooltip: 'Refresh',
                ),
              ],
            )
          : null,
      drawer: isHomePage ? _buildDrawer() : null,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Visitors"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: isHomePage
          ? FloatingActionButton(
              onPressed: () => context.push(AppRouter.qrScanner),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.qr_code_scanner, color: Colors.white),
              tooltip: 'Scan QR Code',
            )
          : null,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          _buildProfileSection(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 8),
                _buildDrawerItem(
                  icon: Icons.qr_code_scanner,
                  title: 'Scan QR Code',
                  subtitle: 'Scan visitor QR code',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRouter.qrScanner);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.assessment,
                  title: 'Reports',
                  subtitle: 'Export visitor reports',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRouter.reports);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.timer,
                  title: 'Cooldown Periods',
                  subtitle: 'View and manage cooldown periods',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRouter.cooldownPeriods);
                  },
                ),
                const Divider(height: 32, thickness: 1),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out from your account',
                  onTap: _logout,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade700, Colors.blue.shade900],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 25),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: _buildProfilePhoto(),
              ),
              const SizedBox(height: 14),
              Text(
                _currentEmployee?['full_name'] ?? 'Loading...',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                _currentEmployee?['email'] ?? '',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto() {
    if (_isLoadingEmployee) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }
    final photoUrl = _currentEmployee?['profile_picture'];
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          photoUrl,
          width: 90,
          height: 90,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildInitialsAvatar(),
        ),
      );
    }
    return _buildInitialsAvatar();
  }

  Widget _buildInitialsAvatar() {
    final name = _currentEmployee?['full_name'] ?? 'User';
    final initials = name
        .split(' ')
        .map((part) => part.isNotEmpty ? part[0] : '')
        .take(2)
        .join()
        .toUpperCase();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title,
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: onTap,
    );
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await AuthService.logout();
      if (mounted) {
        context.go(AppRouter.login);
      }
    }
  }
}

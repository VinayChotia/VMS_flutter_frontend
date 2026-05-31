import 'dart:convert';
import 'dart:io' show Platform, File, Directory;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:modernlogintute/pages/cooldown_period.dart';
import 'package:modernlogintute/pages/pending_approvals_page.dart';
import 'package:modernlogintute/pages/profile_page.dart';
import 'package:modernlogintute/pages/qr_code_scanner_page.dart';
import 'package:modernlogintute/pages/visitor_list_page.dart';
import 'package:modernlogintute/services/api_services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  Map<String, dynamic>? _currentEmployee;
  bool _isLoadingEmployee = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const DashboardContent(),
    const VisitorsListPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchCurrentEmployee();
  }

  Future<void> _fetchCurrentEmployee() async {
    try {
      final employee = await ApiService.getCurrentEmployee();
      setState(() {
        _currentEmployee = employee;
        _isLoadingEmployee = false;
      });
    } catch (e) {
      print('Error fetching employee: $e');
      setState(() {
        _isLoadingEmployee = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openCooldownPeriodsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CooldownPeriodsPage()),
    );
  }

  void _openQRScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomePage = _currentIndex == 0;

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
                onPressed: _openDrawer,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                  onPressed: _openQRScanner,
                  tooltip: 'Scan QR Code',
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    _fetchCurrentEmployee();
                    if (_pages[_currentIndex] is DashboardContent) {
                      setState(() {});
                    }
                  },
                  tooltip: 'Refresh',
                ),
              ],
            )
          : null,
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
      drawer: isHomePage ? _buildDrawer() : null,
      floatingActionButton: isHomePage
          ? FloatingActionButton(
              onPressed: _openQRScanner,
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
                    _openQRScanner();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.assessment,
                  title: 'Reports',
                  subtitle: 'Export visitor reports',
                  onTap: () {
                    Navigator.pop(context);
                    _openReportsPage();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.credit_card,
                  title: 'Generate ID Card',
                  subtitle: 'Create ID cards for visitors',
                  onTap: () {
                    Navigator.pop(context);
                    _openGenerateIDCardPage();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.timer,
                  title: 'Cooldown Periods',
                  subtitle: 'View and manage cooldown periods',
                  onTap: () {
                    Navigator.pop(context);
                    _openCooldownPeriodsPage();
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: _buildProfilePhoto(),
              ),
              const SizedBox(height: 14),
              Text(
                _currentEmployee?['full_name'] ?? 'Loading...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                _currentEmployee?['email'] ?? '',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (_currentEmployee?['department'] != null ||
                  _currentEmployee?['designation'] != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentEmployee?['department'] ?? ''}${_currentEmployee?['department'] != null && _currentEmployee?['designation'] != null ? ' • ' : ''}${_currentEmployee?['designation'] ?? ''}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              if (_currentEmployee?['employee_code'] != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'ID: ${_currentEmployee?['employee_code']}',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    final photoUrl = _currentEmployee?['profile_picture'];

    if (photoUrl != null && photoUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          photoUrl,
          width: 90,
          height: 90,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildInitialsAvatar();
          },
        ),
      );
    } else {
      return _buildInitialsAvatar();
    }
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
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
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
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            )
          : null,
      trailing:
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _openReportsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReportsPage()),
    );
  }

  void _openGenerateIDCardPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GenerateIDCardPage()),
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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ApiService.logout();
      if (mounted) {
        context.go('/login');
      }
    }
  }
}

// Reports Page
class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  bool _isLoading = false;
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedStatus = 'all';
  final List<String> _statusOptions = [
    'all',
    'pending',
    'approved',
    'rejected',
    'checked_in',
    'checked_out'
  ];

  Future<void> _exportReport() async {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both start and end dates'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService.exportVisitorsReport(
        _startDate!,
        _endDate!,
        status: _selectedStatus,
      );

      if (response != null) {
        if (kIsWeb) {
          final blob = html.Blob([response]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..target = 'blank'
            ..download =
                'visitors_report_${_startDate!.toIso8601String().split('T')[0]}_to_${_endDate!.toIso8601String().split('T')[0]}.xlsx';
          anchor.click();
          html.Url.revokeObjectUrl(url);
        } else {
          // Mobile implementation if needed
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report exported successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.assessment,
                        color: Colors.blue, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Export Visitors Report',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _selectDate(context, isStart: true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _startDate != null
                                  ? 'Start Date: ${_formatDate(_startDate!)}'
                                  : 'Select Start Date',
                              style: TextStyle(
                                color: _startDate != null
                                    ? Colors.black87
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _selectDate(context, isStart: false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _endDate != null
                                  ? 'End Date: ${_formatDate(_endDate!)}'
                                  : 'Select End Date',
                              style: TextStyle(
                                color: _endDate != null
                                    ? Colors.black87
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter by Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    items: _statusOptions.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _exportReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download, size: 20),
                          SizedBox(width: 8),
                          Text('Export Report'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class GenerateIDCardPage extends StatefulWidget {
  const GenerateIDCardPage({super.key});

  @override
  State<GenerateIDCardPage> createState() => _GenerateIDCardPageState();
}

class _GenerateIDCardPageState extends State<GenerateIDCardPage> {
  List<dynamic> _visitors = [];
  List<int> _selectedVisitorIds = [];
  bool _isLoading = true;
  bool _isGenerating = false;
  bool _withPhoto = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchApprovedVisitors();
  }

  Future<void> _fetchApprovedVisitors() async {
    setState(() => _isLoading = true);
    try {
      final allVisitors = await ApiService.getAllVisitors();
      final approvedVisitors = allVisitors.where((v) {
        final status = v['status'] ?? '';
        return status == 'approved' || status == 'partially_approved';
      }).toList();

      setState(() {
        _visitors = approvedVisitors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _generateIDCard() async {
    if (_selectedVisitorIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one visitor'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isGenerating = true);

    try {
      Uint8List? bytes;

      if (_selectedVisitorIds.length == 1) {
        bytes = await ApiService.downloadIDCard(
          _selectedVisitorIds.first,
          withPhoto: _withPhoto,
        );
      } else {
        bytes = await ApiService.bulkDownloadIDCards(_selectedVisitorIds);
      }

      if (bytes != null) {
        if (kIsWeb) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..target = 'blank'
            ..download = _selectedVisitorIds.length == 1
                ? 'visitor_id_card_${_selectedVisitorIds.first}.pdf'
                : 'bulk_id_cards.pdf';
          anchor.click();
          html.Url.revokeObjectUrl(url);
        } else {
          await _saveAndOpenFile(bytes);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ID Card(s) generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception("No data received from server");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  Future<void> _saveAndOpenFile(Uint8List bytes) async {
    try {
      File? savedFile;

      if (Platform.isAndroid) {
        if (await _needsStoragePermission()) {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            savedFile = await _saveToAppDirectory(bytes);
          } else {
            savedFile = await _saveToDownloads(bytes);
          }
        } else {
          savedFile = await _saveToAppDirectory(bytes);
        }
      } else {
        savedFile = await _saveToAppDirectory(bytes);
      }

      if (savedFile != null && mounted) {
        _showSuccessDialog(savedFile);
      } else {
        throw Exception('Failed to save file');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _needsStoragePermission() async {
    return true;
  }

  Future<File> _saveToDownloads(Uint8List bytes) async {
    Directory? downloadsDir;
    try {
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download/ID_Cards');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
      }
    } catch (e) {
      return await _saveToAppDirectory(bytes);
    }

    final fileName = _selectedVisitorIds.length == 1
        ? 'visitor_id_card_${_selectedVisitorIds.first}.pdf'
        : 'bulk_id_cards_${DateTime.now().millisecondsSinceEpoch}.pdf';

    final file = File('${downloadsDir!.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<File> _saveToAppDirectory(Uint8List bytes) async {
    final appDir = await getApplicationDocumentsDirectory();
    final idCardsDir = Directory('${appDir.path}/ID_Cards');

    if (!await idCardsDir.exists()) {
      await idCardsDir.create(recursive: true);
    }

    final fileName = _selectedVisitorIds.length == 1
        ? 'visitor_id_card_${_selectedVisitorIds.first}.pdf'
        : 'bulk_id_cards_${DateTime.now().millisecondsSinceEpoch}.pdf';

    final file = File('${idCardsDir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  void _showSuccessDialog(File file) {
    final fileSize = (file.lengthSync() / 1024).toStringAsFixed(2);
    final fileName = file.path.split('/').last;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ID Card Generated Successfully!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('File: $fileName'),
              const SizedBox(height: 8),
              Text('Size: $fileSize KB'),
              const SizedBox(height: 8),
              Text('Saved to device folder'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Share.shareXFiles([XFile(file.path)], text: 'Here is the ID card');
              },
              child: const Text('SHARE'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await OpenFile.open(file.path);
              },
              child: const Text('OPEN'),
            ),
          ],
        );
      },
    );
  }

  List<dynamic> get _filteredVisitors {
    if (_searchQuery.isEmpty) return _visitors;
    return _visitors.where((v) {
      final name = v['full_name']?.toLowerCase() ?? '';
      final email = v['email']?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Generate ID Card',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchApprovedVisitors,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
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
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search visitors...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Text('Include Photo:'),
                const SizedBox(width: 12),
                Switch(
                  value: _withPhoto,
                  onChanged: (value) => setState(() => _withPhoto = value),
                  activeColor: Colors.blue,
                ),
                const Spacer(),
                Text(
                  'Selected: ${_selectedVisitorIds.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredVisitors.isEmpty
                    ? const Center(child: Text('No approved visitors found'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredVisitors.length,
                        itemBuilder: (context, index) {
                          final visitor = _filteredVisitors[index];
                          final isSelected = _selectedVisitorIds.contains(visitor['id']);
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: CheckboxListTile(
                              title: Text(visitor['full_name'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(visitor['email'] ?? 'No email'),
                                  Text(
                                    'Status: ${visitor['status']?.toUpperCase() ?? 'UNKNOWN'}',
                                    style: TextStyle(
                                      color: visitor['status'] == 'approved' ? Colors.green : Colors.orange,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              value: isSelected,
                              onChanged: (selected) {
                                setState(() {
                                  if (selected == true) {
                                    _selectedVisitorIds.add(visitor['id']);
                                  } else {
                                    _selectedVisitorIds.remove(visitor['id']);
                                  }
                                });
                              },
                              secondary: const Icon(Icons.credit_card, color: Colors.blue),
                            ),
                          );
                        },
                      ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : _generateIDCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isGenerating
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print, size: 20),
                          SizedBox(width: 8),
                          Text('Generate ID Card(s)'),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  bool _isLoading = true;
  int _pendingApprovals = 0;
  int _lateVisitors = 0;
  int _scheduledToday = 0;
  String? _errorMessage;
  List<NotificationItem> _existingNotifications = [];
  List<NotificationItem> _realtimeNotifications = [];
  bool _loadingNotifications = true;
  WebSocketChannel? _channel;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDashboardCounts();
      _fetchExistingNotifications();
      _connectWebSocket();
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }

  Future<void> _connectWebSocket() async {
    try {
      final token = await ApiService.getAccessToken();
      if (token == null) return;

      final wsUrl = Uri.parse(
        'wss://vms-backend-drf-avdygnb6afcchbhg.centralindia-01.azurewebsites.net/ws/notifications/?token=$token',
      );
      _channel = IOWebSocketChannel.connect(wsUrl);

      _channel!.stream.listen(
        (message) => _handleWebSocketMessage(message),
        onError: (error) => print('WebSocket error: $error'),
        onDone: () {
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) _connectWebSocket();
          });
        },
      );
    } catch (e) {
      print('Failed to connect WebSocket: $e');
    }
  }

  void _handleWebSocketMessage(dynamic message) {
    try {
      Map<String, dynamic> data;
      if (message is String) {
        data = json.decode(message);
      } else if (message is Map<String, dynamic>) {
        data = message;
      } else {
        return;
      }

      Map<String, dynamic> notificationData;
      if (data.containsKey('data') && data['data'] is Map<String, dynamic>) {
        notificationData = data['data'];
      } else if (data.containsKey('title') && data.containsKey('message')) {
        notificationData = data;
      } else {
        return;
      }

      final notification = NotificationItem(
        id: notificationData['id'] ?? DateTime.now().millisecondsSinceEpoch,
        type: notificationData['type'] ?? data['type'] ?? 'notification',
        title: notificationData['title'] ?? 'New Notification',
        message: notificationData['message'] ?? 'You have a new notification',
        createdAt: DateTime.now(),
        isRead: false,
        data: notificationData,
      );

      setState(() {
        _realtimeNotifications.insert(0, notification);
        _unreadCount++;
      });

      _showNotificationSnackBar(notification);
    } catch (e) {
      print('Error parsing WebSocket message: $e');
    }
  }

  void _showNotificationSnackBar(NotificationItem notification) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getNotificationIcon(notification.type), color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(notification.message, style: const TextStyle(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: notification.isUrgent ? Colors.red.shade700 : Colors.black87,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(label: 'View', onPressed: () => _handleNotificationTap(notification)),
      ),
    );
  }

  Future<void> _fetchExistingNotifications() async {
    if (!mounted) return;
    setState(() => _loadingNotifications = true);
    try {
      final token = await ApiService.getAccessToken();
      if (token == null) return;
      final response = await ApiService.getNotifications();
      setState(() {
        _existingNotifications = (response as List).map((n) => NotificationItem.fromApi(n)).toList();
        _unreadCount = _existingNotifications.where((n) => !n.isRead).length;
        _loadingNotifications = false;
      });
    } catch (e) {
      setState(() => _loadingNotifications = false);
    }
  }

  Future<void> _markAsRead(int id, bool isRealtime, int index) async {
    try {
      await ApiService.markNotificationRead(id);
      setState(() {
        if (isRealtime) {
          _realtimeNotifications[index].isRead = true;
        } else {
          _existingNotifications[index].isRead = true;
        }
        _unreadCount = _getTotalUnreadCount();
      });
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  Future<void> _markAllAsRead() async {
    try {
      await ApiService.markAllNotificationsRead();
      setState(() {
        for (var n in _existingNotifications) n.isRead = true;
        for (var n in _realtimeNotifications) n.isRead = true;
        _unreadCount = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All notifications marked as read')));
    } catch (e) {
      print('Error marking all as read: $e');
    }
  }

  int _getTotalUnreadCount() {
    return _existingNotifications.where((n) => !n.isRead).length + _realtimeNotifications.where((n) => !n.isRead).length;
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'approval_request': return Icons.person_add_alt_1;
      case 'approval_update': return Icons.check_circle_outline;
      case 'status_change': return Icons.timeline;
      case 'section_checkin': return Icons.login;
      case 'section_checkout': return Icons.logout;
      default: return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'approval_request': return Colors.blue;
      case 'approval_update': return Colors.green;
      case 'status_change': return Colors.orange;
      case 'section_checkin': return Colors.purple;
      case 'section_checkout': return Colors.grey;
      default: return Colors.grey;
    }
  }

  void _handleNotificationTap(NotificationItem notification) {
    print('Tapped: ${notification.title}');
  }

  void _showNotificationsDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        if (_unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                            child: Text('$_unreadCount', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                    if (_unreadCount > 0) TextButton(onPressed: _markAllAsRead, child: const Text('Mark all as read')),
                  ],
                ),
              ),
              Expanded(
                child: _loadingNotifications
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: _fetchExistingNotifications,
                        child: ListView(
                          controller: scrollController,
                          children: [
                            if (_realtimeNotifications.isNotEmpty)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(children: [
                                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                      const SizedBox(width: 8),
                                      const Text('Live Updates', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green)),
                                    ]),
                                  ),
                                  ..._realtimeNotifications.asMap().entries.map((entry) => _NotificationTile(
                                        notification: entry.value,
                                        icon: _getNotificationIcon(entry.value.type),
                                        color: _getNotificationColor(entry.value.type),
                                        onTap: () => _handleNotificationTap(entry.value),
                                        onMarkRead: () => _markAsRead(entry.value.id, true, entry.key),
                                      )),
                                  const Divider(),
                                ],
                              ),
                            if (_existingNotifications.isNotEmpty)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(children: [
                                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                                      const SizedBox(width: 8),
                                      const Text('Previous Notifications', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue)),
                                    ]),
                                  ),
                                  ..._existingNotifications.asMap().entries.map((entry) => _NotificationTile(
                                        notification: entry.value,
                                        icon: _getNotificationIcon(entry.value.type),
                                        color: _getNotificationColor(entry.value.type),
                                        onTap: () => _handleNotificationTap(entry.value),
                                        onMarkRead: () => _markAsRead(entry.value.id, false, entry.key),
                                      )),
                                ],
                              ),
                            if (_existingNotifications.isEmpty && _realtimeNotifications.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(32),
                                child: Center(child: Column(children: [Icon(Icons.notifications_none, size: 64, color: Colors.grey), SizedBox(height: 16), Text('No notifications', style: TextStyle(color: Colors.grey))])),
                              ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchDashboardCounts() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final response = await ApiService.getDashboardCounts();
      setState(() {
        _pendingApprovals = response['pending_approvals'] ?? 0;
        _lateVisitors = response['checkin_summary']?['late'] ?? 0;
        _scheduledToday = response['scheduled_today'] ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _formattedDate() {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dashboard Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                    child: Text("Today, ${_formattedDate()}", style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.shade200)),
                  child: Row(children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                    const SizedBox(width: 12),
                    Expanded(child: Text(_errorMessage!, style: TextStyle(color: Colors.red.shade700, fontSize: 12))),
                    TextButton(onPressed: _fetchDashboardCounts, child: const Text('Retry')),
                  ]),
                ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_pendingApprovals > 0) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PendingApprovalsPage()));
                          }
                        },
                        child: _StatCard(
                          title: "Pending\nApprovals",
                          value: _isLoading ? "..." : _pendingApprovals.toString(),
                          color: const Color(0xFF8B5CF6),
                          icon: Icons.assignment_turned_in,
                          trend: _pendingApprovals > 0 ? "Action needed" : "All clear",
                          trendLabel: _pendingApprovals > 0 ? "$_pendingApprovals visitor(s) need approval" : "No pending approvals",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        title: "Late\nVisitors",
                        value: _isLoading ? "..." : _lateVisitors.toString(),
                        color: const Color(0xFFEF4444),
                        icon: Icons.warning_amber_rounded,
                        trend: _lateVisitors > 0 ? "Alert" : "On time",
                        trendLabel: _lateVisitors > 0 ? "$_lateVisitors visitor(s) arrived late" : "All visitors on time",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        title: "Scheduled\nToday",
                        value: _isLoading ? "..." : _scheduledToday.toString(),
                        color: const Color(0xFF10B981),
                        icon: Icons.calendar_today,
                        trend: _scheduledToday > 0 ? "Upcoming" : "No visits",
                        trendLabel: _scheduledToday > 0 ? "$_scheduledToday visitor(s) scheduled" : "No visits scheduled today",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Recent Activity", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black87)),
                          GestureDetector(
                            onTap: _showNotificationsDialog,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Icon(Icons.list_alt, size: 14, color: Colors.blue.shade700),
                                const SizedBox(width: 4),
                                Text('View All', style: TextStyle(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500)),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_realtimeNotifications.isNotEmpty || _existingNotifications.isNotEmpty)
                      Column(
                        children: [
                          ...(_realtimeNotifications.take(3).map((n) => _RecentNotificationTile(notification: n, icon: _getNotificationIcon(n.type), color: _getNotificationColor(n.type), isRealTime: true))),
                          ...(_existingNotifications.take(3 - _realtimeNotifications.length).map((n) => _RecentNotificationTile(notification: n, icon: _getNotificationIcon(n.type), color: _getNotificationColor(n.type), isRealTime: false))),
                        ],
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: Column(children: [Icon(Icons.notifications_none, size: 48, color: Colors.grey), SizedBox(height: 12), Text("No recent activity", style: TextStyle(color: Colors.grey))])),
                      ),
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

class NotificationItem {
  final int id;
  final String type;
  final String title;
  final String message;
  final DateTime createdAt;
  bool isRead;
  final Map<String, dynamic>? data;

  NotificationItem({required this.id, required this.type, required this.title, required this.message, required this.createdAt, required this.isRead, this.data});

  factory NotificationItem.fromApi(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      type: json['type'] ?? 'notification',
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['is_read'] ?? false,
      data: json['data'],
    );
  }

  bool get isUrgent => type == 'approval_request' || type == 'approval_update' || type == 'status_change';
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onMarkRead;

  const _NotificationTile({required this.notification, required this.icon, required this.color, required this.onTap, required this.onMarkRead});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(child: Text(notification.title, style: TextStyle(fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold, fontSize: 14))),
                    if (!notification.isRead) Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                  ]),
                  const SizedBox(height: 4),
                  Text(notification.message, style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(_formatTime(notification.createdAt), style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                ],
              ),
            ),
            if (!notification.isRead) IconButton(icon: const Icon(Icons.done_all, size: 18), onPressed: onMarkRead, tooltip: 'Mark as read'),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    return 'Just now';
  }
}

class _RecentNotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final IconData icon;
  final Color color;
  final bool isRealTime;

  const _RecentNotificationTile({required this.notification, required this.icon, required this.color, required this.isRealTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  if (isRealTime) Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('LIVE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.green))),
                ]),
                const SizedBox(height: 2),
                Text(notification.message, style: TextStyle(fontSize: 11, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final String trend;
  final String trendLabel;

  const _StatCard({required this.title, required this.value, required this.color, required this.icon, required this.trend, required this.trendLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 34, height: 34, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 18)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: trend == "Alert" || trend == "Action needed" ? Colors.orange.shade50 : (trend == "All clear" || trend == "On time" ? Colors.green.shade50 : Colors.blue.shade50),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(trend, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: trend == "Alert" || trend == "Action needed" ? Colors.orange.shade700 : (trend == "All clear" || trend == "On time" ? Colors.green.shade700 : Colors.blue.shade700))),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color, height: 1)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87, height: 1.3)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(5)),
            child: Text(trendLabel, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

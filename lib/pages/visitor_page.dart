import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/services/api_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class CreateVisitorPage extends StatefulWidget {
  const CreateVisitorPage({super.key});

  @override
  State<CreateVisitorPage> createState() => _CreateVisitorPageState();
}

class _CreateVisitorPageState extends State<CreateVisitorPage> {
  // Controllers for text fields
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final companyNameController = TextEditingController();
  final purposeOfVisitController = TextEditingController();
  final hostDepartmentController = TextEditingController();
  final meetingRoomController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final idCardNumberController = TextEditingController();
  final photoUrlController = TextEditingController();

  // DateTime fields
  DateTime? designatedCheckIn;
  DateTime? designatedCheckOut;

  // Selected IDs
  int? selectedSiteId;
  List<int> selectedSectionIds = [];
  List<int> selectedApproversIds = [];

  // Photo fields - Use Uint8List for web compatibility
  Uint8List? selectedImageBytes;
  String? selectedImageName;
  String? photoUrl;
  bool usePhotoUrl = false;

  // Data from API
  List<dynamic> sites = [];
  List<dynamic> sections = [];
  List<dynamic> employees = [];

  // Dropdown visibility states
  bool isSiteDropdownVisible = false;
  bool isSectionDropdownVisible = false;
  bool isApproverDropdownVisible = false;

  // Search filters
  String siteSearchQuery = '';
  String sectionSearchQuery = '';
  String approverSearchQuery = '';

  // Focus nodes for handling dropdown dismissal
  final FocusNode siteFocusNode = FocusNode();
  final FocusNode sectionFocusNode = FocusNode();
  final FocusNode approverFocusNode = FocusNode();

  // Loading states
  bool isLoading = false;
  bool isLoadingSites = true;
  bool isLoadingEmployees = true;
  bool isLoadingSections = false;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchInitialData();

    // Add focus listeners to close dropdowns when focus is lost
    siteFocusNode.addListener(() {
      if (!siteFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted && !siteFocusNode.hasFocus) {
            setState(() => isSiteDropdownVisible = false);
          }
        });
      }
    });

    sectionFocusNode.addListener(() {
      if (!sectionFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted && !sectionFocusNode.hasFocus) {
            setState(() => isSectionDropdownVisible = false);
          }
        });
      }
    });

    approverFocusNode.addListener(() {
      if (!approverFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted && !approverFocusNode.hasFocus) {
            setState(() => isApproverDropdownVisible = false);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    companyNameController.dispose();
    purposeOfVisitController.dispose();
    hostDepartmentController.dispose();
    meetingRoomController.dispose();
    vehicleNumberController.dispose();
    idCardNumberController.dispose();
    photoUrlController.dispose();
    siteFocusNode.dispose();
    sectionFocusNode.dispose();
    approverFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialData() async {
    await Future.wait([
      _fetchSites(),
      _fetchEmployees(),
    ]);
  }

  Future<void> _fetchSites() async {
    try {
      final response = await ApiService.getSites();
      if (mounted) {
        setState(() {
          sites = response;
          isLoadingSites = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingSites = false);
        _showError('Failed to load sites');
      }
    }
  }

  Future<void> _fetchEmployees() async {
    try {
      final response = await ApiService.getEmployees();
      if (mounted) {
        setState(() {
          employees = response;
          isLoadingEmployees = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingEmployees = false);
        _showError('Failed to load employees');
      }
    }
  }

  Future<void> _fetchSectionsForSite(int siteId) async {
    setState(() {
      isLoadingSections = true;
      selectedSectionIds = [];
      sectionSearchQuery = '';
      isSectionDropdownVisible = false;
    });

    try {
      final response = await ApiService.getSectionsBySite(siteId);
      if (mounted) {
        setState(() {
          sections = response;
          isLoadingSections = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingSections = false);
        _showError('Failed to load sections');
      }
    }
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: designatedCheckIn ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            colorScheme: const ColorScheme.light(primary: Colors.black),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              colorScheme: const ColorScheme.light(primary: Colors.black),
            ),
            child: child!,
          );
        },
      );
      if (time != null && mounted) {
        setState(() {
          designatedCheckIn = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: designatedCheckOut ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            colorScheme: const ColorScheme.light(primary: Colors.black),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              colorScheme: const ColorScheme.light(primary: Colors.black),
            ),
            child: child!,
          );
        },
      );
      if (time != null && mounted) {
        setState(() {
          designatedCheckOut = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (pickedFile != null && mounted) {
        final bytes = await pickedFile.readAsBytes();
        String fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

        setState(() {
          selectedImageBytes = bytes;
          selectedImageName = fileName;
          usePhotoUrl = false;
          photoUrl = null;
          photoUrlController.clear();
        });
      }
    } catch (e) {
      _showError('Error picking image: $e');
    }
  }

  void _showImagePickerDialog() {
    if (kIsWeb) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder, color: Colors.green),
                title: const Text('Choose from File System'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link, color: Colors.orange),
                title: const Text('Use Image URL'),
                onTap: () {
                  Navigator.pop(context);
                  _showPhotoUrlDialog();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.link, color: Colors.orange),
                title: const Text('Use Image URL'),
                onTap: () {
                  Navigator.pop(context);
                  _showPhotoUrlDialog();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    }
  }

  void _showPhotoUrlDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Image URL'),
        content: TextField(
          controller: photoUrlController,
          decoration: const InputDecoration(
            hintText: 'https://example.com/image.jpg',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final url = photoUrlController.text.trim();
              if (url.isNotEmpty &&
                  Uri.tryParse(url)?.hasAbsolutePath == true) {
                setState(() {
                  photoUrl = url;
                  usePhotoUrl = true;
                  selectedImageBytes = null;
                  selectedImageName = null;
                });
                Navigator.pop(context);
              } else {
                _showError('Please enter a valid URL');
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _removePhoto() {
    setState(() {
      selectedImageBytes = null;
      selectedImageName = null;
      photoUrl = null;
      usePhotoUrl = false;
      photoUrlController.clear();
    });
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "Not selected";
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String _formatForAPI(DateTime? dateTime) {
    if (dateTime == null) return "";
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00Z";
  }

  Future<void> _createVisitor() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedSiteId == null) {
      _showError("Please select a site");
      return;
    }

    if (selectedSectionIds.isEmpty) {
      _showError("Please select at least one section");
      return;
    }

    if (selectedApproversIds.length != 2) {
      _showError(
          "Exactly 2 approvers are required. Selected: ${selectedApproversIds.length}");
      return;
    }

    if (designatedCheckIn == null) {
      _showError("Please select check-in time");
      return;
    }

    if (designatedCheckOut == null) {
      _showError("Please select check-out time");
      return;
    }

    setState(() => isLoading = true);

    try {
      final Map<String, dynamic> requestBody = {
        "site_id": selectedSiteId,
        "full_name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "phone_number": phoneNumberController.text.trim(),
        "requested_section_ids": selectedSectionIds,
        "selected_approvers_ids": selectedApproversIds,
        "designated_check_in": _formatForAPI(designatedCheckIn),
        "designated_check_out": _formatForAPI(designatedCheckOut),
      };

      // Add optional fields
      if (companyNameController.text.trim().isNotEmpty) {
        requestBody["company_name"] = companyNameController.text.trim();
      }
      if (purposeOfVisitController.text.trim().isNotEmpty) {
        requestBody["purpose_of_visit"] = purposeOfVisitController.text.trim();
      }
      if (hostDepartmentController.text.trim().isNotEmpty) {
        requestBody["host_department"] = hostDepartmentController.text.trim();
      }
      if (meetingRoomController.text.trim().isNotEmpty) {
        requestBody["meeting_room"] = meetingRoomController.text.trim();
      }
      if (vehicleNumberController.text.trim().isNotEmpty) {
        requestBody["vehicle_number"] = vehicleNumberController.text.trim();
      }
      if (idCardNumberController.text.trim().isNotEmpty) {
        requestBody["id_card_number"] = idCardNumberController.text.trim();
      }

      Map<String, dynamic> response;

      if (selectedImageBytes != null) {
        final photoData = {
          'name': selectedImageName ?? 'photo.jpg',
          'bytes': selectedImageBytes!,
        };
        response = await ApiService.createVisitorWithPhotoWeb(
          requestBody,
          photoData,
        );
      } else if (photoUrl != null && photoUrl!.isNotEmpty) {
        requestBody["photo_url"] = photoUrl;
        response = await ApiService.createVisitor(requestBody);
      } else {
        response = await ApiService.createVisitor(requestBody);
      }

      if (mounted) {
        if (response['visitor'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Visitor created successfully!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        } else {
          _showError(response.toString());
        }
      }
    } catch (e) {
      if (mounted) {
        _showError("Error: $e");
      }
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  String get _selectedSiteName {
    if (selectedSiteId == null) return "Select a site";
    final site =
        sites.firstWhere((s) => s['id'] == selectedSiteId, orElse: () => null);
    return site != null ? site['name'] : "Select a site";
  }

  String get _selectedSectionsPreview {
    if (selectedSectionIds.isEmpty) return "Select sections";
    if (selectedSectionIds.length == 1) {
      final section = sections.firstWhere(
          (s) => s['id'] == selectedSectionIds.first,
          orElse: () => null);
      return section != null ? section['name'] : "1 section selected";
    }
    return "${selectedSectionIds.length} sections selected";
  }

  String get _selectedApproversPreview {
    if (selectedApproversIds.isEmpty) return "Select 2 approvers";
    if (selectedApproversIds.length == 1) {
      final emp = employees.firstWhere(
          (e) => e['id'] == selectedApproversIds.first,
          orElse: () => null);
      final name = emp != null
          ? emp['full_name']?.split(' ').first ?? 'Unknown'
          : 'Unknown';
      return "$name • 1/2 selected (need 1 more)";
    }
    if (selectedApproversIds.length == 2) {
      final names = selectedApproversIds.map((id) {
        final emp =
            employees.firstWhere((e) => e['id'] == id, orElse: () => null);
        return emp != null
            ? emp['full_name']?.split(' ').first ?? 'Unknown'
            : 'Unknown';
      }).join(' & ');
      return "$names • 2/2 selected ✓";
    }
    return "${selectedApproversIds.length}/2 approvers selected";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Create Visitor",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 24),
                  _buildRequiredFieldsCard(),
                  const SizedBox(height: 24),
                  _buildPhotoSection(),
                  const SizedBox(height: 24),
                  _buildOptionalFieldsCard(),
                  const SizedBox(height: 32),
                  MyButton(
                    buttonText: "Create Visitor",
                    onTap: isLoading ? null : _createVisitor,
                  ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            child: const Icon(Icons.person_add_alt_1,
                color: Colors.blue, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Visitor Registration",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "Fill in the details to register a new visitor",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredFieldsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Row(
            children: [
              Icon(Icons.info, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text(
                "Required Fields",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Site Selection
          _buildFormField(
            label: "Site *",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSiteDropdownVisible = !isSiteDropdownVisible;
                      if (isSiteDropdownVisible) {
                        isSectionDropdownVisible = false;
                        isApproverDropdownVisible = false;
                        siteSearchQuery = '';
                      }
                    });
                  },
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
                        Icon(Icons.business, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedSiteName,
                            style: TextStyle(
                              color: selectedSiteId == null
                                  ? Colors.grey[500]
                                  : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(
                          isSiteDropdownVisible
                              ? Icons.expand_less
                              : Icons.expand_more,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
                if (isSiteDropdownVisible && !isLoadingSites)
                  _buildSiteDropdown(),
                if (isLoadingSites && isSiteDropdownVisible)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sections Selection
          _buildFormField(
            label: "Sections *",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: selectedSiteId != null
                      ? () {
                          setState(() {
                            isSectionDropdownVisible =
                                !isSectionDropdownVisible;
                            if (isSectionDropdownVisible) {
                              isSiteDropdownVisible = false;
                              isApproverDropdownVisible = false;
                              sectionSearchQuery = '';
                            }
                          });
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: selectedSiteId == null
                          ? Colors.grey[100]
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedSiteId == null
                            ? Colors.grey[200]!
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_city,
                            size: 20,
                            color: selectedSiteId == null
                                ? Colors.grey[400]
                                : Colors.grey[600]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedSectionsPreview,
                            style: TextStyle(
                              color: selectedSectionIds.isEmpty
                                  ? Colors.grey[500]
                                  : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (selectedSiteId != null)
                          Icon(
                            isSectionDropdownVisible
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                      ],
                    ),
                  ),
                ),
                if (selectedSiteId == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 12, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          "Please select a site first",
                          style: TextStyle(
                              fontSize: 11, color: Colors.orange[600]),
                        ),
                      ],
                    ),
                  ),
                if (isSectionDropdownVisible &&
                    selectedSiteId != null &&
                    !isLoadingSections)
                  _buildSectionDropdown(),
                if (isLoadingSections && isSectionDropdownVisible)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Full Name
          _buildFormField(
            label: "Full Name *",
            child: MyTextFieldValidator(
              controller: fullNameController,
              hintText: "John Visitor",
              obscureText: false,
              horizontalPadding: 0,
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return "Full name is required";
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),

          // Email
          _buildFormField(
            label: "Email *",
            child: MyTextFieldValidator(
              controller: emailController,
              hintText: "john@example.com",
              obscureText: false,
              horizontalPadding: 0,
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return "Email is required";
                if (!value.contains('@')) return "Enter a valid email";
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),

          // Phone Number
          _buildFormField(
            label: "Phone Number *",
            child: MyTextFieldValidator(
              controller: phoneNumberController,
              hintText: "+1234567890",
              obscureText: false,
              horizontalPadding: 0,
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return "Phone number is required";
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),

          // Designated Check-in
          _buildFormField(
            label: "Designated Check-in *",
            child: GestureDetector(
              onTap: () => _selectCheckInDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _formatDateTime(designatedCheckIn),
                        style: TextStyle(
                          color: designatedCheckIn == null
                              ? Colors.grey[500]
                              : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down,
                        size: 20, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Designated Check-out
          _buildFormField(
            label: "Designated Check-out *",
            child: GestureDetector(
              onTap: () => _selectCheckOutDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _formatDateTime(designatedCheckOut),
                        style: TextStyle(
                          color: designatedCheckOut == null
                              ? Colors.grey[500]
                              : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down,
                        size: 20, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Approvers Selection
          _buildFormField(
            label: "Approvers * (Exactly 2)",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isApproverDropdownVisible = !isApproverDropdownVisible;
                      if (isApproverDropdownVisible) {
                        isSiteDropdownVisible = false;
                        isSectionDropdownVisible = false;
                        approverSearchQuery = '';
                      }
                    });
                  },
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
                        Icon(Icons.verified_user,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedApproversPreview,
                            style: TextStyle(
                              color: selectedApproversIds.isEmpty
                                  ? Colors.grey[500]
                                  : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(
                          isApproverDropdownVisible
                              ? Icons.expand_less
                              : Icons.expand_more,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedApproversIds.length == 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle,
                              size: 12, color: Colors.green[600]),
                          const SizedBox(width: 6),
                          Text(
                            "2 approvers selected",
                            style: TextStyle(
                                fontSize: 11, color: Colors.green[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isApproverDropdownVisible) _buildApproverDropdown(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSiteDropdown() {
    final filteredSites = sites.where((site) {
      final name = site['name']?.toLowerCase() ?? '';
      final address = site['address']?.toLowerCase() ?? '';
      final query = siteSearchQuery.toLowerCase();
      return name.contains(query) || address.contains(query);
    }).toList();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search sites...",
                      prefixIcon: const Icon(Icons.search, size: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    onChanged: (query) {
                      setState(() => siteSearchQuery = query);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    setState(() {
                      isSiteDropdownVisible = false;
                      siteSearchQuery = '';
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredSites.length,
              itemBuilder: (context, index) {
                final site = filteredSites[index];
                final isSelected = selectedSiteId == site['id'];

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedSiteId = site['id'];
                      isSiteDropdownVisible = false;
                      siteSearchQuery = '';
                      _fetchSectionsForSite(selectedSiteId!);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.withOpacity(0.05)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.business,
                            size: 18,
                            color: isSelected ? Colors.blue : Colors.grey[500]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                site['name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color:
                                      isSelected ? Colors.blue : Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              if (site['address'] != null &&
                                  site['address'].toString().isNotEmpty)
                                Text(
                                  site['address'],
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey[500]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle,
                              size: 16, color: Colors.blue),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionDropdown() {
    final filteredSections = sections.where((section) {
      final name = section['name']?.toLowerCase() ?? '';
      final code = section['code']?.toLowerCase() ?? '';
      final query = sectionSearchQuery.toLowerCase();
      return name.contains(query) || code.contains(query);
    }).toList();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search sections...",
                      prefixIcon: const Icon(Icons.search, size: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    onChanged: (query) {
                      setState(() => sectionSearchQuery = query);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    setState(() {
                      isSectionDropdownVisible = false;
                      sectionSearchQuery = '';
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          if (selectedSectionIds.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Text(
                    '${selectedSectionIds.length} section(s) selected',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedSectionIds.clear();
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(fontSize: 12, color: Colors.red[400]),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredSections.length,
              itemBuilder: (context, index) {
                final section = filteredSections[index];
                final isSelected = selectedSectionIds.contains(section['id']);

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedSectionIds.remove(section['id']);
                      } else {
                        selectedSectionIds.add(section['id']);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.withOpacity(0.05)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSelected,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                selectedSectionIds.add(section['id']);
                              } else {
                                selectedSectionIds.remove(section['id']);
                              }
                            });
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          activeColor: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section['name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    section['code'] ?? '',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[500]),
                                  ),
                                  if (section['requires_escort'] == true) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'Escort Required',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.orange[700]),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isSectionDropdownVisible = false;
                    sectionSearchQuery = '';
                  });
                },
                child: const Text('Close'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApproverDropdown() {
    final filteredEmployees = employees.where((emp) {
      final name = emp['full_name']?.toLowerCase() ?? '';
      final email = emp['email']?.toLowerCase() ?? '';
      final query = approverSearchQuery.toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search employees...",
                      prefixIcon: const Icon(Icons.search, size: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    onChanged: (query) {
                      setState(() => approverSearchQuery = query);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    setState(() {
                      isApproverDropdownVisible = false;
                      approverSearchQuery = '';
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Selection status indicator
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selectedApproversIds.length == 2
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  selectedApproversIds.length == 2
                      ? Icons.check_circle
                      : Icons.info_outline,
                  size: 16,
                  color: selectedApproversIds.length == 2
                      ? Colors.green
                      : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedApproversIds.length == 2
                        ? "✓ 2 approvers selected - Ready to submit"
                        : "${selectedApproversIds.length}/2 approvers selected - Need exactly 2",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: selectedApproversIds.length == 2
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 16),

          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee = filteredEmployees[index];
                final isSelected =
                    selectedApproversIds.contains(employee['id']);
                // Disable unselected items when we already have 2 selected
                final isDisabled =
                    !isSelected && selectedApproversIds.length >= 2;

                return Opacity(
                  opacity: isDisabled ? 0.5 : 1.0,
                  child: InkWell(
                    onTap: isDisabled
                        ? null
                        : () {
                            setState(() {
                              if (isSelected) {
                                selectedApproversIds.remove(employee['id']);
                              } else if (selectedApproversIds.length < 2) {
                                selectedApproversIds.add(employee['id']);
                              }
                            });
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.withOpacity(0.05)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                isSelected ? Colors.blue : Colors.grey[200],
                            child: Text(
                              (employee['full_name']?[0] ?? '?').toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee['full_name'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  employee['email'] ?? '',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey[500]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (employee['department'] != null)
                                  Text(
                                    '${employee['department']} • ${employee['designation'] ?? ''}',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey[400]),
                                  ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_circle,
                                size: 16, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Close button
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isApproverDropdownVisible = false;
                    approverSearchQuery = '';
                  });
                },
                child: const Text('Close'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Row(
            children: [
              Icon(Icons.photo_camera, size: 16, color: Colors.purple),
              SizedBox(width: 8),
              Text(
                "Visitor Photo (Optional)",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Photo preview
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                // Preview area
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: selectedImageBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            selectedImageBytes!,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.grey[200],
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.broken_image,
                                        size: 48, color: Colors.grey),
                                    SizedBox(height: 8),
                                    Text(
                                      'Failed to load image',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : photoUrl != null && photoUrl!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                photoUrl!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: double.infinity,
                                    height: 150,
                                    color: Colors.grey[200],
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.broken_image,
                                            size: 48, color: Colors.grey),
                                        SizedBox(height: 8),
                                        Text(
                                          'Failed to load image',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.grey[100],
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_camera,
                                      size: 48, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text(
                                    'No photo selected',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                ),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _showImagePickerDialog,
                          icon: const Icon(Icons.add_photo_alternate, size: 18),
                          label: const Text('Add Photo'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            side: BorderSide(color: Colors.purple.shade300),
                            foregroundColor: Colors.purple,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (selectedImageBytes != null ||
                          (photoUrl != null && photoUrl!.isNotEmpty))
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _removePhoto,
                            icon: const Icon(Icons.delete_outline, size: 18),
                            label: const Text('Remove'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              side: BorderSide(color: Colors.red.shade300),
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Info text
          if (selectedImageBytes == null &&
              (photoUrl == null || photoUrl!.isEmpty))
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 12, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'You can upload an image from gallery, take a photo, or provide an image URL',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOptionalFieldsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                "Optional Fields",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFormField(
            label: "Company Name",
            child: MyTextField(
              controller: companyNameController,
              hintText: "Tech Solutions Inc.",
              obscureText: false,
              horizontalPadding: 0,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Purpose of Visit",
            child: MyTextField(
              controller: purposeOfVisitController,
              hintText: "Meeting with IT department",
              obscureText: false,
              horizontalPadding: 0,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Host Department",
            child: MyTextField(
              controller: hostDepartmentController,
              hintText: "IT Department",
              obscureText: false,
              horizontalPadding: 0,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Meeting Room",
            child: MyTextField(
              controller: meetingRoomController,
              hintText: "Conference Room A",
              obscureText: false,
              horizontalPadding: 0,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Vehicle Number",
            child: MyTextField(
              controller: vehicleNumberController,
              hintText: "KA01AB1234",
              obscureText: false,
              horizontalPadding: 0,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "ID Card Number",
            child: MyTextField(
              controller: idCardNumberController,
              hintText: "ID123456",
              obscureText: false,
              horizontalPadding: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

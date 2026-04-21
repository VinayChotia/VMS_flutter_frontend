// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:modernlogintute/components/my_button.dart';
// import 'package:modernlogintute/components/my_textfield.dart';

// class CreateVisitorPage extends StatefulWidget {
//   const CreateVisitorPage({super.key});

//   @override
//   State<CreateVisitorPage> createState() => _CreateVisitorPageState();
// }

// class _CreateVisitorPageState extends State<CreateVisitorPage> {
//   // Controllers for text fields
//   final fullNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final companyNameController = TextEditingController();
//   final purposeOfVisitController = TextEditingController();
//   final hostDepartmentController = TextEditingController();
//   final meetingRoomController = TextEditingController();

//   // DateTime fields
//   DateTime? designatedCheckIn;
//   DateTime? designatedCheckOut;

//   // Multi-select approvers
//   List<int> selectedApproversIds = [];

//   // Photo upload
//   String? photoPath;

//   bool isLoading = false;

//   // Mock approvers list - replace with actual API call
//   final List<Map<String, dynamic>> mockApprovers = const [
//     {"id": 1, "name": "John Manager", "department": "IT"},
//     {"id": 2, "name": "Sarah Director", "department": "HR"},
//     {"id": 3, "name": "Mike Supervisor", "department": "Security"},
//     {"id": 4, "name": "Emily Coordinator", "department": "Facilities"},
//     {"id": 5, "name": "David Head", "department": "Operations"},
//   ];

//   // Form validation
//   final _formKey = GlobalKey<FormState>();

//   Future<void> _selectCheckInDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: designatedCheckIn ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//     if (picked != null) {
//       final TimeOfDay? time = await showTimePicker(
//         context: context,
//         initialTime:
//             TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
//       );
//       if (time != null) {
//         setState(() {
//           designatedCheckIn = DateTime(
//             picked.year,
//             picked.month,
//             picked.day,
//             time.hour,
//             time.minute,
//           );
//         });
//       }
//     }
//   }

//   Future<void> _selectCheckOutDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: designatedCheckOut ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//     if (picked != null) {
//       final TimeOfDay? time = await showTimePicker(
//         context: context,
//         initialTime:
//             TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
//       );
//       if (time != null) {
//         setState(() {
//           designatedCheckOut = DateTime(
//             picked.year,
//             picked.month,
//             picked.day,
//             time.hour,
//             time.minute,
//           );
//         });
//       }
//     }
//   }

//   String _formatDateTime(DateTime? dateTime) {
//     if (dateTime == null) return "Not selected";
//     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
//   }

//   String _formatForAPI(DateTime? dateTime) {
//     if (dateTime == null) return "";
//     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00Z";
//   }

//   Future<void> _createVisitor() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (designatedCheckIn == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please select check-in time"),
//             backgroundColor: Colors.red),
//       );
//       return;
//     }

//     if (designatedCheckOut == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please select check-out time"),
//             backgroundColor: Colors.red),
//       );
//       return;
//     }

//     if (selectedApproversIds.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please select at least one approver"),
//             backgroundColor: Colors.red),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     // Get token from wherever you store it (shared_preferences, etc.)
//     final String token = "YOUR_TOKEN_HERE"; // Replace with actual token

//     try {
//       final Map<String, dynamic> requestBody = {
//         "full_name": fullNameController.text.trim(),
//         "email": emailController.text.trim(),
//         "phone_number": phoneNumberController.text.trim(),
//         "selected_approvers_ids": selectedApproversIds,
//         "designated_check_in": _formatForAPI(designatedCheckIn),
//         "designated_check_out": _formatForAPI(designatedCheckOut),
//       };

//       // Add optional fields if they have values
//       if (companyNameController.text.trim().isNotEmpty) {
//         requestBody["company_name"] = companyNameController.text.trim();
//       }
//       if (purposeOfVisitController.text.trim().isNotEmpty) {
//         requestBody["purpose_of_visit"] = purposeOfVisitController.text.trim();
//       }
//       if (hostDepartmentController.text.trim().isNotEmpty) {
//         requestBody["host_department"] = hostDepartmentController.text.trim();
//       }
//       if (meetingRoomController.text.trim().isNotEmpty) {
//         requestBody["meeting_room"] = meetingRoomController.text.trim();
//       }

//       final response = await http.post(
//         Uri.parse(
//             'http://localhost:8000/visitors/'), // Replace with your actual base URL
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(requestBody),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text("Visitor created successfully!"),
//               backgroundColor: Colors.green),
//         );
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(data.toString()), backgroundColor: Colors.red),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     }

//     setState(() => isLoading = false);
//   }

//   void _showApproversDialog() {
//     List<int> tempSelected = List.from(selectedApproversIds);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: const Text("Select Approvers"),
//               content: SizedBox(
//                 width: double.maxFinite,
//                 height: 300,
//                 child: ListView.builder(
//                   itemCount: mockApprovers.length,
//                   itemBuilder: (context, index) {
//                     final approver = mockApprovers[index];
//                     final isSelected = tempSelected.contains(approver["id"]);
//                     return CheckboxListTile(
//                       title: Text(approver["name"]),
//                       subtitle: Text(approver["department"]),
//                       value: isSelected,
//                       onChanged: (selected) {
//                         setStateDialog(() {
//                           if (selected == true) {
//                             tempSelected.add(approver["id"]);
//                           } else {
//                             tempSelected.remove(approver["id"]);
//                           }
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       selectedApproversIds = tempSelected;
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Confirm"),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Create Visitor",
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Icon(Icons.person_add_alt_1,
//                             color: Colors.blue, size: 28),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Visitor Registration",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "Fill in the details to register a new visitor",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 // Required Fields Section
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.info, size: 16, color: Colors.red),
//                           const SizedBox(width: 4),
//                           Text(
//                             "Required Fields",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Full Name
//                       _buildLabel("Full Name *"),
//                       MyTextFieldValidator(
//                         controller: fullNameController,
//                         hintText: "John Visitor",
//                         obscureText: false,
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Full name is required";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 12),

//                       // Email
//                       _buildLabel("Email *"),
//                       MyTextFieldValidator(
//                         controller: emailController,
//                         hintText: "john@example.com",
//                         obscureText: false,
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Email is required";
//                           }
//                           if (!value.contains('@')) {
//                             return "Enter a valid email";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 12),

//                       // Phone Number
//                       _buildLabel("Phone Number *"),
//                       MyTextFieldValidator(
//                         controller: phoneNumberController,
//                         hintText: "+1234567890",
//                         obscureText: false,
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Phone number is required";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 12),

//                       // Check-in Date & Time
//                       _buildLabel("Designated Check-in *"),
//                       GestureDetector(
//                         onTap: () => _selectCheckInDate(context),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 14),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey[300]!),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.calendar_today,
//                                   size: 18, color: Colors.grey[600]),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   _formatDateTime(designatedCheckIn),
//                                   style: TextStyle(
//                                     color: designatedCheckIn == null
//                                         ? Colors.grey[500]
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down,
//                                   color: Colors.grey[600]),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Check-out Date & Time
//                       _buildLabel("Designated Check-out *"),
//                       GestureDetector(
//                         onTap: () => _selectCheckOutDate(context),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 14),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey[300]!),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.calendar_today,
//                                   size: 18, color: Colors.grey[600]),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   _formatDateTime(designatedCheckOut),
//                                   style: TextStyle(
//                                     color: designatedCheckOut == null
//                                         ? Colors.grey[500]
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down,
//                                   color: Colors.grey[600]),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Approvers
//                       _buildLabel("Selected Approvers *"),
//                       GestureDetector(
//                         onTap: _showApproversDialog,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 14),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey[300]!),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.people,
//                                   size: 18, color: Colors.grey[600]),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   selectedApproversIds.isEmpty
//                                       ? "Select approvers"
//                                       : "${selectedApproversIds.length} approver(s) selected",
//                                   style: TextStyle(
//                                     color: selectedApproversIds.isEmpty
//                                         ? Colors.grey[500]
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down,
//                                   color: Colors.grey[600]),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Optional Fields Section
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.info_outline,
//                               size: 16, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           Text(
//                             "Optional Fields",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Company Name
//                       _buildLabel("Company Name"),
//                       MyTextField(
//                         controller: companyNameController,
//                         hintText: "Tech Solutions Inc.",
//                         obscureText: false,
//                       ),
//                       const SizedBox(height: 12),

//                       // Purpose of Visit
//                       _buildLabel("Purpose of Visit"),
//                       MyTextField(
//                         controller: purposeOfVisitController,
//                         hintText: "Meeting with IT department",
//                         obscureText: false,
//                       ),
//                       const SizedBox(height: 12),

//                       // Host Department
//                       _buildLabel("Host Department"),
//                       MyTextField(
//                         controller: hostDepartmentController,
//                         hintText: "IT Department",
//                         obscureText: false,
//                       ),
//                       const SizedBox(height: 12),

//                       // Meeting Room
//                       _buildLabel("Meeting Room"),
//                       MyTextField(
//                         controller: meetingRoomController,
//                         hintText: "Conference Room A",
//                         obscureText: false,
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 // Submit Button
//                 MyButton(
//                   buttonText: "Create Visitor",
//                   onTap: isLoading ? null : _createVisitor,
//                 ),

//                 if (isLoading)
//                   const Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Center(child: CircularProgressIndicator()),
//                   ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w500,
//           color: Colors.grey[700],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';

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

  // DateTime fields
  DateTime? designatedCheckIn;
  DateTime? designatedCheckOut;

  // Multi-select approvers
  List<int> selectedApproversIds = [];

  bool isLoading = false;

  final List<Map<String, dynamic>> mockApprovers = const [
    {"id": 1, "name": "John Manager", "department": "IT"},
    {"id": 2, "name": "Sarah Director", "department": "HR"},
    {"id": 3, "name": "Mike Supervisor", "department": "Security"},
    {"id": 4, "name": "Emily Coordinator", "department": "Facilities"},
    {"id": 5, "name": "David Head", "department": "Operations"},
  ];

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: designatedCheckIn ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
      );
      if (time != null) {
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
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
      );
      if (time != null) {
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

    if (designatedCheckIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select check-in time"),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (designatedCheckOut == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select check-out time"),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (selectedApproversIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select at least one approver"),
            backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => isLoading = true);

    final String token = "YOUR_TOKEN_HERE";

    try {
      final Map<String, dynamic> requestBody = {
        "full_name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "phone_number": phoneNumberController.text.trim(),
        "selected_approvers_ids": selectedApproversIds,
        "designated_check_in": _formatForAPI(designatedCheckIn),
        "designated_check_out": _formatForAPI(designatedCheckOut),
      };

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

      final response = await http.post(
        Uri.parse('http://localhost:8000/visitors/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Visitor created successfully!"),
              backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data.toString()), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }

    setState(() => isLoading = false);
  }

  void _showApproversDialog() {
    List<int> tempSelected = List.from(selectedApproversIds);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Approvers"),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: mockApprovers.length,
                  itemBuilder: (context, index) {
                    final approver = mockApprovers[index];
                    final isSelected = tempSelected.contains(approver["id"]);
                    return CheckboxListTile(
                      title: Text(approver["name"]),
                      subtitle: Text(approver["department"]),
                      value: isSelected,
                      onChanged: (selected) {
                        setStateDialog(() {
                          if (selected == true) {
                            tempSelected.add(approver["id"]);
                          } else {
                            tempSelected.remove(approver["id"]);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedApproversIds = tempSelected;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Create Visitor",
          style: TextStyle(color: Colors.white),
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
            padding: const EdgeInsets.all(20.0), // Consistent outer padding
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Fill in the details to register a new visitor",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Required Fields Card
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
                        // Section Header
                        const Row(
                          children: [
                            Icon(Icons.info, size: 16, color: Colors.red),
                            SizedBox(width: 6),
                            Text(
                              "Required Fields",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Form Fields with consistent spacing
                        _buildFormField(
                          label: "Full Name *",
                          child: MyTextFieldValidator(
                            controller: fullNameController,
                            hintText: "John Visitor",
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Full name is required";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Email *",
                          child: MyTextFieldValidator(
                            controller: emailController,
                            hintText: "john@example.com",
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Email is required";
                              }
                              if (!value.contains('@')) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Phone Number *",
                          child: MyTextFieldValidator(
                            controller: phoneNumberController,
                            hintText: "+1234567890",
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Phone number is required";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Designated Check-in *",
                          child: GestureDetector(
                            onTap: () => _selectCheckInDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
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
                                      color: Colors.grey[600]),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Designated Check-out *",
                          child: GestureDetector(
                            onTap: () => _selectCheckOutDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
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
                                      color: Colors.grey[600]),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Selected Approvers *",
                          child: GestureDetector(
                            onTap: _showApproversDialog,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.people,
                                      size: 20, color: Colors.grey[600]),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      selectedApproversIds.isEmpty
                                          ? "Select approvers"
                                          : "${selectedApproversIds.length} approver(s) selected",
                                      style: TextStyle(
                                        color: selectedApproversIds.isEmpty
                                            ? Colors.grey[500]
                                            : Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.grey[600]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Optional Fields Card
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
                        // Section Header
                        const Row(
                          children: [
                            Icon(Icons.info_outline,
                                size: 16, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              "Optional Fields",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Optional Form Fields
                        _buildFormField(
                          label: "Company Name",
                          child: MyTextField(
                            controller: companyNameController,
                            hintText: "Tech Solutions Inc.",
                            obscureText: false,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Purpose of Visit",
                          child: MyTextField(
                            controller: purposeOfVisitController,
                            hintText: "Meeting with IT department",
                            obscureText: false,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Host Department",
                          child: MyTextField(
                            controller: hostDepartmentController,
                            hintText: "IT Department",
                            obscureText: false,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: "Meeting Room",
                          child: MyTextField(
                            controller: meetingRoomController,
                            hintText: "Conference Room A",
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Submit Button
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

  Widget _buildFormField({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
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

// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import 'package:modernlogintute/components/my_button.dart';
// // // import 'package:modernlogintute/components/my_textfield.dart';

// // // class CreateVisitorPage extends StatefulWidget {
// // //   const CreateVisitorPage({super.key});

// // //   @override
// // //   State<CreateVisitorPage> createState() => _CreateVisitorPageState();
// // // }

// // // class _CreateVisitorPageState extends State<CreateVisitorPage> {
// // //   // Controllers for text fields
// // //   final fullNameController = TextEditingController();
// // //   final emailController = TextEditingController();
// // //   final phoneNumberController = TextEditingController();
// // //   final companyNameController = TextEditingController();
// // //   final purposeOfVisitController = TextEditingController();
// // //   final hostDepartmentController = TextEditingController();
// // //   final meetingRoomController = TextEditingController();

// // //   // DateTime fields
// // //   DateTime? designatedCheckIn;
// // //   DateTime? designatedCheckOut;

// // //   // Multi-select approvers
// // //   List<int> selectedApproversIds = [];

// // //   // Photo upload
// // //   String? photoPath;

// // //   bool isLoading = false;

// // //   // Mock approvers list - replace with actual API call
// // //   final List<Map<String, dynamic>> mockApprovers = const [
// // //     {"id": 1, "name": "John Manager", "department": "IT"},
// // //     {"id": 2, "name": "Sarah Director", "department": "HR"},
// // //     {"id": 3, "name": "Mike Supervisor", "department": "Security"},
// // //     {"id": 4, "name": "Emily Coordinator", "department": "Facilities"},
// // //     {"id": 5, "name": "David Head", "department": "Operations"},
// // //   ];

// // //   // Form validation
// // //   final _formKey = GlobalKey<FormState>();

// // //   Future<void> _selectCheckInDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: designatedCheckIn ?? DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime.now().add(const Duration(days: 365)),
// // //     );
// // //     if (picked != null) {
// // //       final TimeOfDay? time = await showTimePicker(
// // //         context: context,
// // //         initialTime:
// // //             TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
// // //       );
// // //       if (time != null) {
// // //         setState(() {
// // //           designatedCheckIn = DateTime(
// // //             picked.year,
// // //             picked.month,
// // //             picked.day,
// // //             time.hour,
// // //             time.minute,
// // //           );
// // //         });
// // //       }
// // //     }
// // //   }

// // //   Future<void> _selectCheckOutDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: designatedCheckOut ?? DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime.now().add(const Duration(days: 365)),
// // //     );
// // //     if (picked != null) {
// // //       final TimeOfDay? time = await showTimePicker(
// // //         context: context,
// // //         initialTime:
// // //             TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
// // //       );
// // //       if (time != null) {
// // //         setState(() {
// // //           designatedCheckOut = DateTime(
// // //             picked.year,
// // //             picked.month,
// // //             picked.day,
// // //             time.hour,
// // //             time.minute,
// // //           );
// // //         });
// // //       }
// // //     }
// // //   }

// // //   String _formatDateTime(DateTime? dateTime) {
// // //     if (dateTime == null) return "Not selected";
// // //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
// // //   }

// // //   String _formatForAPI(DateTime? dateTime) {
// // //     if (dateTime == null) return "";
// // //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00Z";
// // //   }

// // //   Future<void> _createVisitor() async {
// // //     if (!_formKey.currentState!.validate()) return;

// // //     if (designatedCheckIn == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //             content: Text("Please select check-in time"),
// // //             backgroundColor: Colors.red),
// // //       );
// // //       return;
// // //     }

// // //     if (designatedCheckOut == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //             content: Text("Please select check-out time"),
// // //             backgroundColor: Colors.red),
// // //       );
// // //       return;
// // //     }

// // //     if (selectedApproversIds.isEmpty) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //             content: Text("Please select at least one approver"),
// // //             backgroundColor: Colors.red),
// // //       );
// // //       return;
// // //     }

// // //     setState(() => isLoading = true);

// // //     // Get token from wherever you store it (shared_preferences, etc.)
// // //     final String token = "YOUR_TOKEN_HERE"; // Replace with actual token

// // //     try {
// // //       final Map<String, dynamic> requestBody = {
// // //         "full_name": fullNameController.text.trim(),
// // //         "email": emailController.text.trim(),
// // //         "phone_number": phoneNumberController.text.trim(),
// // //         "selected_approvers_ids": selectedApproversIds,
// // //         "designated_check_in": _formatForAPI(designatedCheckIn),
// // //         "designated_check_out": _formatForAPI(designatedCheckOut),
// // //       };

// // //       // Add optional fields if they have values
// // //       if (companyNameController.text.trim().isNotEmpty) {
// // //         requestBody["company_name"] = companyNameController.text.trim();
// // //       }
// // //       if (purposeOfVisitController.text.trim().isNotEmpty) {
// // //         requestBody["purpose_of_visit"] = purposeOfVisitController.text.trim();
// // //       }
// // //       if (hostDepartmentController.text.trim().isNotEmpty) {
// // //         requestBody["host_department"] = hostDepartmentController.text.trim();
// // //       }
// // //       if (meetingRoomController.text.trim().isNotEmpty) {
// // //         requestBody["meeting_room"] = meetingRoomController.text.trim();
// // //       }

// // //       final response = await http.post(
// // //         Uri.parse(
// // //             'http://localhost:8000/visitors/'), // Replace with your actual base URL
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $token',
// // //         },
// // //         body: jsonEncode(requestBody),
// // //       );

// // //       final data = jsonDecode(response.body);

// // //       if (response.statusCode == 200 || response.statusCode == 201) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //               content: Text("Visitor created successfully!"),
// // //               backgroundColor: Colors.green),
// // //         );
// // //         Navigator.pop(context);
// // //       } else {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text(data.toString()), backgroundColor: Colors.red),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
// // //       );
// // //     }

// // //     setState(() => isLoading = false);
// // //   }

// // //   void _showApproversDialog() {
// // //     List<int> tempSelected = List.from(selectedApproversIds);

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setStateDialog) {
// // //             return AlertDialog(
// // //               title: const Text("Select Approvers"),
// // //               content: SizedBox(
// // //                 width: double.maxFinite,
// // //                 height: 300,
// // //                 child: ListView.builder(
// // //                   itemCount: mockApprovers.length,
// // //                   itemBuilder: (context, index) {
// // //                     final approver = mockApprovers[index];
// // //                     final isSelected = tempSelected.contains(approver["id"]);
// // //                     return CheckboxListTile(
// // //                       title: Text(approver["name"]),
// // //                       subtitle: Text(approver["department"]),
// // //                       value: isSelected,
// // //                       onChanged: (selected) {
// // //                         setStateDialog(() {
// // //                           if (selected == true) {
// // //                             tempSelected.add(approver["id"]);
// // //                           } else {
// // //                             tempSelected.remove(approver["id"]);
// // //                           }
// // //                         });
// // //                       },
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context),
// // //                   child: const Text("Cancel"),
// // //                 ),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       selectedApproversIds = tempSelected;
// // //                     });
// // //                     Navigator.pop(context);
// // //                   },
// // //                   child: const Text("Confirm"),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[100],
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.black,
// // //         title: const Text(
// // //           "Create Visitor",
// // //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
// // //         ),
// // //         centerTitle: true,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           padding: const EdgeInsets.all(20),
// // //           child: Form(
// // //             key: _formKey,
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 // Header
// // //                 Container(
// // //                   padding: const EdgeInsets.all(16),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(16),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.03),
// // //                         blurRadius: 8,
// // //                         offset: const Offset(0, 2),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Row(
// // //                     children: [
// // //                       Container(
// // //                         padding: const EdgeInsets.all(12),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.blue.withOpacity(0.1),
// // //                           borderRadius: BorderRadius.circular(12),
// // //                         ),
// // //                         child: const Icon(Icons.person_add_alt_1,
// // //                             color: Colors.blue, size: 28),
// // //                       ),
// // //                       const SizedBox(width: 16),
// // //                       Expanded(
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             const Text(
// // //                               "Visitor Registration",
// // //                               style: TextStyle(
// // //                                 fontSize: 18,
// // //                                 fontWeight: FontWeight.bold,
// // //                               ),
// // //                             ),
// // //                             const SizedBox(height: 4),
// // //                             Text(
// // //                               "Fill in the details to register a new visitor",
// // //                               style: TextStyle(
// // //                                 fontSize: 12,
// // //                                 color: Colors.grey[600],
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 24),

// // //                 // Required Fields Section
// // //                 Container(
// // //                   padding: const EdgeInsets.all(16),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(16),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.03),
// // //                         blurRadius: 8,
// // //                         offset: const Offset(0, 2),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Row(
// // //                         children: [
// // //                           const Icon(Icons.info, size: 16, color: Colors.red),
// // //                           const SizedBox(width: 4),
// // //                           Text(
// // //                             "Required Fields",
// // //                             style: TextStyle(
// // //                               fontSize: 14,
// // //                               fontWeight: FontWeight.w600,
// // //                               color: Colors.grey[800],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       const SizedBox(height: 16),

// // //                       // Full Name
// // //                       _buildLabel("Full Name *"),
// // //                       MyTextFieldValidator(
// // //                         controller: fullNameController,
// // //                         hintText: "John Visitor",
// // //                         obscureText: false,
// // //                         validator: (value) {
// // //                           if (value == null || value.trim().isEmpty) {
// // //                             return "Full name is required";
// // //                           }
// // //                           return null;
// // //                         },
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Email
// // //                       _buildLabel("Email *"),
// // //                       MyTextFieldValidator(
// // //                         controller: emailController,
// // //                         hintText: "john@example.com",
// // //                         obscureText: false,
// // //                         validator: (value) {
// // //                           if (value == null || value.trim().isEmpty) {
// // //                             return "Email is required";
// // //                           }
// // //                           if (!value.contains('@')) {
// // //                             return "Enter a valid email";
// // //                           }
// // //                           return null;
// // //                         },
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Phone Number
// // //                       _buildLabel("Phone Number *"),
// // //                       MyTextFieldValidator(
// // //                         controller: phoneNumberController,
// // //                         hintText: "+1234567890",
// // //                         obscureText: false,
// // //                         validator: (value) {
// // //                           if (value == null || value.trim().isEmpty) {
// // //                             return "Phone number is required";
// // //                           }
// // //                           return null;
// // //                         },
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Check-in Date & Time
// // //                       _buildLabel("Designated Check-in *"),
// // //                       GestureDetector(
// // //                         onTap: () => _selectCheckInDate(context),
// // //                         child: Container(
// // //                           padding: const EdgeInsets.symmetric(
// // //                               horizontal: 16, vertical: 14),
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.grey[100],
// // //                             borderRadius: BorderRadius.circular(12),
// // //                             border: Border.all(color: Colors.grey[300]!),
// // //                           ),
// // //                           child: Row(
// // //                             children: [
// // //                               Icon(Icons.calendar_today,
// // //                                   size: 18, color: Colors.grey[600]),
// // //                               const SizedBox(width: 12),
// // //                               Expanded(
// // //                                 child: Text(
// // //                                   _formatDateTime(designatedCheckIn),
// // //                                   style: TextStyle(
// // //                                     color: designatedCheckIn == null
// // //                                         ? Colors.grey[500]
// // //                                         : Colors.black,
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                               Icon(Icons.arrow_drop_down,
// // //                                   color: Colors.grey[600]),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Check-out Date & Time
// // //                       _buildLabel("Designated Check-out *"),
// // //                       GestureDetector(
// // //                         onTap: () => _selectCheckOutDate(context),
// // //                         child: Container(
// // //                           padding: const EdgeInsets.symmetric(
// // //                               horizontal: 16, vertical: 14),
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.grey[100],
// // //                             borderRadius: BorderRadius.circular(12),
// // //                             border: Border.all(color: Colors.grey[300]!),
// // //                           ),
// // //                           child: Row(
// // //                             children: [
// // //                               Icon(Icons.calendar_today,
// // //                                   size: 18, color: Colors.grey[600]),
// // //                               const SizedBox(width: 12),
// // //                               Expanded(
// // //                                 child: Text(
// // //                                   _formatDateTime(designatedCheckOut),
// // //                                   style: TextStyle(
// // //                                     color: designatedCheckOut == null
// // //                                         ? Colors.grey[500]
// // //                                         : Colors.black,
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                               Icon(Icons.arrow_drop_down,
// // //                                   color: Colors.grey[600]),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Approvers
// // //                       _buildLabel("Selected Approvers *"),
// // //                       GestureDetector(
// // //                         onTap: _showApproversDialog,
// // //                         child: Container(
// // //                           padding: const EdgeInsets.symmetric(
// // //                               horizontal: 16, vertical: 14),
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.grey[100],
// // //                             borderRadius: BorderRadius.circular(12),
// // //                             border: Border.all(color: Colors.grey[300]!),
// // //                           ),
// // //                           child: Row(
// // //                             children: [
// // //                               Icon(Icons.people,
// // //                                   size: 18, color: Colors.grey[600]),
// // //                               const SizedBox(width: 12),
// // //                               Expanded(
// // //                                 child: Text(
// // //                                   selectedApproversIds.isEmpty
// // //                                       ? "Select approvers"
// // //                                       : "${selectedApproversIds.length} approver(s) selected",
// // //                                   style: TextStyle(
// // //                                     color: selectedApproversIds.isEmpty
// // //                                         ? Colors.grey[500]
// // //                                         : Colors.black,
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                               Icon(Icons.arrow_drop_down,
// // //                                   color: Colors.grey[600]),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 20),

// // //                 // Optional Fields Section
// // //                 Container(
// // //                   padding: const EdgeInsets.all(16),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(16),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.03),
// // //                         blurRadius: 8,
// // //                         offset: const Offset(0, 2),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Row(
// // //                         children: [
// // //                           const Icon(Icons.info_outline,
// // //                               size: 16, color: Colors.grey),
// // //                           const SizedBox(width: 4),
// // //                           Text(
// // //                             "Optional Fields",
// // //                             style: TextStyle(
// // //                               fontSize: 14,
// // //                               fontWeight: FontWeight.w600,
// // //                               color: Colors.grey[800],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       const SizedBox(height: 16),

// // //                       // Company Name
// // //                       _buildLabel("Company Name"),
// // //                       MyTextField(
// // //                         controller: companyNameController,
// // //                         hintText: "Tech Solutions Inc.",
// // //                         obscureText: false,
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Purpose of Visit
// // //                       _buildLabel("Purpose of Visit"),
// // //                       MyTextField(
// // //                         controller: purposeOfVisitController,
// // //                         hintText: "Meeting with IT department",
// // //                         obscureText: false,
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Host Department
// // //                       _buildLabel("Host Department"),
// // //                       MyTextField(
// // //                         controller: hostDepartmentController,
// // //                         hintText: "IT Department",
// // //                         obscureText: false,
// // //                       ),
// // //                       const SizedBox(height: 12),

// // //                       // Meeting Room
// // //                       _buildLabel("Meeting Room"),
// // //                       MyTextField(
// // //                         controller: meetingRoomController,
// // //                         hintText: "Conference Room A",
// // //                         obscureText: false,
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 24),

// // //                 // Submit Button
// // //                 MyButton(
// // //                   buttonText: "Create Visitor",
// // //                   onTap: isLoading ? null : _createVisitor,
// // //                 ),

// // //                 if (isLoading)
// // //                   const Padding(
// // //                     padding: EdgeInsets.all(16),
// // //                     child: Center(child: CircularProgressIndicator()),
// // //                   ),

// // //                 const SizedBox(height: 20),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildLabel(String text) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(bottom: 8),
// // //       child: Text(
// // //         text,
// // //         style: TextStyle(
// // //           fontSize: 13,
// // //           fontWeight: FontWeight.w500,
// // //           color: Colors.grey[700],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import 'package:modernlogintute/components/my_button.dart';
// // // import 'package:modernlogintute/components/my_textfield.dart';

// // // class CreateVisitorPage extends StatefulWidget {
// // //   const CreateVisitorPage({super.key});

// // //   @override
// // //   State<CreateVisitorPage> createState() => _CreateVisitorPageState();
// // // }

// // // class _CreateVisitorPageState extends State<CreateVisitorPage> {
// // //   // Controllers for text fields
// // //   final fullNameController = TextEditingController();
// // //   final emailController = TextEditingController();
// // //   final phoneNumberController = TextEditingController();
// // //   final companyNameController = TextEditingController();
// // //   final purposeOfVisitController = TextEditingController();
// // //   final hostDepartmentController = TextEditingController();
// // //   final meetingRoomController = TextEditingController();

// // //   // DateTime fields
// // //   DateTime? designatedCheckIn;
// // //   DateTime? designatedCheckOut;

// // //   // Multi-select approvers
// // //   List<int> selectedApproversIds = [];

// // //   bool isLoading = false;

// // //   final List<Map<String, dynamic>> mockApprovers = const [
// // //     {"id": 1, "name": "John Manager", "department": "IT"},
// // //     {"id": 2, "name": "Sarah Director", "department": "HR"},
// // //     {"id": 3, "name": "Mike Supervisor", "department": "Security"},
// // //     {"id": 4, "name": "Emily Coordinator", "department": "Facilities"},
// // //     {"id": 5, "name": "David Head", "department": "Operations"},
// // //   ];

// // //   final _formKey = GlobalKey<FormState>();

// // //   Future<void> _selectCheckInDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: designatedCheckIn ?? DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime.now().add(const Duration(days: 365)),
// // //     );
// // //     if (picked != null) {
// // //       final TimeOfDay? time = await showTimePicker(
// // //         context: context,
// // //         initialTime:
// // //             TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
// // //       );
// // //       if (time != null) {
// // //         setState(() {
// // //           designatedCheckIn = DateTime(
// // //             picked.year,
// // //             picked.month,
// // //             picked.day,
// // //             time.hour,
// // //             time.minute,
// // //           );
// // //         });
// // //       }
// // //     }
// // //   }

// // //   Future<void> _selectCheckOutDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: designatedCheckOut ?? DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime.now().add(const Duration(days: 365)),
// // //     );
// // //     if (picked != null) {
// // //       final TimeOfDay? time = await showTimePicker(
// // //         context: context,
// // //         initialTime:
// // //             TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
// // //       );
// // //       if (time != null) {
// // //         setState(() {
// // //           designatedCheckOut = DateTime(
// // //             picked.year,
// // //             picked.month,
// // //             picked.day,
// // //             time.hour,
// // //             time.minute,
// // //           );
// // //         });
// // //       }
// // //     }
// // //   }

// // //   String _formatDateTime(DateTime? dateTime) {
// // //     if (dateTime == null) return "Not selected";
// // //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
// // //   }

// // //   String _formatForAPI(DateTime? dateTime) {
// // //     if (dateTime == null) return "";
// // //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00Z";
// // //   }

// // //   Future<void> _createVisitor() async {
// // //     if (!_formKey.currentState!.validate()) return;

// // //     if (designatedCheckIn == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //             content: Text("Please select check-in time"),
// // //             backgroundColor: Colors.red),
// // //       );
// // //       return;
// // //     }

// // //     if (designatedCheckOut == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //             content: Text("Please select check-out time"),
// // //             backgroundColor: Colors.red),
// // //       );
// // //       return;
// // //     }

// // //     if (selectedApproversIds.isEmpty) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //             content: Text("Please select at least one approver"),
// // //             backgroundColor: Colors.red),
// // //       );
// // //       return;
// // //     }

// // //     setState(() => isLoading = true);

// // //     final String token = "YOUR_TOKEN_HERE";

// // //     try {
// // //       final Map<String, dynamic> requestBody = {
// // //         "full_name": fullNameController.text.trim(),
// // //         "email": emailController.text.trim(),
// // //         "phone_number": phoneNumberController.text.trim(),
// // //         "selected_approvers_ids": selectedApproversIds,
// // //         "designated_check_in": _formatForAPI(designatedCheckIn),
// // //         "designated_check_out": _formatForAPI(designatedCheckOut),
// // //       };

// // //       if (companyNameController.text.trim().isNotEmpty) {
// // //         requestBody["company_name"] = companyNameController.text.trim();
// // //       }
// // //       if (purposeOfVisitController.text.trim().isNotEmpty) {
// // //         requestBody["purpose_of_visit"] = purposeOfVisitController.text.trim();
// // //       }
// // //       if (hostDepartmentController.text.trim().isNotEmpty) {
// // //         requestBody["host_department"] = hostDepartmentController.text.trim();
// // //       }
// // //       if (meetingRoomController.text.trim().isNotEmpty) {
// // //         requestBody["meeting_room"] = meetingRoomController.text.trim();
// // //       }

// // //       final response = await http.post(
// // //         Uri.parse('http://localhost:8000/visitors/'),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $token',
// // //         },
// // //         body: jsonEncode(requestBody),
// // //       );
// // //       print('request body for visitors ${response.body}');

// // //       final data = jsonDecode(response.body);

// // //       if (response.statusCode == 200 || response.statusCode == 201) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //               content: Text("Visitor created successfully!"),
// // //               backgroundColor: Colors.green),
// // //         );
// // //         Navigator.pop(context);
// // //       } else {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text(data.toString()), backgroundColor: Colors.red),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
// // //       );
// // //     }

// // //     setState(() => isLoading = false);
// // //   }

// // //   void _showApproversDialog() {
// // //     List<int> tempSelected = List.from(selectedApproversIds);

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setStateDialog) {
// // //             return AlertDialog(
// // //               title: const Text("Select Approvers"),
// // //               content: SizedBox(
// // //                 width: double.maxFinite,
// // //                 height: 300,
// // //                 child: ListView.builder(
// // //                   itemCount: mockApprovers.length,
// // //                   itemBuilder: (context, index) {
// // //                     final approver = mockApprovers[index];
// // //                     final isSelected = tempSelected.contains(approver["id"]);
// // //                     return CheckboxListTile(
// // //                       title: Text(approver["name"]),
// // //                       subtitle: Text(approver["department"]),
// // //                       value: isSelected,
// // //                       onChanged: (selected) {
// // //                         setStateDialog(() {
// // //                           if (selected == true) {
// // //                             tempSelected.add(approver["id"]);
// // //                           } else {
// // //                             tempSelected.remove(approver["id"]);
// // //                           }
// // //                         });
// // //                       },
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context),
// // //                   child: const Text("Cancel"),
// // //                 ),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       selectedApproversIds = tempSelected;
// // //                     });
// // //                     Navigator.pop(context);
// // //                   },
// // //                   child: const Text("Confirm"),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[100],
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.black,
// // //         title: const Text(
// // //           "Create Visitor",
// // //           style: TextStyle(color: Colors.white),
// // //         ),
// // //         centerTitle: true,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(20.0), // Consistent outer padding
// // //             child: Form(
// // //               key: _formKey,
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   // Header Card
// // //                   Container(
// // //                     padding: const EdgeInsets.all(20),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white,
// // //                       borderRadius: BorderRadius.circular(16),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.black.withOpacity(0.03),
// // //                           blurRadius: 8,
// // //                           offset: const Offset(0, 2),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Row(
// // //                       children: [
// // //                         Container(
// // //                           padding: const EdgeInsets.all(12),
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.blue.withOpacity(0.1),
// // //                             borderRadius: BorderRadius.circular(12),
// // //                           ),
// // //                           child: const Icon(Icons.person_add_alt_1,
// // //                               color: Colors.blue, size: 28),
// // //                         ),
// // //                         const SizedBox(width: 16),
// // //                         Expanded(
// // //                           child: Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               const Text(
// // //                                 "Visitor Registration",
// // //                                 style: TextStyle(
// // //                                   fontSize: 18,
// // //                                   fontWeight: FontWeight.bold,
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(height: 4),
// // //                               Text(
// // //                                 "Fill in the details to register a new visitor",
// // //                                 style: TextStyle(
// // //                                   fontSize: 12,
// // //                                   color: Colors.grey[600],
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 20),

// // //                   // Required Fields Card
// // //                   Container(
// // //                     padding: const EdgeInsets.all(20),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white,
// // //                       borderRadius: BorderRadius.circular(16),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.black.withOpacity(0.03),
// // //                           blurRadius: 8,
// // //                           offset: const Offset(0, 2),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         // Section Header
// // //                         const Row(
// // //                           children: [
// // //                             Icon(Icons.info, size: 16, color: Colors.red),
// // //                             SizedBox(width: 6),
// // //                             Text(
// // //                               "Required Fields",
// // //                               style: TextStyle(
// // //                                 fontSize: 14,
// // //                                 fontWeight: FontWeight.w600,
// // //                                 color: Colors.black87,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         const SizedBox(height: 20),

// // //                         // Form Fields with consistent spacing
// // //                         _buildFormField(
// // //                           label: "Full Name *",
// // //                           child: MyTextFieldValidator(
// // //                             controller: fullNameController,
// // //                             hintText: "John Visitor",
// // //                             obscureText: false,
// // //                             validator: (value) {
// // //                               if (value == null || value.trim().isEmpty) {
// // //                                 return "Full name is required";
// // //                               }
// // //                               return null;
// // //                             },
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Email *",
// // //                           child: MyTextFieldValidator(
// // //                             controller: emailController,
// // //                             hintText: "john@example.com",
// // //                             obscureText: false,
// // //                             validator: (value) {
// // //                               if (value == null || value.trim().isEmpty) {
// // //                                 return "Email is required";
// // //                               }
// // //                               if (!value.contains('@')) {
// // //                                 return "Enter a valid email";
// // //                               }
// // //                               return null;
// // //                             },
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Phone Number *",
// // //                           child: MyTextFieldValidator(
// // //                             controller: phoneNumberController,
// // //                             hintText: "+1234567890",
// // //                             obscureText: false,
// // //                             validator: (value) {
// // //                               if (value == null || value.trim().isEmpty) {
// // //                                 return "Phone number is required";
// // //                               }
// // //                               return null;
// // //                             },
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Designated Check-in *",
// // //                           child: GestureDetector(
// // //                             onTap: () => _selectCheckInDate(context),
// // //                             child: Container(
// // //                               padding: const EdgeInsets.symmetric(
// // //                                   horizontal: 16, vertical: 16),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.grey[100],
// // //                                 borderRadius: BorderRadius.circular(12),
// // //                                 border: Border.all(color: Colors.grey[300]!),
// // //                               ),
// // //                               child: Row(
// // //                                 children: [
// // //                                   Icon(Icons.calendar_today,
// // //                                       size: 20, color: Colors.grey[600]),
// // //                                   const SizedBox(width: 12),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       _formatDateTime(designatedCheckIn),
// // //                                       style: TextStyle(
// // //                                         color: designatedCheckIn == null
// // //                                             ? Colors.grey[500]
// // //                                             : Colors.black87,
// // //                                         fontSize: 14,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                   Icon(Icons.arrow_drop_down,
// // //                                       color: Colors.grey[600]),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Designated Check-out *",
// // //                           child: GestureDetector(
// // //                             onTap: () => _selectCheckOutDate(context),
// // //                             child: Container(
// // //                               padding: const EdgeInsets.symmetric(
// // //                                   horizontal: 16, vertical: 16),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.grey[100],
// // //                                 borderRadius: BorderRadius.circular(12),
// // //                                 border: Border.all(color: Colors.grey[300]!),
// // //                               ),
// // //                               child: Row(
// // //                                 children: [
// // //                                   Icon(Icons.calendar_today,
// // //                                       size: 20, color: Colors.grey[600]),
// // //                                   const SizedBox(width: 12),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       _formatDateTime(designatedCheckOut),
// // //                                       style: TextStyle(
// // //                                         color: designatedCheckOut == null
// // //                                             ? Colors.grey[500]
// // //                                             : Colors.black87,
// // //                                         fontSize: 14,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                   Icon(Icons.arrow_drop_down,
// // //                                       color: Colors.grey[600]),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Selected Approvers *",
// // //                           child: GestureDetector(
// // //                             onTap: _showApproversDialog,
// // //                             child: Container(
// // //                               padding: const EdgeInsets.symmetric(
// // //                                   horizontal: 16, vertical: 16),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.grey[100],
// // //                                 borderRadius: BorderRadius.circular(12),
// // //                                 border: Border.all(color: Colors.grey[300]!),
// // //                               ),
// // //                               child: Row(
// // //                                 children: [
// // //                                   Icon(Icons.people,
// // //                                       size: 20, color: Colors.grey[600]),
// // //                                   const SizedBox(width: 12),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       selectedApproversIds.isEmpty
// // //                                           ? "Select approvers"
// // //                                           : "${selectedApproversIds.length} approver(s) selected",
// // //                                       style: TextStyle(
// // //                                         color: selectedApproversIds.isEmpty
// // //                                             ? Colors.grey[500]
// // //                                             : Colors.black87,
// // //                                         fontSize: 14,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                   Icon(Icons.arrow_drop_down,
// // //                                       color: Colors.grey[600]),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 20),

// // //                   // Optional Fields Card
// // //                   Container(
// // //                     padding: const EdgeInsets.all(20),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white,
// // //                       borderRadius: BorderRadius.circular(16),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.black.withOpacity(0.03),
// // //                           blurRadius: 8,
// // //                           offset: const Offset(0, 2),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         // Section Header
// // //                         const Row(
// // //                           children: [
// // //                             Icon(Icons.info_outline,
// // //                                 size: 16, color: Colors.grey),
// // //                             SizedBox(width: 6),
// // //                             Text(
// // //                               "Optional Fields",
// // //                               style: TextStyle(
// // //                                 fontSize: 14,
// // //                                 fontWeight: FontWeight.w600,
// // //                                 color: Colors.black87,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         const SizedBox(height: 20),

// // //                         // Optional Form Fields
// // //                         _buildFormField(
// // //                           label: "Company Name",
// // //                           child: MyTextField(
// // //                             controller: companyNameController,
// // //                             hintText: "Tech Solutions Inc.",
// // //                             obscureText: false,
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Purpose of Visit",
// // //                           child: MyTextField(
// // //                             controller: purposeOfVisitController,
// // //                             hintText: "Meeting with IT department",
// // //                             obscureText: false,
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Host Department",
// // //                           child: MyTextField(
// // //                             controller: hostDepartmentController,
// // //                             hintText: "IT Department",
// // //                             obscureText: false,
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 16),

// // //                         _buildFormField(
// // //                           label: "Meeting Room",
// // //                           child: MyTextField(
// // //                             controller: meetingRoomController,
// // //                             hintText: "Conference Room A",
// // //                             obscureText: false,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 24),

// // //                   // Submit Button
// // //                   MyButton(
// // //                     buttonText: "Create Visitor",
// // //                     onTap: isLoading ? null : _createVisitor,
// // //                   ),

// // //                   if (isLoading)
// // //                     const Padding(
// // //                       padding: EdgeInsets.all(16),
// // //                       child: Center(child: CircularProgressIndicator()),
// // //                     ),

// // //                   const SizedBox(height: 20),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFormField({
// // //     required String label,
// // //     required Widget child,
// // //   }) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.only(left: 4, bottom: 8),
// // //           child: Text(
// // //             label,
// // //             style: TextStyle(
// // //               fontSize: 13,
// // //               fontWeight: FontWeight.w500,
// // //               color: Colors.grey[700],
// // //             ),
// // //           ),
// // //         ),
// // //         child,
// // //       ],
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import 'package:modernlogintute/components/my_button.dart';
// // // import 'package:modernlogintute/components/my_textfield.dart';
// // // import 'package:modernlogintute/services/api_services.dart';

// // // class CreateVisitorPage extends StatefulWidget {
// // //   const CreateVisitorPage({super.key});

// // //   @override
// // //   State<CreateVisitorPage> createState() => _CreateVisitorPageState();
// // // }

// // // class _CreateVisitorPageState extends State<CreateVisitorPage> {
// // //   // Controllers for text fields
// // //   final fullNameController = TextEditingController();
// // //   final emailController = TextEditingController();
// // //   final phoneNumberController = TextEditingController();
// // //   final companyNameController = TextEditingController();
// // //   final purposeOfVisitController = TextEditingController();
// // //   final hostDepartmentController = TextEditingController();
// // //   final meetingRoomController = TextEditingController();
// // //   final vehicleNumberController = TextEditingController();
// // //   final idCardNumberController = TextEditingController();

// // //   // DateTime fields
// // //   DateTime? designatedCheckIn;
// // //   DateTime? designatedCheckOut;

// // //   // Selected IDs
// // //   int? selectedSiteId;
// // //   List<int> selectedSectionIds = [];
// // //   List<int> selectedApproversIds = [];
// // //   List<int> allSelectedApproversIds = [];

// // //   // Data from API
// // //   List<dynamic> sites = [];
// // //   List<dynamic> sections = [];
// // //   List<dynamic> employees = [];
// // //   List<dynamic> locations = [];

// // //   // Loading states
// // //   bool isLoading = false;
// // //   bool isLoadingSites = true;
// // //   bool isLoadingEmployees = true;
// // //   bool isLoadingSections = false;

// // //   final _formKey = GlobalKey<FormState>();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchInitialData();
// // //   }

// // //   Future<void> _fetchInitialData() async {
// // //     await Future.wait([
// // //       _fetchSites(),
// // //       _fetchEmployees(),
// // //     ]);
// // //   }

// // //   Future<void> _fetchSites() async {
// // //     try {
// // //       final response = await ApiService.getSites();
// // //       setState(() {
// // //         sites = response;
// // //         isLoadingSites = false;
// // //       });
// // //     } catch (e) {
// // //       setState(() => isLoadingSites = false);
// // //       print('Error fetching sites: $e');
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //             content: Text('Failed to load sites: $e'),
// // //             backgroundColor: Colors.red),
// // //       );
// // //     }
// // //   }

// // //   Future<void> _fetchEmployees() async {
// // //     try {
// // //       final response = await ApiService.getEmployees();
// // //       setState(() {
// // //         employees = response;
// // //         isLoadingEmployees = false;
// // //       });
// // //     } catch (e) {
// // //       setState(() => isLoadingEmployees = false);
// // //       print('Error fetching employees: $e');
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //             content: Text('Failed to load employees: $e'),
// // //             backgroundColor: Colors.red),
// // //       );
// // //     }
// // //   }

// // //   Future<void> _fetchSectionsForSite(int siteId) async {
// // //     setState(() {
// // //       isLoadingSections = true;
// // //       selectedSectionIds = [];
// // //     });

// // //     try {
// // //       final response = await ApiService.getSectionsBySite(siteId);
// // //       setState(() {
// // //         sections = response;
// // //         isLoadingSections = false;
// // //       });
// // //     } catch (e) {
// // //       setState(() => isLoadingSections = false);
// // //       print('Error fetching sections: $e');
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //             content: Text('Failed to load sections: $e'),
// // //             backgroundColor: Colors.red),
// // //       );
// // //     }
// // //   }

// // //   Future<void> _selectCheckInDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: designatedCheckIn ?? DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime.now().add(const Duration(days: 365)),
// // //     );
// // //     if (picked != null) {
// // //       final TimeOfDay? time = await showTimePicker(
// // //         context: context,
// // //         initialTime:
// // //             TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
// // //       );
// // //       if (time != null) {
// // //         setState(() {
// // //           designatedCheckIn = DateTime(
// // //             picked.year,
// // //             picked.month,
// // //             picked.day,
// // //             time.hour,
// // //             time.minute,
// // //           );
// // //         });
// // //       }
// // //     }
// // //   }

// // //   Future<void> _selectCheckOutDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: designatedCheckOut ?? DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime.now().add(const Duration(days: 365)),
// // //     );
// // //     if (picked != null) {
// // //       final TimeOfDay? time = await showTimePicker(
// // //         context: context,
// // //         initialTime:
// // //             TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
// // //       );
// // //       if (time != null) {
// // //         setState(() {
// // //           designatedCheckOut = DateTime(
// // //             picked.year,
// // //             picked.month,
// // //             picked.day,
// // //             time.hour,
// // //             time.minute,
// // //           );
// // //         });
// // //       }
// // //     }
// // //   }

// // //   String _formatDateTime(DateTime? dateTime) {
// // //     if (dateTime == null) return "Not selected";
// // //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
// // //   }

// // //   String _formatForAPI(DateTime? dateTime) {
// // //     if (dateTime == null) return "";
// // //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00Z";
// // //   }

// // //   Future<void> _createVisitor() async {
// // //     if (!_formKey.currentState!.validate()) return;

// // //     if (selectedSiteId == null) {
// // //       _showError("Please select a site");
// // //       return;
// // //     }

// // //     if (selectedSectionIds.isEmpty) {
// // //       _showError("Please select at least one section");
// // //       return;
// // //     }

// // //     if (selectedApproversIds.length != 2) {
// // //       _showError("Exactly 2 approvers are required");
// // //       return;
// // //     }

// // //     if (designatedCheckIn == null) {
// // //       _showError("Please select check-in time");
// // //       return;
// // //     }

// // //     if (designatedCheckOut == null) {
// // //       _showError("Please select check-out time");
// // //       return;
// // //     }

// // //     setState(() => isLoading = true);

// // //     try {
// // //       final Map<String, dynamic> requestBody = {
// // //         "site_id": selectedSiteId,
// // //         "full_name": fullNameController.text.trim(),
// // //         "email": emailController.text.trim(),
// // //         "phone_number": phoneNumberController.text.trim(),
// // //         "requested_section_ids": selectedSectionIds,
// // //         "selected_approvers_ids": selectedApproversIds,
// // //         "designated_check_in": _formatForAPI(designatedCheckIn),
// // //         "designated_check_out": _formatForAPI(designatedCheckOut),
// // //       };

// // //       // Add optional fields
// // //       if (companyNameController.text.trim().isNotEmpty) {
// // //         requestBody["company_name"] = companyNameController.text.trim();
// // //       }
// // //       if (purposeOfVisitController.text.trim().isNotEmpty) {
// // //         requestBody["purpose_of_visit"] = purposeOfVisitController.text.trim();
// // //       }
// // //       if (hostDepartmentController.text.trim().isNotEmpty) {
// // //         requestBody["host_department"] = hostDepartmentController.text.trim();
// // //       }
// // //       if (meetingRoomController.text.trim().isNotEmpty) {
// // //         requestBody["meeting_room"] = meetingRoomController.text.trim();
// // //       }
// // //       if (vehicleNumberController.text.trim().isNotEmpty) {
// // //         requestBody["vehicle_number"] = vehicleNumberController.text.trim();
// // //       }
// // //       if (idCardNumberController.text.trim().isNotEmpty) {
// // //         requestBody["id_card_number"] = idCardNumberController.text.trim();
// // //       }

// // //       print('Request body: ${jsonEncode(requestBody)}');

// // //       final response = await ApiService.createVisitor(requestBody);

// // //       if (response['visitor'] != null) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text("Visitor created successfully!"),
// // //             backgroundColor: Colors.green,
// // //           ),
// // //         );
// // //         Navigator.pop(context);
// // //       } else {
// // //         _showError(response.toString());
// // //       }
// // //     } catch (e) {
// // //       _showError("Error: $e");
// // //     }

// // //     setState(() => isLoading = false);
// // //   }

// // //   void _showError(String message) {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text(message), backgroundColor: Colors.red),
// // //     );
// // //   }

// // //   void _showSiteSelector() {
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setStateDialog) {
// // //             return AlertDialog(
// // //               title: const Text("Select Site"),
// // //               content: SizedBox(
// // //                 width: double.maxFinite,
// // //                 height: 300,
// // //                 child: isLoadingSites
// // //                     ? const Center(child: CircularProgressIndicator())
// // //                     : ListView.builder(
// // //                         itemCount: sites.length,
// // //                         itemBuilder: (context, index) {
// // //                           final site = sites[index];
// // //                           final isSelected = selectedSiteId == site['id'];
// // //                           return RadioListTile<int>(
// // //                             title: Text(site['name'] ?? 'Unknown'),
// // //                             subtitle: Text(site['address'] ?? 'No address'),
// // //                             value: site['id'],
// // //                             groupValue: selectedSiteId,
// // //                             onChanged: (value) {
// // //                               setStateDialog(() {
// // //                                 selectedSiteId = value;
// // //                               });
// // //                             },
// // //                           );
// // //                         },
// // //                       ),
// // //               ),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context),
// // //                   child: const Text("Cancel"),
// // //                 ),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     if (selectedSiteId != null) {
// // //                       setState(() {
// // //                         _fetchSectionsForSite(selectedSiteId!);
// // //                       });
// // //                       Navigator.pop(context);
// // //                     }
// // //                   },
// // //                   child: const Text("Confirm"),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showSectionsSelector() {
// // //     List<int> tempSelected = List.from(selectedSectionIds);

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setStateDialog) {
// // //             return AlertDialog(
// // //               title: const Text("Select Sections"),
// // //               content: SizedBox(
// // //                 width: double.maxFinite,
// // //                 height: 400,
// // //                 child: isLoadingSections
// // //                     ? const Center(child: CircularProgressIndicator())
// // //                     : sections.isEmpty
// // //                         ? const Center(
// // //                             child: Text("No sections available for this site"))
// // //                         : ListView.builder(
// // //                             itemCount: sections.length,
// // //                             itemBuilder: (context, index) {
// // //                               final section = sections[index];
// // //                               final isSelected =
// // //                                   tempSelected.contains(section['id']);
// // //                               return CheckboxListTile(
// // //                                 title: Text(section['name'] ?? 'Unknown'),
// // //                                 subtitle: Column(
// // //                                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                                   children: [
// // //                                     Text(section['code'] ?? ''),
// // //                                     if (section['requires_escort'] == true)
// // //                                       const Text(
// // //                                         'Requires Escort',
// // //                                         style: TextStyle(
// // //                                             color: Colors.orange, fontSize: 10),
// // //                                       ),
// // //                                   ],
// // //                                 ),
// // //                                 value: isSelected,
// // //                                 onChanged: (selected) {
// // //                                   setStateDialog(() {
// // //                                     if (selected == true) {
// // //                                       tempSelected.add(section['id']);
// // //                                     } else {
// // //                                       tempSelected.remove(section['id']);
// // //                                     }
// // //                                   });
// // //                                 },
// // //                               );
// // //                             },
// // //                           ),
// // //               ),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context),
// // //                   child: const Text("Cancel"),
// // //                 ),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       selectedSectionIds = tempSelected;
// // //                     });
// // //                     Navigator.pop(context);
// // //                   },
// // //                   child: const Text("Confirm"),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showApproversDialog() {
// // //     List<int> tempSelected = List.from(selectedApproversIds);

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setStateDialog) {
// // //             // Filter out already selected approvers to prevent duplicates
// // //             final availableEmployees = employees
// // //                 .where((emp) =>
// // //                     tempSelected.length < 2 || tempSelected.contains(emp['id']))
// // //                 .toList();

// // //             return AlertDialog(
// // //               title: const Text("Select Approvers (Exactly 2)"),
// // //               content: SizedBox(
// // //                 width: double.maxFinite,
// // //                 height: 400,
// // //                 child: isLoadingEmployees
// // //                     ? const Center(child: CircularProgressIndicator())
// // //                     : Column(
// // //                         children: [
// // //                           if (tempSelected.length == 2)
// // //                             Container(
// // //                               padding: const EdgeInsets.all(8),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.green.withOpacity(0.1),
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               child: const Text(
// // //                                 "2 approvers selected. Deselect one to change.",
// // //                                 style: TextStyle(
// // //                                     color: Colors.green, fontSize: 12),
// // //                               ),
// // //                             ),
// // //                           const SizedBox(height: 8),
// // //                           Expanded(
// // //                             child: ListView.builder(
// // //                               itemCount: availableEmployees.length,
// // //                               itemBuilder: (context, index) {
// // //                                 final employee = availableEmployees[index];
// // //                                 final isSelected =
// // //                                     tempSelected.contains(employee['id']);
// // //                                 final isDisabled =
// // //                                     !isSelected && tempSelected.length >= 2;

// // //                                 return CheckboxListTile(
// // //                                   title:
// // //                                       Text(employee['full_name'] ?? 'Unknown'),
// // //                                   subtitle: Text(
// // //                                     '${employee['department'] ?? ''} • ${employee['designation'] ?? ''}',
// // //                                   ),
// // //                                   value: isSelected,
// // //                                   onChanged: isDisabled
// // //                                       ? null
// // //                                       : (selected) {
// // //                                           setStateDialog(() {
// // //                                             if (selected == true) {
// // //                                               if (tempSelected.length < 2) {
// // //                                                 tempSelected
// // //                                                     .add(employee['id']);
// // //                                               }
// // //                                             } else {
// // //                                               tempSelected
// // //                                                   .remove(employee['id']);
// // //                                             }
// // //                                           });
// // //                                         },
// // //                                 );
// // //                               },
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //               ),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context),
// // //                   child: const Text("Cancel"),
// // //                 ),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     if (tempSelected.length == 2) {
// // //                       setState(() {
// // //                         selectedApproversIds = tempSelected;
// // //                       });
// // //                       Navigator.pop(context);
// // //                     } else {
// // //                       ScaffoldMessenger.of(context).showSnackBar(
// // //                         const SnackBar(
// // //                           content: Text("Please select exactly 2 approvers"),
// // //                           backgroundColor: Colors.orange,
// // //                         ),
// // //                       );
// // //                     }
// // //                   },
// // //                   child: const Text("Confirm"),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[100],
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.black,
// // //         title: const Text(
// // //           "Create Visitor",
// // //           style: TextStyle(color: Colors.white),
// // //         ),
// // //         centerTitle: true,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: Form(
// // //               key: _formKey,
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   // Header Card
// // //                   _buildHeaderCard(),
// // //                   const SizedBox(height: 20),

// // //                   // Required Fields Card
// // //                   _buildRequiredFieldsCard(),
// // //                   const SizedBox(height: 20),

// // //                   // Optional Fields Card
// // //                   _buildOptionalFieldsCard(),
// // //                   const SizedBox(height: 24),

// // //                   // Submit Button
// // //                   MyButton(
// // //                     buttonText: "Create Visitor",
// // //                     onTap: isLoading ? null : _createVisitor,
// // //                   ),

// // //                   if (isLoading)
// // //                     const Padding(
// // //                       padding: EdgeInsets.all(16),
// // //                       child: Center(child: CircularProgressIndicator()),
// // //                     ),

// // //                   const SizedBox(height: 20),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildHeaderCard() {
// // //     return Container(
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.03),
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 2),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.all(12),
// // //             decoration: BoxDecoration(
// // //               color: Colors.blue.withOpacity(0.1),
// // //               borderRadius: BorderRadius.circular(12),
// // //             ),
// // //             child: const Icon(Icons.person_add_alt_1,
// // //                 color: Colors.blue, size: 28),
// // //           ),
// // //           const SizedBox(width: 16),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text(
// // //                   "Visitor Registration",
// // //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //                 ),
// // //                 const SizedBox(height: 4),
// // //                 Text(
// // //                   "Fill in the details to register a new visitor",
// // //                   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildRequiredFieldsCard() {
// // //     return Container(
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.03),
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 2),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           const Row(
// // //             children: [
// // //               Icon(Icons.info, size: 16, color: Colors.red),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Required Fields",
// // //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 20),

// // //           // Site Selection
// // //           _buildFormField(
// // //             label: "Site *",
// // //             child: GestureDetector(
// // //               onTap: _showSiteSelector,
// // //               child: Container(
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[100],
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   border: Border.all(color: Colors.grey[300]!),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     Icon(Icons.business, size: 20, color: Colors.grey[600]),
// // //                     const SizedBox(width: 12),
// // //                     Expanded(
// // //                       child: Text(
// // //                         selectedSiteId != null
// // //                             ? (sites.firstWhere(
// // //                                     (s) => s['id'] == selectedSiteId)['name'] ??
// // //                                 'Selected')
// // //                             : "Select a site",
// // //                         style: TextStyle(
// // //                           color: selectedSiteId == null
// // //                               ? Colors.grey[500]
// // //                               : Colors.black87,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Sections Selection
// // //           _buildFormField(
// // //             label: "Sections *",
// // //             child: GestureDetector(
// // //               onTap: selectedSiteId != null ? _showSectionsSelector : null,
// // //               child: Container(
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// // //                 decoration: BoxDecoration(
// // //                   color: selectedSiteId == null
// // //                       ? Colors.grey[50]
// // //                       : Colors.grey[100],
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   border: Border.all(color: Colors.grey[300]!),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     Icon(Icons.location_city,
// // //                         size: 20, color: Colors.grey[600]),
// // //                     const SizedBox(width: 12),
// // //                     Expanded(
// // //                       child: Text(
// // //                         selectedSectionIds.isEmpty
// // //                             ? "Select sections"
// // //                             : "${selectedSectionIds.length} section(s) selected",
// // //                         style: TextStyle(
// // //                           color: selectedSectionIds.isEmpty
// // //                               ? Colors.grey[500]
// // //                               : Colors.black87,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Full Name
// // //           _buildFormField(
// // //             label: "Full Name *",
// // //             child: MyTextFieldValidator(
// // //               controller: fullNameController,
// // //               hintText: "John Visitor",
// // //               obscureText: false,
// // //               validator: (value) {
// // //                 if (value == null || value.trim().isEmpty)
// // //                   return "Full name is required";
// // //                 return null;
// // //               },
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Email
// // //           _buildFormField(
// // //             label: "Email *",
// // //             child: MyTextFieldValidator(
// // //               controller: emailController,
// // //               hintText: "john@example.com",
// // //               obscureText: false,
// // //               validator: (value) {
// // //                 if (value == null || value.trim().isEmpty)
// // //                   return "Email is required";
// // //                 if (!value.contains('@')) return "Enter a valid email";
// // //                 return null;
// // //               },
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Phone Number
// // //           _buildFormField(
// // //             label: "Phone Number *",
// // //             child: MyTextFieldValidator(
// // //               controller: phoneNumberController,
// // //               hintText: "+1234567890",
// // //               obscureText: false,
// // //               validator: (value) {
// // //                 if (value == null || value.trim().isEmpty)
// // //                   return "Phone number is required";
// // //                 return null;
// // //               },
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Designated Check-in
// // //           _buildFormField(
// // //             label: "Designated Check-in *",
// // //             child: GestureDetector(
// // //               onTap: () => _selectCheckInDate(context),
// // //               child: Container(
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[100],
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   border: Border.all(color: Colors.grey[300]!),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     Icon(Icons.calendar_today,
// // //                         size: 20, color: Colors.grey[600]),
// // //                     const SizedBox(width: 12),
// // //                     Expanded(
// // //                       child: Text(
// // //                         _formatDateTime(designatedCheckIn),
// // //                         style: TextStyle(
// // //                           color: designatedCheckIn == null
// // //                               ? Colors.grey[500]
// // //                               : Colors.black87,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Designated Check-out
// // //           _buildFormField(
// // //             label: "Designated Check-out *",
// // //             child: GestureDetector(
// // //               onTap: () => _selectCheckOutDate(context),
// // //               child: Container(
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[100],
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   border: Border.all(color: Colors.grey[300]!),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     Icon(Icons.calendar_today,
// // //                         size: 20, color: Colors.grey[600]),
// // //                     const SizedBox(width: 12),
// // //                     Expanded(
// // //                       child: Text(
// // //                         _formatDateTime(designatedCheckOut),
// // //                         style: TextStyle(
// // //                           color: designatedCheckOut == null
// // //                               ? Colors.grey[500]
// // //                               : Colors.black87,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // Approvers Selection
// // //           _buildFormField(
// // //             label: "Approvers * (Exactly 2)",
// // //             child: GestureDetector(
// // //               onTap: _showApproversDialog,
// // //               child: Container(
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[100],
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   border: Border.all(color: Colors.grey[300]!),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     Icon(Icons.verified_user,
// // //                         size: 20, color: Colors.grey[600]),
// // //                     const SizedBox(width: 12),
// // //                     Expanded(
// // //                       child: Text(
// // //                         selectedApproversIds.isEmpty
// // //                             ? "Select 2 approvers"
// // //                             : "${selectedApproversIds.length}/2 approver(s) selected",
// // //                         style: TextStyle(
// // //                           color: selectedApproversIds.isEmpty
// // //                               ? Colors.grey[500]
// // //                               : Colors.black87,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildOptionalFieldsCard() {
// // //     return Container(
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.03),
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 2),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           const Row(
// // //             children: [
// // //               Icon(Icons.info_outline, size: 16, color: Colors.grey),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Optional Fields",
// // //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 20),
// // //           _buildFormField(
// // //             label: "Company Name",
// // //             child: MyTextField(
// // //               controller: companyNameController,
// // //               hintText: "Tech Solutions Inc.",
// // //               obscureText: false,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           _buildFormField(
// // //             label: "Purpose of Visit",
// // //             child: MyTextField(
// // //               controller: purposeOfVisitController,
// // //               hintText: "Meeting with IT department",
// // //               obscureText: false,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           _buildFormField(
// // //             label: "Host Department",
// // //             child: MyTextField(
// // //               controller: hostDepartmentController,
// // //               hintText: "IT Department",
// // //               obscureText: false,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           _buildFormField(
// // //             label: "Meeting Room",
// // //             child: MyTextField(
// // //               controller: meetingRoomController,
// // //               hintText: "Conference Room A",
// // //               obscureText: false,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           _buildFormField(
// // //             label: "Vehicle Number",
// // //             child: MyTextField(
// // //               controller: vehicleNumberController,
// // //               hintText: "KA01AB1234",
// // //               obscureText: false,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           _buildFormField(
// // //             label: "ID Card Number",
// // //             child: MyTextField(
// // //               controller: idCardNumberController,
// // //               hintText: "ID123456",
// // //               obscureText: false,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFormField({
// // //     required String label,
// // //     required Widget child,
// // //   }) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.only(left: 4, bottom: 8),
// // //           child: Text(
// // //             label,
// // //             style: TextStyle(
// // //               fontSize: 13,
// // //               fontWeight: FontWeight.w500,
// // //               color: Colors.grey[700],
// // //             ),
// // //           ),
// // //         ),
// // //         child,
// // //       ],
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:modernlogintute/components/my_button.dart';
// // import 'package:modernlogintute/components/my_textfield.dart';
// // import 'package:modernlogintute/services/api_services.dart';

// // class CreateVisitorPage extends StatefulWidget {
// //   const CreateVisitorPage({super.key});

// //   @override
// //   State<CreateVisitorPage> createState() => _CreateVisitorPageState();
// // }

// // class _CreateVisitorPageState extends State<CreateVisitorPage> {
// //   // Controllers for text fields
// //   final fullNameController = TextEditingController();
// //   final emailController = TextEditingController();
// //   final phoneNumberController = TextEditingController();
// //   final companyNameController = TextEditingController();
// //   final purposeOfVisitController = TextEditingController();
// //   final hostDepartmentController = TextEditingController();
// //   final meetingRoomController = TextEditingController();
// //   final vehicleNumberController = TextEditingController();
// //   final idCardNumberController = TextEditingController();

// //   // DateTime fields
// //   DateTime? designatedCheckIn;
// //   DateTime? designatedCheckOut;

// //   // Selected IDs
// //   int? selectedSiteId;
// //   List<int> selectedSectionIds = [];
// //   List<int> selectedApproversIds = [];

// //   // Data from API
// //   List<dynamic> sites = [];
// //   List<dynamic> sections = [];
// //   List<dynamic> employees = [];

// //   // Dropdown visibility states
// //   bool isSiteDropdownVisible = false;
// //   bool isSectionDropdownVisible = false;
// //   bool isApproverDropdownVisible = false;

// //   // Search filters
// //   String siteSearchQuery = '';
// //   String sectionSearchQuery = '';
// //   String approverSearchQuery = '';

// //   // Focus nodes for handling dropdown dismissal
// //   final FocusNode siteFocusNode = FocusNode();
// //   final FocusNode sectionFocusNode = FocusNode();

// //   // Loading states
// //   bool isLoading = false;
// //   bool isLoadingSites = true;
// //   bool isLoadingEmployees = true;
// //   bool isLoadingSections = false;

// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchInitialData();

// //     // Add focus listeners
// //     siteFocusNode.addListener(() {
// //       if (!siteFocusNode.hasFocus) {
// //         setState(() => isSiteDropdownVisible = false);
// //       }
// //     });
// //     sectionFocusNode.addListener(() {
// //       if (!sectionFocusNode.hasFocus) {
// //         setState(() => isSectionDropdownVisible = false);
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     siteFocusNode.dispose();
// //     sectionFocusNode.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _fetchInitialData() async {
// //     await Future.wait([
// //       _fetchSites(),
// //       _fetchEmployees(),
// //     ]);
// //   }

// //   Future<void> _fetchSites() async {
// //     try {
// //       final response = await ApiService.getSites();
// //       setState(() {
// //         sites = response;
// //         isLoadingSites = false;
// //       });
// //     } catch (e) {
// //       setState(() => isLoadingSites = false);
// //       _showError('Failed to load sites');
// //     }
// //   }

// //   Future<void> _fetchEmployees() async {
// //     try {
// //       final response = await ApiService.getEmployees();
// //       setState(() {
// //         employees = response;
// //         isLoadingEmployees = false;
// //       });
// //     } catch (e) {
// //       setState(() => isLoadingEmployees = false);
// //       _showError('Failed to load employees');
// //     }
// //   }

// //   Future<void> _fetchSectionsForSite(int siteId) async {
// //     setState(() {
// //       isLoadingSections = true;
// //       selectedSectionIds = [];
// //       sectionSearchQuery = '';
// //       isSectionDropdownVisible = false;
// //     });

// //     try {
// //       final response = await ApiService.getSectionsBySite(siteId);
// //       setState(() {
// //         sections = response;
// //         isLoadingSections = false;
// //       });
// //     } catch (e) {
// //       setState(() => isLoadingSections = false);
// //       _showError('Failed to load sections');
// //     }
// //   }

// //   Future<void> _selectCheckInDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: designatedCheckIn ?? DateTime.now(),
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime.now().add(const Duration(days: 365)),
// //       builder: (context, child) {
// //         return Theme(
// //           data: ThemeData.light().copyWith(
// //             primaryColor: Colors.black,
// //             colorScheme: const ColorScheme.light(primary: Colors.black),
// //           ),
// //           child: child!,
// //         );
// //       },
// //     );
// //     if (picked != null) {
// //       final TimeOfDay? time = await showTimePicker(
// //         context: context,
// //         initialTime:
// //             TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
// //         builder: (context, child) {
// //           return Theme(
// //             data: ThemeData.light().copyWith(
// //               primaryColor: Colors.black,
// //               colorScheme: const ColorScheme.light(primary: Colors.black),
// //             ),
// //             child: child!,
// //           );
// //         },
// //       );
// //       if (time != null) {
// //         setState(() {
// //           designatedCheckIn = DateTime(
// //             picked.year,
// //             picked.month,
// //             picked.day,
// //             time.hour,
// //             time.minute,
// //           );
// //         });
// //       }
// //     }
// //   }

// //   Future<void> _selectCheckOutDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: designatedCheckOut ?? DateTime.now(),
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime.now().add(const Duration(days: 365)),
// //       builder: (context, child) {
// //         return Theme(
// //           data: ThemeData.light().copyWith(
// //             primaryColor: Colors.black,
// //             colorScheme: const ColorScheme.light(primary: Colors.black),
// //           ),
// //           child: child!,
// //         );
// //       },
// //     );
// //     if (picked != null) {
// //       final TimeOfDay? time = await showTimePicker(
// //         context: context,
// //         initialTime:
// //             TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
// //         builder: (context, child) {
// //           return Theme(
// //             data: ThemeData.light().copyWith(
// //               primaryColor: Colors.black,
// //               colorScheme: const ColorScheme.light(primary: Colors.black),
// //             ),
// //             child: child!,
// //           );
// //         },
// //       );
// //       if (time != null) {
// //         setState(() {
// //           designatedCheckOut = DateTime(
// //             picked.year,
// //             picked.month,
// //             picked.day,
// //             time.hour,
// //             time.minute,
// //           );
// //         });
// //       }
// //     }
// //   }

// //   String _formatDateTime(DateTime? dateTime) {
// //     if (dateTime == null) return "Not selected";
// //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
// //   }

// //   String _formatForAPI(DateTime? dateTime) {
// //     if (dateTime == null) return "";
// //     return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00Z";
// //   }

// //   Future<void> _createVisitor() async {
// //     if (!_formKey.currentState!.validate()) return;

// //     if (selectedSiteId == null) {
// //       _showError("Please select a site");
// //       return;
// //     }

// //     if (selectedSectionIds.isEmpty) {
// //       _showError("Please select at least one section");
// //       return;
// //     }

// //     if (selectedApproversIds.length != 2) {
// //       _showError("Exactly 2 approvers are required");
// //       return;
// //     }

// //     if (designatedCheckIn == null) {
// //       _showError("Please select check-in time");
// //       return;
// //     }

// //     if (designatedCheckOut == null) {
// //       _showError("Please select check-out time");
// //       return;
// //     }

// //     setState(() => isLoading = true);

// //     try {
// //       final Map<String, dynamic> requestBody = {
// //         "site_id": selectedSiteId,
// //         "full_name": fullNameController.text.trim(),
// //         "email": emailController.text.trim(),
// //         "phone_number": phoneNumberController.text.trim(),
// //         "requested_section_ids": selectedSectionIds,
// //         "selected_approvers_ids": selectedApproversIds,
// //         "designated_check_in": _formatForAPI(designatedCheckIn),
// //         "designated_check_out": _formatForAPI(designatedCheckOut),
// //       };

// //       if (companyNameController.text.trim().isNotEmpty) {
// //         requestBody["company_name"] = companyNameController.text.trim();
// //       }
// //       if (purposeOfVisitController.text.trim().isNotEmpty) {
// //         requestBody["purpose_of_visit"] = purposeOfVisitController.text.trim();
// //       }
// //       if (hostDepartmentController.text.trim().isNotEmpty) {
// //         requestBody["host_department"] = hostDepartmentController.text.trim();
// //       }
// //       if (meetingRoomController.text.trim().isNotEmpty) {
// //         requestBody["meeting_room"] = meetingRoomController.text.trim();
// //       }
// //       if (vehicleNumberController.text.trim().isNotEmpty) {
// //         requestBody["vehicle_number"] = vehicleNumberController.text.trim();
// //       }
// //       if (idCardNumberController.text.trim().isNotEmpty) {
// //         requestBody["id_card_number"] = idCardNumberController.text.trim();
// //       }

// //       final response = await ApiService.createVisitor(requestBody);

// //       if (response['visitor'] != null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text("Visitor created successfully!"),
// //             backgroundColor: Colors.green,
// //             duration: Duration(seconds: 2),
// //           ),
// //         );
// //         Navigator.pop(context);
// //       } else {
// //         _showError(response.toString());
// //       }
// //     } catch (e) {
// //       _showError("Error: $e");
// //     }

// //     setState(() => isLoading = false);
// //   }

// //   void _showError(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message), backgroundColor: Colors.red),
// //     );
// //   }

// //   // Get selected site name
// //   String get _selectedSiteName {
// //     if (selectedSiteId == null) return "Select a site";
// //     final site =
// //         sites.firstWhere((s) => s['id'] == selectedSiteId, orElse: () => null);
// //     return site != null ? site['name'] : "Select a site";
// //   }

// //   // Get selected sections preview
// //   String get _selectedSectionsPreview {
// //     if (selectedSectionIds.isEmpty) return "Select sections";
// //     if (selectedSectionIds.length == 1) {
// //       final section = sections.firstWhere(
// //           (s) => s['id'] == selectedSectionIds.first,
// //           orElse: () => null);
// //       return section != null ? section['name'] : "1 section selected";
// //     }
// //     return "${selectedSectionIds.length} sections selected";
// //   }

// //   // Get selected approvers preview
// //   String get _selectedApproversPreview {
// //     if (selectedApproversIds.isEmpty) return "Select 2 approvers";
// //     final names = selectedApproversIds.map((id) {
// //       final emp =
// //           employees.firstWhere((e) => e['id'] == id, orElse: () => null);
// //       return emp != null
// //           ? emp['full_name']?.split(' ').first ?? 'Unknown'
// //           : 'Unknown';
// //     }).join(' & ');
// //     return "$names • ${selectedApproversIds.length}/2";
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[100],
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: const Text(
// //           "Create Visitor",
// //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(24.0),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   _buildHeaderCard(),
// //                   const SizedBox(height: 24),
// //                   _buildRequiredFieldsCard(),
// //                   const SizedBox(height: 24),
// //                   _buildOptionalFieldsCard(),
// //                   const SizedBox(height: 32),
// //                   MyButton(
// //                     buttonText: "Create Visitor",
// //                     onTap: isLoading ? null : _createVisitor,
// //                   ),
// //                   if (isLoading)
// //                     const Padding(
// //                       padding: EdgeInsets.all(16),
// //                       child: Center(child: CircularProgressIndicator()),
// //                     ),
// //                   const SizedBox(height: 20),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeaderCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(24),
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
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               color: Colors.blue.withOpacity(0.1),
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: const Icon(Icons.person_add_alt_1,
// //                 color: Colors.blue, size: 28),
// //           ),
// //           const SizedBox(width: 16),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   "Visitor Registration",
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(
// //                   "Fill in the details to register a new visitor",
// //                   style: TextStyle(fontSize: 13, color: Colors.grey[600]),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // Widget _buildRequiredFieldsCard() {
// //   //   return Container(
// //   //     padding: const EdgeInsets.all(24),
// //   //     decoration: BoxDecoration(
// //   //       color: Colors.white,
// //   //       borderRadius: BorderRadius.circular(16),
// //   //       boxShadow: [
// //   //         BoxShadow(
// //   //           color: Colors.black.withOpacity(0.03),
// //   //           blurRadius: 8,
// //   //           offset: const Offset(0, 2),
// //   //         ),
// //   //       ],
// //   //     ),
// //   //     child: Column(
// //   //       crossAxisAlignment: CrossAxisAlignment.start,
// //   //       children: [
// //   //         const Row(
// //   //           children: [
// //   //             Icon(Icons.info, size: 16, color: Colors.red),
// //   //             SizedBox(width: 8),
// //   //             Text(
// //   //               "Required Fields",
// //   //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //   //             ),
// //   //           ],
// //   //         ),
// //   //         const SizedBox(height: 24),

// //   //         // Site Selection - Inline Dropdown
// //   //         _buildFormField(
// //   //           label: "Site *",
// //   //           child: Focus(
// //   //             focusNode: siteFocusNode,
// //   //             child: Column(
// //   //               crossAxisAlignment: CrossAxisAlignment.start,
// //   //               children: [
// //   //                 GestureDetector(
// //   //                   onTap: () {
// //   //                     setState(() {
// //   //                       isSiteDropdownVisible = !isSiteDropdownVisible;
// //   //                       if (isSiteDropdownVisible) {
// //   //                         isSectionDropdownVisible = false;
// //   //                         isApproverDropdownVisible = false;
// //   //                       }
// //   //                     });
// //   //                   },
// //   //                   child: Container(
// //   //                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //                     decoration: BoxDecoration(
// //   //                       color: Colors.grey[50],
// //   //                       borderRadius: BorderRadius.circular(12),
// //   //                       border: Border.all(color: Colors.grey[300]!),
// //   //                     ),
// //   //                     child: Row(
// //   //                       children: [
// //   //                         Icon(Icons.business, size: 20, color: Colors.grey[600]),
// //   //                         const SizedBox(width: 12),
// //   //                         Expanded(
// //   //                           child: Text(
// //   //                             _selectedSiteName,
// //   //                             style: TextStyle(
// //   //                               color: selectedSiteId == null ? Colors.grey[500] : Colors.black87,
// //   //                               fontSize: 14,
// //   //                             ),
// //   //                           ),
// //   //                         ),
// //   //                         Icon(
// //   //                               isSiteDropdownVisible ? Icons.expand_less : Icons.expand_more,
// //   //                           size: 20,
// //   //                           color: Colors.grey[600],
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //                 ),
// //   //                 if (isSiteDropdownVisible && !isLoadingSites)
// //   //                   Container(
// //   //                     margin: const EdgeInsets.only(top: 8),
// //   //                     decoration: BoxDecoration(
// //   //                       color: Colors.white,
// //   //                       borderRadius: BorderRadius.circular(12),
// //   //                       border: Border.all(color: Colors.grey[200]!),
// //   //                       boxShadow: [
// //   //                         BoxShadow(
// //   //                           color: Colors.black.withOpacity(0.05),
// //   //                           blurRadius: 8,
// //   //                           offset: const Offset(0, 2),
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                     child: Column(
// //   //                       children: [
// //   //                         Padding(
// //   //                           padding: const EdgeInsets.all(12),
// //   //                           child: TextField(
// //   //                             autofocus: true,
// //   //                             decoration: InputDecoration(
// //   //                               hintText: "Search sites...",
// //   //                               prefixIcon: const Icon(Icons.search, size: 18),
// //   //                               border: OutlineInputBorder(
// //   //                                 borderRadius: BorderRadius.circular(8),
// //   //                                 borderSide: BorderSide(color: Colors.grey[300]!),
// //   //                               ),
// //   //                               contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //   //                               isDense: true,
// //   //                             ),
// //   //                             onChanged: (query) {
// //   //                               setState(() => siteSearchQuery = query);
// //   //                             },
// //   //                           ),
// //   //                         ),
// //   //                         ConstrainedBox(
// //   //                           constraints: BoxConstraints(
// //   //                             maxHeight: 250,
// //   //                             minHeight: 100,
// //   //                           ),
// //   //                           child: ListView(
// //   //                             shrinkWrap: true,
// //   //                             children: [
// //   //                               if (sites.where((site) {
// //   //                                     final name = site['name']?.toLowerCase() ?? '';
// //   //                                     final address = site['address']?.toLowerCase() ?? '';
// //   //                                     final query = siteSearchQuery.toLowerCase();
// //   //                                     return name.contains(query) || address.contains(query);
// //   //                                   }).isEmpty)
// //   //                                 const Padding(
// //   //                                   padding: EdgeInsets.all(32),
// //   //                                   child: Center(
// //   //                                     child: Text("No sites found", style: TextStyle(color: Colors.grey)),
// //   //                                   ),
// //   //                                 )
// //   //                               else
// //   //                                 ...sites.where((site) {
// //   //                                   final name = site['name']?.toLowerCase() ?? '';
// //   //                                   final address = site['address']?.toLowerCase() ?? '';
// //   //                                   final query = siteSearchQuery.toLowerCase();
// //   //                                   return name.contains(query) || address.contains(query);
// //   //                                 }).map((site) => _buildSiteOption(site)),
// //   //                             ],
// //   //                           ),
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //               ],
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Sections Selection - Inline Dropdown (disabled until site selected)
// //   //         _buildFormField(
// //   //           label: "Sections *",
// //   //           child: Column(
// //   //             crossAxisAlignment: CrossAxisAlignment.start,
// //   //             children: [
// //   //               GestureDetector(
// //   //                 onTap: selectedSiteId != null
// //   //                     ? () {
// //   //                         setState(() {
// //   //                           isSectionDropdownVisible = !isSectionDropdownVisible;
// //   //                           if (isSectionDropdownVisible) {
// //   //                             isSiteDropdownVisible = false;
// //   //                             isApproverDropdownVisible = false;
// //   //                           }
// //   //                         });
// //   //                       }
// //   //                     : null,
// //   //                 child: Container(
// //   //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //                   decoration: BoxDecoration(
// //   //                     color: selectedSiteId == null ? Colors.grey[100] : Colors.grey[50],
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(
// //   //                       color: selectedSiteId == null ? Colors.grey[200]! : Colors.grey[300]!,
// //   //                     ),
// //   //                   ),
// //   //                   child: Row(
// //   //                     children: [
// //   //                       Icon(Icons.location_city, size: 20, color: selectedSiteId == null ? Colors.grey[400] : Colors.grey[600]),
// //   //                       const SizedBox(width: 12),
// //   //                       Expanded(
// //   //                         child: Text(
// //   //                           _selectedSectionsPreview,
// //   //                           style: TextStyle(
// //   //                             color: selectedSectionIds.isEmpty ? Colors.grey[500] : Colors.black87,
// //   //                             fontSize: 14,
// //   //                           ),
// //   //                         ),
// //   //                       ),
// //   //                       if (selectedSiteId != null)
// //   //                         Icon(
// //   //                           isSectionDropdownVisible ? Icons.expand_less : Icons.expand_more,
// //   //                           size: 20,
// //   //                           color: Colors.grey[600],
// //   //                         ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //               ),
// //   //               if (selectedSiteId == null)
// //   //                 Padding(
// //   //                   padding: const EdgeInsets.only(top: 8),
// //   //                   child: Row(
// //   //                     children: [
// //   //                       Icon(Icons.info_outline, size: 12, color: Colors.orange),
// //   //                       const SizedBox(width: 4),
// //   //                       Text(
// //   //                         "Please select a site first",
// //   //                         style: TextStyle(fontSize: 11, color: Colors.orange[600]),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //               if (isSectionDropdownVisible && selectedSiteId != null && !isLoadingSections)
// //   //                 Container(
// //   //                   margin: const EdgeInsets.only(top: 8),
// //   //                   decoration: BoxDecoration(
// //   //                     color: Colors.white,
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(color: Colors.grey[200]!),
// //   //                     boxShadow: [
// //   //                       BoxShadow(
// //   //                         color: Colors.black.withOpacity(0.05),
// //   //                         blurRadius: 8,
// //   //                         offset: const Offset(0, 2),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                   child: Column(
// //   //                     children: [
// //   //                       Padding(
// //   //                         padding: const EdgeInsets.all(12),
// //   //                         child: TextField(
// //   //                           decoration: InputDecoration(
// //   //                             hintText: "Search sections...",
// //   //                             prefixIcon: const Icon(Icons.search, size: 18),
// //   //                             border: OutlineInputBorder(
// //   //                               borderRadius: BorderRadius.circular(8),
// //   //                               borderSide: BorderSide(color: Colors.grey[300]!),
// //   //                             ),
// //   //                             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //   //                             isDense: true,
// //   //                           ),
// //   //                           onChanged: (query) {
// //   //                             setState(() => sectionSearchQuery = query);
// //   //                           },
// //   //                         ),
// //   //                       ),
// //   //                       ConstrainedBox(
// //   //                         constraints: const BoxConstraints(maxHeight: 300),
// //   //                         child: isLoadingSections
// //   //                             ? const Center(
// //   //                                 padding: EdgeInsets.all(32),
// //   //                                 child: SizedBox(
// //   //                                   height: 40,
// //   //                                   width: 40,
// //   //                                   child: CircularProgressIndicator(strokeWidth: 2),
// //   //                                 ),
// //   //                               )
// //   //                             : sections.isEmpty
// //   //                                 ? const Padding(
// //   //                                     padding: EdgeInsets.all(32),
// //   //                                     child: Center(
// //   //                                       child: Text("No sections available", style: TextStyle(color: Colors.grey)),
// //   //                                     ),
// //   //                                   )
// //   //                                 : ListView(
// //   //                                     shrinkWrap: true,
// //   //                                     children: sections.where((section) {
// //   //                                       final name = section['name']?.toLowerCase() ?? '';
// //   //                                       final code = section['code']?.toLowerCase() ?? '';
// //   //                                       final query = sectionSearchQuery.toLowerCase();
// //   //                                       return name.contains(query) || code.contains(query);
// //   //                                     }).map((section) => _buildSectionOption(section)).toList(),
// //   //                                   ),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //             ],
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Full Name
// //   //         _buildFormField(
// //   //           label: "Full Name *",
// //   //           child: MyTextFieldValidator(
// //   //             controller: fullNameController,
// //   //             hintText: "John Visitor",
// //   //             obscureText: false,
// //   //             validator: (value) {
// //   //               if (value == null || value.trim().isEmpty) return "Full name is required";
// //   //               return null;
// //   //             },
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Email
// //   //         _buildFormField(
// //   //           label: "Email *",
// //   //           child: MyTextFieldValidator(
// //   //             controller: emailController,
// //   //             hintText: "john@example.com",
// //   //             obscureText: false,
// //   //             validator: (value) {
// //   //               if (value == null || value.trim().isEmpty) return "Email is required";
// //   //               if (!value.contains('@')) return "Enter a valid email";
// //   //               return null;
// //   //             },
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Phone Number
// //   //         _buildFormField(
// //   //           label: "Phone Number *",
// //   //           child: MyTextFieldValidator(
// //   //             controller: phoneNumberController,
// //   //             hintText: "+1234567890",
// //   //             obscureText: false,
// //   //             validator: (value) {
// //   //               if (value == null || value.trim().isEmpty) return "Phone number is required";
// //   //               return null;
// //   //             },
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Designated Check-in
// //   //         _buildFormField(
// //   //           label: "Designated Check-in *",
// //   //           child: GestureDetector(
// //   //             onTap: () => _selectCheckInDate(context),
// //   //             child: Container(
// //   //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //               decoration: BoxDecoration(
// //   //                 color: Colors.grey[50],
// //   //                 borderRadius: BorderRadius.circular(12),
// //   //                 border: Border.all(color: Colors.grey[300]!),
// //   //               ),
// //   //               child: Row(
// //   //                 children: [
// //   //                   Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
// //   //                   const SizedBox(width: 12),
// //   //                   Expanded(
// //   //                     child: Text(
// //   //                       _formatDateTime(designatedCheckIn),
// //   //                       style: TextStyle(
// //   //                         color: designatedCheckIn == null ? Colors.grey[500] : Colors.black87,
// //   //                         fontSize: 14,
// //   //                       ),
// //   //                     ),
// //   //                   ),
// //   //                   Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey[600]),
// //   //                 ],
// //   //               ),
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Designated Check-out
// //   //         _buildFormField(
// //   //           label: "Designated Check-out *",
// //   //           child: GestureDetector(
// //   //             onTap: () => _selectCheckOutDate(context),
// //   //             child: Container(
// //   //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //               decoration: BoxDecoration(
// //   //                 color: Colors.grey[50],
// //   //                 borderRadius: BorderRadius.circular(12),
// //   //                 border: Border.all(color: Colors.grey[300]!),
// //   //               ),
// //   //               child: Row(
// //   //                 children: [
// //   //                   Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
// //   //                   const SizedBox(width: 12),
// //   //                   Expanded(
// //   //                     child: Text(
// //   //                       _formatDateTime(designatedCheckOut),
// //   //                       style: TextStyle(
// //   //                         color: designatedCheckOut == null ? Colors.grey[500] : Colors.black87,
// //   //                         fontSize: 14,
// //   //                       ),
// //   //                     ),
// //   //                   ),
// //   //                   Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey[600]),
// //   //                 ],
// //   //               ),
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Approvers Selection - Inline Dropdown
// //   //         _buildFormField(
// //   //           label: "Approvers * (Exactly 2)",
// //   //           child: Column(
// //   //             crossAxisAlignment: CrossAxisAlignment.start,
// //   //             children: [
// //   //               GestureDetector(
// //   //                 onTap: () {
// //   //                   setState(() {
// //   //                     isApproverDropdownVisible = !isApproverDropdownVisible;
// //   //                     if (isApproverDropdownVisible) {
// //   //                       isSiteDropdownVisible = false;
// //   //                       isSectionDropdownVisible = false;
// //   //                       approverSearchQuery = '';
// //   //                     }
// //   //                   });
// //   //                 },
// //   //                 child: Container(
// //   //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //                   decoration: BoxDecoration(
// //   //                     color: Colors.grey[50],
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(color: Colors.grey[300]!),
// //   //                   ),
// //   //                   child: Row(
// //   //                     children: [
// //   //                       Icon(Icons.verified_user, size: 20, color: Colors.grey[600]),
// //   //                       const SizedBox(width: 12),
// //   //                       Expanded(
// //   //                         child: Text(
// //   //                           _selectedApproversPreview,
// //   //                           style: TextStyle(
// //   //                             color: selectedApproversIds.isEmpty ? Colors.grey[500] : Colors.black87,
// //   //                             fontSize: 14,
// //   //                           ),
// //   //                         ),
// //   //                       ),
// //   //                       Icon(
// //   //                         isApproverDropdownVisible ? Icons.expand_less : Icons.expand_more,
// //   //                         size: 20,
// //   //                         color: Colors.grey[600],
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //               ),
// //   //               if (selectedApproversIds.length == 2)
// //   //                 Padding(
// //   //                   padding: const EdgeInsets.only(top: 8),
// //   //                   child: Container(
// //   //                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //   //                     decoration: BoxDecoration(
// //   //                       color: Colors.green.withOpacity(0.1),
// //   //                       borderRadius: BorderRadius.circular(6),
// //   //                     ),
// //   //                     child: Row(
// //   //                       mainAxisSize: MainAxisSize.min,
// //   //                       children: [
// //   //                         Icon(Icons.check_circle, size: 12, color: Colors.green[600]),
// //   //                         const SizedBox(width: 6),
// //   //                         Text(
// //   //                           "2 approvers selected",
// //   //                           style: TextStyle(fontSize: 11, color: Colors.green[600]),
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //                 ),
// //   //               if (isApproverDropdownVisible)
// //   //                 Container(
// //   //                   margin: const EdgeInsets.only(top: 8),
// //   //                   decoration: BoxDecoration(
// //   //                     color: Colors.white,
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(color: Colors.grey[200]!),
// //   //                     boxShadow: [
// //   //                       BoxShadow(
// //   //                         color: Colors.black.withOpacity(0.05),
// //   //                         blurRadius: 8,
// //   //                         offset: const Offset(0, 2),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                   child: Column(
// //   //                     children: [
// //   //                       Padding(
// //   //                         padding: const EdgeInsets.all(12),
// //   //                         child: TextField(
// //   //                           decoration: InputDecoration(
// //   //                             hintText: "Search employees...",
// //   //                             prefixIcon: const Icon(Icons.search, size: 18),
// //   //                             border: OutlineInputBorder(
// //   //                               borderRadius: BorderRadius.circular(8),
// //   //                               borderSide: BorderSide(color: Colors.grey[300]!),
// //   //                             ),
// //   //                             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //   //                             isDense: true,
// //   //                           ),
// //   //                           onChanged: (query) {
// //   //                             setState(() => approverSearchQuery = query);
// //   //                           },
// //   //                         ),
// //   //                       ),
// //   //                       ConstrainedBox(
// //   //                         constraints: const BoxConstraints(maxHeight: 300),
// //   //                         child: isLoadingEmployees
// //   //                             ? const Center(
// //   //                                 padding: EdgeInsets.all(32),
// //   //                                 child: SizedBox(
// //   //                                   height: 40,
// //   //                                   width: 40,
// //   //                                   child: CircularProgressIndicator(strokeWidth: 2),
// //   //                                 ),
// //   //                               )
// //   //                             : employees.isEmpty
// //   //                                 ? const Padding(
// //   //                                     padding: EdgeInsets.all(32),
// //   //                                     child: Center(
// //   //                                       child: Text("No employees found", style: TextStyle(color: Colors.grey)),
// //   //                                     ),
// //   //                                   )
// //   //                                 : ListView(
// //   //                                     shrinkWrap: true,
// //   //                                     children: employees.where((emp) {
// //   //                                       final name = emp['full_name']?.toLowerCase() ?? '';
// //   //                                       final email = emp['email']?.toLowerCase() ?? '';
// //   //                                       final query = approverSearchQuery.toLowerCase();
// //   //                                       return name.contains(query) || email.contains(query);
// //   //                                     }).map((employee) => _buildApproverOption(employee)).toList(),
// //   //                                   ),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //             ],
// //   //           ),
// //   //         ),
// //   //       ],
// //   //     ),
// //   //   );
// //   // }

// //   // Widget _buildRequiredFieldsCard() {
// //   //   return Container(
// //   //     padding: const EdgeInsets.all(24),
// //   //     decoration: BoxDecoration(
// //   //       color: Colors.white,
// //   //       borderRadius: BorderRadius.circular(16),
// //   //       boxShadow: [
// //   //         BoxShadow(
// //   //           color: Colors.black.withOpacity(0.03),
// //   //           blurRadius: 8,
// //   //           offset: const Offset(0, 2),
// //   //         ),
// //   //       ],
// //   //     ),
// //   //     child: Column(
// //   //       crossAxisAlignment: CrossAxisAlignment.start,
// //   //       children: [
// //   //         const Row(
// //   //           children: [
// //   //             Icon(Icons.info, size: 16, color: Colors.red),
// //   //             SizedBox(width: 8),
// //   //             Text(
// //   //               "Required Fields",
// //   //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //   //             ),
// //   //           ],
// //   //         ),
// //   //         const SizedBox(height: 24),

// //   //         // Site Selection - Inline Dropdown
// //   //         _buildFormField(
// //   //           label: "Site *",
// //   //           child: Focus(
// //   //             focusNode: siteFocusNode,
// //   //             child: Column(
// //   //               crossAxisAlignment: CrossAxisAlignment.start,
// //   //               children: [
// //   //                 GestureDetector(
// //   //                   onTap: () {
// //   //                     setState(() {
// //   //                       isSiteDropdownVisible = !isSiteDropdownVisible;
// //   //                       if (isSiteDropdownVisible) {
// //   //                         isSectionDropdownVisible = false;
// //   //                         isApproverDropdownVisible = false;
// //   //                       }
// //   //                     });
// //   //                   },
// //   //                   child: Container(
// //   //                     padding: const EdgeInsets.symmetric(
// //   //                         horizontal: 16, vertical: 14),
// //   //                     decoration: BoxDecoration(
// //   //                       color: Colors.grey[50],
// //   //                       borderRadius: BorderRadius.circular(12),
// //   //                       border: Border.all(color: Colors.grey[300]!),
// //   //                     ),
// //   //                     child: Row(
// //   //                       children: [
// //   //                         Icon(Icons.business,
// //   //                             size: 20, color: Colors.grey[600]),
// //   //                         const SizedBox(width: 12),
// //   //                         Expanded(
// //   //                           child: Text(
// //   //                             _selectedSiteName,
// //   //                             style: TextStyle(
// //   //                               color: selectedSiteId == null
// //   //                                   ? Colors.grey[500]
// //   //                                   : Colors.black87,
// //   //                               fontSize: 14,
// //   //                             ),
// //   //                           ),
// //   //                         ),
// //   //                         Icon(
// //   //                           isSiteDropdownVisible
// //   //                               ? Icons.expand_less
// //   //                               : Icons.expand_more,
// //   //                           size: 20,
// //   //                           color: Colors.grey[600],
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //                 ),
// //   //                 if (isSiteDropdownVisible && !isLoadingSites)
// //   //                   Container(
// //   //                     margin: const EdgeInsets.only(top: 8),
// //   //                     decoration: BoxDecoration(
// //   //                       color: Colors.white,
// //   //                       borderRadius: BorderRadius.circular(12),
// //   //                       border: Border.all(color: Colors.grey[200]!),
// //   //                       boxShadow: [
// //   //                         BoxShadow(
// //   //                           color: Colors.black.withOpacity(0.05),
// //   //                           blurRadius: 8,
// //   //                           offset: const Offset(0, 2),
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                     child: Column(
// //   //                       children: [
// //   //                         Padding(
// //   //                           padding: const EdgeInsets.all(12),
// //   //                           child: TextField(
// //   //                             autofocus: true,
// //   //                             decoration: InputDecoration(
// //   //                               hintText: "Search sites...",
// //   //                               prefixIcon: const Icon(Icons.search, size: 18),
// //   //                               border: OutlineInputBorder(
// //   //                                 borderRadius: BorderRadius.circular(8),
// //   //                                 borderSide:
// //   //                                     BorderSide(color: Colors.grey[300]!),
// //   //                               ),
// //   //                               contentPadding: const EdgeInsets.symmetric(
// //   //                                   horizontal: 12, vertical: 10),
// //   //                               isDense: true,
// //   //                             ),
// //   //                             onChanged: (query) {
// //   //                               setState(() => siteSearchQuery = query);
// //   //                             },
// //   //                           ),
// //   //                         ),
// //   //                         ConstrainedBox(
// //   //                           constraints: const BoxConstraints(
// //   //                               maxHeight: 250, minHeight: 100),
// //   //                           child: ListView(
// //   //                             shrinkWrap: true,
// //   //                             children: [
// //   //                               if (sites.where((site) {
// //   //                                 final name =
// //   //                                     site['name']?.toLowerCase() ?? '';
// //   //                                 final address =
// //   //                                     site['address']?.toLowerCase() ?? '';
// //   //                                 final query = siteSearchQuery.toLowerCase();
// //   //                                 return name.contains(query) ||
// //   //                                     address.contains(query);
// //   //                               }).isEmpty)
// //   //                                 const Padding(
// //   //                                   padding: EdgeInsets.all(32),
// //   //                                   child: Center(
// //   //                                     child: Text("No sites found",
// //   //                                         style: TextStyle(color: Colors.grey)),
// //   //                                   ),
// //   //                                 )
// //   //                               else
// //   //                                 ...sites
// //   //                                     .where((site) {
// //   //                                       final name =
// //   //                                           site['name']?.toLowerCase() ?? '';
// //   //                                       final address =
// //   //                                           site['address']?.toLowerCase() ??
// //   //                                               '';
// //   //                                       final query =
// //   //                                           siteSearchQuery.toLowerCase();
// //   //                                       return name.contains(query) ||
// //   //                                           address.contains(query);
// //   //                                     })
// //   //                                     .map((site) => _buildSiteOption(site))
// //   //                                     .toList(),
// //   //                             ],
// //   //                           ),
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //               ],
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Sections Selection - Inline Dropdown
// //   //         _buildFormField(
// //   //           label: "Sections *",
// //   //           child: Column(
// //   //             crossAxisAlignment: CrossAxisAlignment.start,
// //   //             children: [
// //   //               GestureDetector(
// //   //                 onTap: selectedSiteId != null
// //   //                     ? () {
// //   //                         setState(() {
// //   //                           isSectionDropdownVisible =
// //   //                               !isSectionDropdownVisible;
// //   //                           if (isSectionDropdownVisible) {
// //   //                             isSiteDropdownVisible = false;
// //   //                             isApproverDropdownVisible = false;
// //   //                           }
// //   //                         });
// //   //                       }
// //   //                     : null,
// //   //                 child: Container(
// //   //                   padding: const EdgeInsets.symmetric(
// //   //                       horizontal: 16, vertical: 14),
// //   //                   decoration: BoxDecoration(
// //   //                     color: selectedSiteId == null
// //   //                         ? Colors.grey[100]
// //   //                         : Colors.grey[50],
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(
// //   //                       color: selectedSiteId == null
// //   //                           ? Colors.grey[200]!
// //   //                           : Colors.grey[300]!,
// //   //                     ),
// //   //                   ),
// //   //                   child: Row(
// //   //                     children: [
// //   //                       Icon(Icons.location_city,
// //   //                           size: 20,
// //   //                           color: selectedSiteId == null
// //   //                               ? Colors.grey[400]
// //   //                               : Colors.grey[600]),
// //   //                       const SizedBox(width: 12),
// //   //                       Expanded(
// //   //                         child: Text(
// //   //                           _selectedSectionsPreview,
// //   //                           style: TextStyle(
// //   //                             color: selectedSectionIds.isEmpty
// //   //                                 ? Colors.grey[500]
// //   //                                 : Colors.black87,
// //   //                             fontSize: 14,
// //   //                           ),
// //   //                         ),
// //   //                       ),
// //   //                       if (selectedSiteId != null)
// //   //                         Icon(
// //   //                           isSectionDropdownVisible
// //   //                               ? Icons.expand_less
// //   //                               : Icons.expand_more,
// //   //                           size: 20,
// //   //                           color: Colors.grey[600],
// //   //                         ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //               ),
// //   //               if (selectedSiteId == null)
// //   //                 Padding(
// //   //                   padding: const EdgeInsets.only(top: 8),
// //   //                   child: Row(
// //   //                     children: [
// //   //                       Icon(Icons.info_outline,
// //   //                           size: 12, color: Colors.orange),
// //   //                       const SizedBox(width: 4),
// //   //                       Text(
// //   //                         "Please select a site first",
// //   //                         style: TextStyle(
// //   //                             fontSize: 11, color: Colors.orange[600]),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //               if (isSectionDropdownVisible &&
// //   //                   selectedSiteId != null &&
// //   //                   !isLoadingSections)
// //   //                 Container(
// //   //                   margin: const EdgeInsets.only(top: 8),
// //   //                   decoration: BoxDecoration(
// //   //                     color: Colors.white,
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(color: Colors.grey[200]!),
// //   //                     boxShadow: [
// //   //                       BoxShadow(
// //   //                         color: Colors.black.withOpacity(0.05),
// //   //                         blurRadius: 8,
// //   //                         offset: const Offset(0, 2),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                   child: Column(
// //   //                     children: [
// //   //                       Padding(
// //   //                         padding: const EdgeInsets.all(12),
// //   //                         child: TextField(
// //   //                           decoration: InputDecoration(
// //   //                             hintText: "Search sections...",
// //   //                             prefixIcon: const Icon(Icons.search, size: 18),
// //   //                             border: OutlineInputBorder(
// //   //                               borderRadius: BorderRadius.circular(8),
// //   //                               borderSide:
// //   //                                   BorderSide(color: Colors.grey[300]!),
// //   //                             ),
// //   //                             contentPadding: const EdgeInsets.symmetric(
// //   //                                 horizontal: 12, vertical: 10),
// //   //                             isDense: true,
// //   //                           ),
// //   //                           onChanged: (query) {
// //   //                             setState(() => sectionSearchQuery = query);
// //   //                           },
// //   //                         ),
// //   //                       ),
// //   //                       ConstrainedBox(
// //   //                         constraints: const BoxConstraints(maxHeight: 300),
// //   //                         child: isLoadingSections
// //   //                             ? const Center(
// //   //                                 child: Padding(
// //   //                                 padding: EdgeInsets.all(32),
// //   //                                 child: SizedBox(
// //   //                                   height: 40,
// //   //                                   width: 40,
// //   //                                   child: CircularProgressIndicator(
// //   //                                       strokeWidth: 2),
// //   //                                 ),
// //   //                               ))
// //   //                             : sections.isEmpty
// //   //                                 ? const Padding(
// //   //                                     padding: EdgeInsets.all(32),
// //   //                                     child: Center(
// //   //                                       child: Text("No sections available",
// //   //                                           style:
// //   //                                               TextStyle(color: Colors.grey)),
// //   //                                     ),
// //   //                                   )
// //   //                                 : ListView(
// //   //                                     shrinkWrap: true,
// //   //                                     children: sections
// //   //                                         .where((section) {
// //   //                                           final name = section['name']
// //   //                                                   ?.toLowerCase() ??
// //   //                                               '';
// //   //                                           final code = section['code']
// //   //                                                   ?.toLowerCase() ??
// //   //                                               '';
// //   //                                           final query = sectionSearchQuery
// //   //                                               .toLowerCase();
// //   //                                           return name.contains(query) ||
// //   //                                               code.contains(query);
// //   //                                         })
// //   //                                         .map((section) =>
// //   //                                             _buildSectionOption(section))
// //   //                                         .toList(),
// //   //                                   ),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //             ],
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Full Name
// //   //         _buildFormField(
// //   //           label: "Full Name *",
// //   //           child: MyTextFieldValidator(
// //   //             controller: fullNameController,
// //   //             hintText: "John Visitor",
// //   //             obscureText: false,
// //   //             validator: (value) {
// //   //               if (value == null || value.trim().isEmpty)
// //   //                 return "Full name is required";
// //   //               return null;
// //   //             },
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Email
// //   //         _buildFormField(
// //   //           label: "Email *",
// //   //           child: MyTextFieldValidator(
// //   //             controller: emailController,
// //   //             hintText: "john@example.com",
// //   //             obscureText: false,
// //   //             validator: (value) {
// //   //               if (value == null || value.trim().isEmpty)
// //   //                 return "Email is required";
// //   //               if (!value.contains('@')) return "Enter a valid email";
// //   //               return null;
// //   //             },
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Phone Number
// //   //         _buildFormField(
// //   //           label: "Phone Number *",
// //   //           child: MyTextFieldValidator(
// //   //             controller: phoneNumberController,
// //   //             hintText: "+1234567890",
// //   //             obscureText: false,
// //   //             validator: (value) {
// //   //               if (value == null || value.trim().isEmpty)
// //   //                 return "Phone number is required";
// //   //               return null;
// //   //             },
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Designated Check-in
// //   //         _buildFormField(
// //   //           label: "Designated Check-in *",
// //   //           child: GestureDetector(
// //   //             onTap: () => _selectCheckInDate(context),
// //   //             child: Container(
// //   //               padding:
// //   //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //               decoration: BoxDecoration(
// //   //                 color: Colors.grey[50],
// //   //                 borderRadius: BorderRadius.circular(12),
// //   //                 border: Border.all(color: Colors.grey[300]!),
// //   //               ),
// //   //               child: Row(
// //   //                 children: [
// //   //                   Icon(Icons.calendar_today,
// //   //                       size: 20, color: Colors.grey[600]),
// //   //                   const SizedBox(width: 12),
// //   //                   Expanded(
// //   //                     child: Text(
// //   //                       _formatDateTime(designatedCheckIn),
// //   //                       style: TextStyle(
// //   //                         color: designatedCheckIn == null
// //   //                             ? Colors.grey[500]
// //   //                             : Colors.black87,
// //   //                         fontSize: 14,
// //   //                       ),
// //   //                     ),
// //   //                   ),
// //   //                   Icon(Icons.arrow_drop_down,
// //   //                       size: 20, color: Colors.grey[600]),
// //   //                 ],
// //   //               ),
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Designated Check-out
// //   //         _buildFormField(
// //   //           label: "Designated Check-out *",
// //   //           child: GestureDetector(
// //   //             onTap: () => _selectCheckOutDate(context),
// //   //             child: Container(
// //   //               padding:
// //   //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //   //               decoration: BoxDecoration(
// //   //                 color: Colors.grey[50],
// //   //                 borderRadius: BorderRadius.circular(12),
// //   //                 border: Border.all(color: Colors.grey[300]!),
// //   //               ),
// //   //               child: Row(
// //   //                 children: [
// //   //                   Icon(Icons.calendar_today,
// //   //                       size: 20, color: Colors.grey[600]),
// //   //                   const SizedBox(width: 12),
// //   //                   Expanded(
// //   //                     child: Text(
// //   //                       _formatDateTime(designatedCheckOut),
// //   //                       style: TextStyle(
// //   //                         color: designatedCheckOut == null
// //   //                             ? Colors.grey[500]
// //   //                             : Colors.black87,
// //   //                         fontSize: 14,
// //   //                       ),
// //   //                     ),
// //   //                   ),
// //   //                   Icon(Icons.arrow_drop_down,
// //   //                       size: 20, color: Colors.grey[600]),
// //   //                 ],
// //   //               ),
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 20),

// //   //         // Approvers Selection - Inline Dropdown
// //   //         _buildFormField(
// //   //           label: "Approvers * (Exactly 2)",
// //   //           child: Column(
// //   //             crossAxisAlignment: CrossAxisAlignment.start,
// //   //             children: [
// //   //               GestureDetector(
// //   //                 onTap: () {
// //   //                   setState(() {
// //   //                     isApproverDropdownVisible = !isApproverDropdownVisible;
// //   //                     if (isApproverDropdownVisible) {
// //   //                       isSiteDropdownVisible = false;
// //   //                       isSectionDropdownVisible = false;
// //   //                       approverSearchQuery = '';
// //   //                     }
// //   //                   });
// //   //                 },
// //   //                 child: Container(
// //   //                   padding: const EdgeInsets.symmetric(
// //   //                       horizontal: 16, vertical: 14),
// //   //                   decoration: BoxDecoration(
// //   //                     color: Colors.grey[50],
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(color: Colors.grey[300]!),
// //   //                   ),
// //   //                   child: Row(
// //   //                     children: [
// //   //                       Icon(Icons.verified_user,
// //   //                           size: 20, color: Colors.grey[600]),
// //   //                       const SizedBox(width: 12),
// //   //                       Expanded(
// //   //                         child: Text(
// //   //                           _selectedApproversPreview,
// //   //                           style: TextStyle(
// //   //                             color: selectedApproversIds.isEmpty
// //   //                                 ? Colors.grey[500]
// //   //                                 : Colors.black87,
// //   //                             fontSize: 14,
// //   //                           ),
// //   //                         ),
// //   //                       ),
// //   //                       Icon(
// //   //                         isApproverDropdownVisible
// //   //                             ? Icons.expand_less
// //   //                             : Icons.expand_more,
// //   //                         size: 20,
// //   //                         color: Colors.grey[600],
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //               ),
// //   //               if (selectedApproversIds.length == 2)
// //   //                 Padding(
// //   //                   padding: const EdgeInsets.only(top: 8),
// //   //                   child: Container(
// //   //                     padding: const EdgeInsets.symmetric(
// //   //                         horizontal: 10, vertical: 6),
// //   //                     decoration: BoxDecoration(
// //   //                       color: Colors.green.withOpacity(0.1),
// //   //                       borderRadius: BorderRadius.circular(6),
// //   //                     ),
// //   //                     child: Row(
// //   //                       mainAxisSize: MainAxisSize.min,
// //   //                       children: [
// //   //                         Icon(Icons.check_circle,
// //   //                             size: 12, color: Colors.green[600]),
// //   //                         const SizedBox(width: 6),
// //   //                         Text(
// //   //                           "2 approvers selected",
// //   //                           style: TextStyle(
// //   //                               fontSize: 11, color: Colors.green[600]),
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //                 ),
// //   //               if (isApproverDropdownVisible)
// //   //                 Container(
// //   //                   margin: const EdgeInsets.only(top: 8),
// //   //                   decoration: BoxDecoration(
// //   //                     color: Colors.white,
// //   //                     borderRadius: BorderRadius.circular(12),
// //   //                     border: Border.all(color: Colors.grey[200]!),
// //   //                     boxShadow: [
// //   //                       BoxShadow(
// //   //                         color: Colors.black.withOpacity(0.05),
// //   //                         blurRadius: 8,
// //   //                         offset: const Offset(0, 2),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                   child: Column(
// //   //                     children: [
// //   //                       Padding(
// //   //                         padding: const EdgeInsets.all(12),
// //   //                         child: TextField(
// //   //                           decoration: InputDecoration(
// //   //                             hintText: "Search employees...",
// //   //                             prefixIcon: const Icon(Icons.search, size: 18),
// //   //                             border: OutlineInputBorder(
// //   //                               borderRadius: BorderRadius.circular(8),
// //   //                               borderSide:
// //   //                                   BorderSide(color: Colors.grey[300]!),
// //   //                             ),
// //   //                             contentPadding: const EdgeInsets.symmetric(
// //   //                                 horizontal: 12, vertical: 10),
// //   //                             isDense: true,
// //   //                           ),
// //   //                           onChanged: (query) {
// //   //                             setState(() => approverSearchQuery = query);
// //   //                           },
// //   //                         ),
// //   //                       ),
// //   //                       ConstrainedBox(
// //   //                         constraints: const BoxConstraints(maxHeight: 300),
// //   //                         child: isLoadingEmployees
// //   //                             ? const Center(
// //   //                                 child: Padding(
// //   //                                 padding: EdgeInsets.all(32),
// //   //                                 child: SizedBox(
// //   //                                   height: 40,
// //   //                                   width: 40,
// //   //                                   child: CircularProgressIndicator(
// //   //                                       strokeWidth: 2),
// //   //                                 ),
// //   //                               ))
// //   //                             : employees.isEmpty
// //   //                                 ? const Padding(
// //   //                                     padding: EdgeInsets.all(32),
// //   //                                     child: Center(
// //   //                                       child: Text("No employees found",
// //   //                                           style:
// //   //                                               TextStyle(color: Colors.grey)),
// //   //                                     ),
// //   //                                   )
// //   //                                 : ListView(
// //   //                                     shrinkWrap: true,
// //   //                                     children: employees
// //   //                                         .where((emp) {
// //   //                                           final name = emp['full_name']
// //   //                                                   ?.toLowerCase() ??
// //   //                                               '';
// //   //                                           final email =
// //   //                                               emp['email']?.toLowerCase() ??
// //   //                                                   '';
// //   //                                           final query = approverSearchQuery
// //   //                                               .toLowerCase();
// //   //                                           return name.contains(query) ||
// //   //                                               email.contains(query);
// //   //                                         })
// //   //                                         .map((employee) =>
// //   //                                             _buildApproverOption(employee))
// //   //                                         .toList(),
// //   //                                   ),
// //   //                       ),
// //   //                     ],
// //   //                   ),
// //   //                 ),
// //   //             ],
// //   //           ),
// //   //         ),
// //   //       ],
// //   //     ),
// //   //   );
// //   // }

// //   Widget _buildRequiredFieldsCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(24),
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
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Row(
// //             children: [
// //               Icon(Icons.info, size: 16, color: Colors.red),
// //               SizedBox(width: 8),
// //               Text(
// //                 "Required Fields",
// //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 24),

// //           // Site Selection - Inline Dropdown
// //           _buildFormField(
// //             label: "Site *",
// //             child: Focus(
// //               focusNode: siteFocusNode,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {
// //                       setState(() {
// //                         isSiteDropdownVisible = !isSiteDropdownVisible;
// //                         if (isSiteDropdownVisible) {
// //                           isSectionDropdownVisible = false;
// //                           isApproverDropdownVisible = false;
// //                         }
// //                       });
// //                     },
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 16, vertical: 14),
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey[50],
// //                         borderRadius: BorderRadius.circular(12),
// //                         border: Border.all(color: Colors.grey[300]!),
// //                       ),
// //                       child: Row(
// //                         children: [
// //                           Icon(Icons.business,
// //                               size: 20, color: Colors.grey[600]),
// //                           const SizedBox(width: 12),
// //                           Expanded(
// //                             child: Text(
// //                               _selectedSiteName,
// //                               style: TextStyle(
// //                                 color: selectedSiteId == null
// //                                     ? Colors.grey[500]
// //                                     : Colors.black87,
// //                                 fontSize: 14,
// //                               ),
// //                             ),
// //                           ),
// //                           Icon(
// //                             isSiteDropdownVisible
// //                                 ? Icons.expand_less
// //                                 : Icons.expand_more,
// //                             size: 20,
// //                             color: Colors.grey[600],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   if (isSiteDropdownVisible && !isLoadingSites)
// //                     Container(
// //                       margin: const EdgeInsets.only(top: 8),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(12),
// //                         border: Border.all(color: Colors.grey[200]!),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.05),
// //                             blurRadius: 8,
// //                             offset: const Offset(0, 2),
// //                           ),
// //                         ],
// //                       ),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.all(12),
// //                             child: TextField(
// //                               autofocus: true,
// //                               decoration: InputDecoration(
// //                                 hintText: "Search sites...",
// //                                 prefixIcon: const Icon(Icons.search, size: 18),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(8),
// //                                   borderSide:
// //                                       BorderSide(color: Colors.grey[300]!),
// //                                 ),
// //                                 contentPadding: const EdgeInsets.symmetric(
// //                                     horizontal: 12, vertical: 10),
// //                                 isDense: true,
// //                               ),
// //                               onChanged: (query) {
// //                                 setState(() => siteSearchQuery = query);
// //                               },
// //                             ),
// //                           ),
// //                           // FIXED: Use SingleChildScrollView with Column instead of ListView
// //                           ConstrainedBox(
// //                             constraints: const BoxConstraints(maxHeight: 250),
// //                             child: SingleChildScrollView(
// //                               child: Column(
// //                                 children: [
// //                                   // Filter and build site options
// //                                   ...sites
// //                                       .where((site) {
// //                                         final name =
// //                                             site['name']?.toLowerCase() ?? '';
// //                                         final address =
// //                                             site['address']?.toLowerCase() ??
// //                                                 '';
// //                                         final query =
// //                                             siteSearchQuery.toLowerCase();
// //                                         return name.contains(query) ||
// //                                             address.contains(query);
// //                                       })
// //                                       .map((site) => _buildSiteOption(site))
// //                                       .toList(),
// //                                   if (sites.where((site) {
// //                                     final name =
// //                                         site['name']?.toLowerCase() ?? '';
// //                                     final address =
// //                                         site['address']?.toLowerCase() ?? '';
// //                                     final query = siteSearchQuery.toLowerCase();
// //                                     return name.contains(query) ||
// //                                         address.contains(query);
// //                                   }).isEmpty)
// //                                     const Padding(
// //                                       padding: EdgeInsets.all(32),
// //                                       child: Center(
// //                                         child: Text("No sites found",
// //                                             style:
// //                                                 TextStyle(color: Colors.grey)),
// //                                       ),
// //                                     ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Sections Selection - Inline Dropdown
// //           _buildFormField(
// //             label: "Sections *",
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 GestureDetector(
// //                   onTap: selectedSiteId != null
// //                       ? () {
// //                           setState(() {
// //                             isSectionDropdownVisible =
// //                                 !isSectionDropdownVisible;
// //                             if (isSectionDropdownVisible) {
// //                               isSiteDropdownVisible = false;
// //                               isApproverDropdownVisible = false;
// //                             }
// //                           });
// //                         }
// //                       : null,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(
// //                         horizontal: 16, vertical: 14),
// //                     decoration: BoxDecoration(
// //                       color: selectedSiteId == null
// //                           ? Colors.grey[100]
// //                           : Colors.grey[50],
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(
// //                         color: selectedSiteId == null
// //                             ? Colors.grey[200]!
// //                             : Colors.grey[300]!,
// //                       ),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.location_city,
// //                             size: 20,
// //                             color: selectedSiteId == null
// //                                 ? Colors.grey[400]
// //                                 : Colors.grey[600]),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: Text(
// //                             _selectedSectionsPreview,
// //                             style: TextStyle(
// //                               color: selectedSectionIds.isEmpty
// //                                   ? Colors.grey[500]
// //                                   : Colors.black87,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ),
// //                         if (selectedSiteId != null)
// //                           Icon(
// //                             isSectionDropdownVisible
// //                                 ? Icons.expand_less
// //                                 : Icons.expand_more,
// //                             size: 20,
// //                             color: Colors.grey[600],
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 if (selectedSiteId == null)
// //                   Padding(
// //                     padding: const EdgeInsets.only(top: 8),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.info_outline,
// //                             size: 12, color: Colors.orange),
// //                         const SizedBox(width: 4),
// //                         Text(
// //                           "Please select a site first",
// //                           style: TextStyle(
// //                               fontSize: 11, color: Colors.orange[600]),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 if (isSectionDropdownVisible &&
// //                     selectedSiteId != null &&
// //                     !isLoadingSections)
// //                   Container(
// //                     margin: const EdgeInsets.only(top: 8),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: Colors.grey[200]!),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black.withOpacity(0.05),
// //                           blurRadius: 8,
// //                           offset: const Offset(0, 2),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.all(12),
// //                           child: TextField(
// //                             decoration: InputDecoration(
// //                               hintText: "Search sections...",
// //                               prefixIcon: const Icon(Icons.search, size: 18),
// //                               border: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                                 borderSide:
// //                                     BorderSide(color: Colors.grey[300]!),
// //                               ),
// //                               contentPadding: const EdgeInsets.symmetric(
// //                                   horizontal: 12, vertical: 10),
// //                               isDense: true,
// //                             ),
// //                             onChanged: (query) {
// //                               setState(() => sectionSearchQuery = query);
// //                             },
// //                           ),
// //                         ),
// //                         if (isLoadingSections)
// //                           const Padding(
// //                             padding: EdgeInsets.all(32),
// //                             child: Center(
// //                               child: SizedBox(
// //                                 height: 40,
// //                                 width: 40,
// //                                 child:
// //                                     CircularProgressIndicator(strokeWidth: 2),
// //                               ),
// //                             ),
// //                           )
// //                         else
// //                           ConstrainedBox(
// //                             constraints: const BoxConstraints(maxHeight: 300),
// //                             child: SingleChildScrollView(
// //                               child: Column(
// //                                 children: [
// //                                   ...sections
// //                                       .where((section) {
// //                                         final name =
// //                                             section['name']?.toLowerCase() ??
// //                                                 '';
// //                                         final code =
// //                                             section['code']?.toLowerCase() ??
// //                                                 '';
// //                                         final query =
// //                                             sectionSearchQuery.toLowerCase();
// //                                         return name.contains(query) ||
// //                                             code.contains(query);
// //                                       })
// //                                       .map((section) =>
// //                                           _buildSectionOption(section))
// //                                       .toList(),
// //                                   if (sections.isEmpty)
// //                                     const Padding(
// //                                       padding: EdgeInsets.all(32),
// //                                       child: Center(
// //                                         child: Text("No sections available",
// //                                             style:
// //                                                 TextStyle(color: Colors.grey)),
// //                                       ),
// //                                     ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Full Name
// //           _buildFormField(
// //             label: "Full Name *",
// //             child: MyTextFieldValidator(
// //               controller: fullNameController,
// //               hintText: "John Visitor",
// //               obscureText: false,
// //               validator: (value) {
// //                 if (value == null || value.trim().isEmpty)
// //                   return "Full name is required";
// //                 return null;
// //               },
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Email
// //           _buildFormField(
// //             label: "Email *",
// //             child: MyTextFieldValidator(
// //               controller: emailController,
// //               hintText: "john@example.com",
// //               obscureText: false,
// //               validator: (value) {
// //                 if (value == null || value.trim().isEmpty)
// //                   return "Email is required";
// //                 if (!value.contains('@')) return "Enter a valid email";
// //                 return null;
// //               },
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Phone Number
// //           _buildFormField(
// //             label: "Phone Number *",
// //             child: MyTextFieldValidator(
// //               controller: phoneNumberController,
// //               hintText: "+1234567890",
// //               obscureText: false,
// //               validator: (value) {
// //                 if (value == null || value.trim().isEmpty)
// //                   return "Phone number is required";
// //                 return null;
// //               },
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Designated Check-in
// //           _buildFormField(
// //             label: "Designated Check-in *",
// //             child: GestureDetector(
// //               onTap: () => _selectCheckInDate(context),
// //               child: Container(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[50],
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(color: Colors.grey[300]!),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Icon(Icons.calendar_today,
// //                         size: 20, color: Colors.grey[600]),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Text(
// //                         _formatDateTime(designatedCheckIn),
// //                         style: TextStyle(
// //                           color: designatedCheckIn == null
// //                               ? Colors.grey[500]
// //                               : Colors.black87,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                     ),
// //                     Icon(Icons.arrow_drop_down,
// //                         size: 20, color: Colors.grey[600]),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Designated Check-out
// //           _buildFormField(
// //             label: "Designated Check-out *",
// //             child: GestureDetector(
// //               onTap: () => _selectCheckOutDate(context),
// //               child: Container(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //                 // decoration: BoxDecoration(
// //                 //   color: Colors.grey[50],
// //                 //   borderRadius: BorderRadius.cicular(12),
// //                 //   border: Border.all(color: Colors.grey[300]!),
// //                 // ),
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[50],
// //                   borderRadius: BorderRadius.circular(
// //                       12), // Fixed: 'circular' not 'cicular'
// //                   border: Border.all(color: Colors.grey[300]!),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Icon(Icons.calendar_today,
// //                         size: 20, color: Colors.grey[600]),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Text(
// //                         _formatDateTime(designatedCheckOut),
// //                         style: TextStyle(
// //                           color: designatedCheckOut == null
// //                               ? Colors.grey[500]
// //                               : Colors.black87,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                     ),
// //                     Icon(Icons.arrow_drop_down,
// //                         size: 20, color: Colors.grey[600]),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),

// //           // Approvers Selection - Inline Dropdown
// //           _buildFormField(
// //             label: "Approvers * (Exactly 2)",
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     setState(() {
// //                       isApproverDropdownVisible = !isApproverDropdownVisible;
// //                       if (isApproverDropdownVisible) {
// //                         isSiteDropdownVisible = false;
// //                         isSectionDropdownVisible = false;
// //                         approverSearchQuery = '';
// //                       }
// //                     });
// //                   },
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(
// //                         horizontal: 16, vertical: 14),
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey[50],
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: Colors.grey[300]!),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.verified_user,
// //                             size: 20, color: Colors.grey[600]),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: Text(
// //                             _selectedApproversPreview,
// //                             style: TextStyle(
// //                               color: selectedApproversIds.isEmpty
// //                                   ? Colors.grey[500]
// //                                   : Colors.black87,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ),
// //                         Icon(
// //                           isApproverDropdownVisible
// //                               ? Icons.expand_less
// //                               : Icons.expand_more,
// //                           size: 20,
// //                           color: Colors.grey[600],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 if (selectedApproversIds.length == 2)
// //                   Padding(
// //                     padding: const EdgeInsets.only(top: 8),
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 10, vertical: 6),
// //                       decoration: BoxDecoration(
// //                         color: Colors.green.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(6),
// //                       ),
// //                       child: Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Icon(Icons.check_circle,
// //                               size: 12, color: Colors.green[600]),
// //                           const SizedBox(width: 6),
// //                           Text(
// //                             "2 approvers selected",
// //                             style: TextStyle(
// //                                 fontSize: 11, color: Colors.green[600]),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 if (isApproverDropdownVisible)
// //                   Container(
// //                     margin: const EdgeInsets.only(top: 8),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: Colors.grey[200]!),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black.withOpacity(0.05),
// //                           blurRadius: 8,
// //                           offset: const Offset(0, 2),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.all(12),
// //                           child: TextField(
// //                             decoration: InputDecoration(
// //                               hintText: "Search employees...",
// //                               prefixIcon: const Icon(Icons.search, size: 18),
// //                               border: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                                 borderSide:
// //                                     BorderSide(color: Colors.grey[300]!),
// //                               ),
// //                               contentPadding: const EdgeInsets.symmetric(
// //                                   horizontal: 12, vertical: 10),
// //                               isDense: true,
// //                             ),
// //                             onChanged: (query) {
// //                               setState(() => approverSearchQuery = query);
// //                             },
// //                           ),
// //                         ),
// //                         if (isLoadingEmployees)
// //                           const Padding(
// //                             padding: EdgeInsets.all(32),
// //                             child: Center(
// //                               child: SizedBox(
// //                                 height: 40,
// //                                 width: 40,
// //                                 child:
// //                                     CircularProgressIndicator(strokeWidth: 2),
// //                               ),
// //                             ),
// //                           )
// //                         else
// //                           ConstrainedBox(
// //                             constraints: const BoxConstraints(maxHeight: 300),
// //                             child: SingleChildScrollView(
// //                               child: Column(
// //                                 children: [
// //                                   ...employees
// //                                       .where((emp) {
// //                                         final name =
// //                                             emp['full_name']?.toLowerCase() ??
// //                                                 '';
// //                                         final email =
// //                                             emp['email']?.toLowerCase() ?? '';
// //                                         final query =
// //                                             approverSearchQuery.toLowerCase();
// //                                         return name.contains(query) ||
// //                                             email.contains(query);
// //                                       })
// //                                       .map((employee) =>
// //                                           _buildApproverOption(employee))
// //                                       .toList(),
// //                                   if (employees.isEmpty)
// //                                     const Padding(
// //                                       padding: EdgeInsets.all(32),
// //                                       child: Center(
// //                                         child: Text("No employees found",
// //                                             style:
// //                                                 TextStyle(color: Colors.grey)),
// //                                       ),
// //                                     ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSiteOption(Map<String, dynamic> site) {
// //     final isSelected = selectedSiteId == site['id'];
// //     return InkWell(
// //       onTap: () {
// //         setState(() {
// //           selectedSiteId = site['id'];
// //           isSiteDropdownVisible = false;
// //           siteSearchQuery = '';
// //           _fetchSectionsForSite(selectedSiteId!);
// //         });
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           color:
// //               isSelected ? Colors.blue.withOpacity(0.05) : Colors.transparent,
// //           border: isSelected
// //               ? Border(left: BorderSide(color: Colors.blue, width: 3))
// //               : null,
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(Icons.business,
// //                 size: 18, color: isSelected ? Colors.blue : Colors.grey[500]),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     site['name'] ?? 'Unknown',
// //                     style: TextStyle(
// //                       fontWeight:
// //                           isSelected ? FontWeight.w600 : FontWeight.normal,
// //                       color: isSelected ? Colors.blue : Colors.black87,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                   if (site['address'] != null && site['address'].isNotEmpty)
// //                     Text(
// //                       site['address'],
// //                       style: TextStyle(fontSize: 11, color: Colors.grey[500]),
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                 ],
// //               ),
// //             ),
// //             if (isSelected)
// //               Icon(Icons.check_circle, size: 16, color: Colors.blue),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSectionOption(Map<String, dynamic> section) {
// //     final isSelected = selectedSectionIds.contains(section['id']);
// //     return InkWell(
// //       onTap: () {
// //         setState(() {
// //           if (isSelected) {
// //             selectedSectionIds.remove(section['id']);
// //           } else {
// //             selectedSectionIds.add(section['id']);
// //           }
// //         });
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           color:
// //               isSelected ? Colors.blue.withOpacity(0.05) : Colors.transparent,
// //         ),
// //         child: Row(
// //           children: [
// //             Checkbox(
// //               value: isSelected,
// //               onChanged: (checked) {
// //                 setState(() {
// //                   if (checked == true) {
// //                     selectedSectionIds.add(section['id']);
// //                   } else {
// //                     selectedSectionIds.remove(section['id']);
// //                   }
// //                 });
// //               },
// //               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //               visualDensity: VisualDensity.compact,
// //               activeColor: Colors.blue,
// //             ),
// //             const SizedBox(width: 4),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     section['name'] ?? 'Unknown',
// //                     style: TextStyle(
// //                       fontWeight:
// //                           isSelected ? FontWeight.w600 : FontWeight.normal,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                   Row(
// //                     children: [
// //                       Text(
// //                         section['code'] ?? '',
// //                         style: TextStyle(fontSize: 11, color: Colors.grey[500]),
// //                       ),
// //                       if (section['requires_escort'] == true) ...[
// //                         const SizedBox(width: 8),
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(
// //                               horizontal: 6, vertical: 2),
// //                           decoration: BoxDecoration(
// //                             color: Colors.orange.withOpacity(0.1),
// //                             borderRadius: BorderRadius.circular(4),
// //                           ),
// //                           child: Text(
// //                             'Escort Required',
// //                             style: TextStyle(
// //                                 fontSize: 9, color: Colors.orange[700]),
// //                           ),
// //                         ),
// //                       ],
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildApproverOption(Map<String, dynamic> employee) {
// //     final isSelected = selectedApproversIds.contains(employee['id']);
// //     final isDisabled = !isSelected && selectedApproversIds.length >= 2;

// //     return Opacity(
// //       opacity: isDisabled ? 0.5 : 1.0,
// //       child: InkWell(
// //         onTap: isDisabled
// //             ? null
// //             : () {
// //                 setState(() {
// //                   if (isSelected) {
// //                     selectedApproversIds.remove(employee['id']);
// //                   } else if (selectedApproversIds.length < 2) {
// //                     selectedApproversIds.add(employee['id']);
// //                   }
// //                 });
// //               },
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //           decoration: BoxDecoration(
// //             color:
// //                 isSelected ? Colors.blue.withOpacity(0.05) : Colors.transparent,
// //           ),
// //           child: Row(
// //             children: [
// //               CircleAvatar(
// //                 radius: 16,
// //                 backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
// //                 child: Text(
// //                   (employee['full_name']?[0] ?? '?').toUpperCase(),
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     fontWeight: FontWeight.bold,
// //                     color: isSelected ? Colors.white : Colors.grey[600],
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       employee['full_name'] ?? 'Unknown',
// //                       style: TextStyle(
// //                         fontWeight:
// //                             isSelected ? FontWeight.w600 : FontWeight.normal,
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                     Text(
// //                       employee['email'] ?? '',
// //                       style: TextStyle(fontSize: 11, color: Colors.grey[500]),
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                     if (employee['department'] != null)
// //                       Text(
// //                         '${employee['department']} • ${employee['designation'] ?? ''}',
// //                         style: TextStyle(fontSize: 10, color: Colors.grey[400]),
// //                       ),
// //                   ],
// //                 ),
// //               ),
// //               if (isSelected)
// //                 Icon(Icons.check_circle, size: 16, color: Colors.blue),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildOptionalFieldsCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(24),
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
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Row(
// //             children: [
// //               Icon(Icons.info_outline, size: 16, color: Colors.grey),
// //               SizedBox(width: 8),
// //               Text(
// //                 "Optional Fields",
// //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 24),
// //           _buildFormField(
// //             label: "Company Name",
// //             child: MyTextField(
// //               controller: companyNameController,
// //               hintText: "Tech Solutions Inc.",
// //               obscureText: false,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           _buildFormField(
// //             label: "Purpose of Visit",
// //             child: MyTextField(
// //               controller: purposeOfVisitController,
// //               hintText: "Meeting with IT department",
// //               obscureText: false,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           _buildFormField(
// //             label: "Host Department",
// //             child: MyTextField(
// //               controller: hostDepartmentController,
// //               hintText: "IT Department",
// //               obscureText: false,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           _buildFormField(
// //             label: "Meeting Room",
// //             child: MyTextField(
// //               controller: meetingRoomController,
// //               hintText: "Conference Room A",
// //               obscureText: false,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           _buildFormField(
// //             label: "Vehicle Number",
// //             child: MyTextField(
// //               controller: vehicleNumberController,
// //               hintText: "KA01AB1234",
// //               obscureText: false,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           _buildFormField(
// //             label: "ID Card Number",
// //             child: MyTextField(
// //               controller: idCardNumberController,
// //               hintText: "ID123456",
// //               obscureText: false,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFormField({
// //     required String label,
// //     required Widget child,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.only(left: 4, bottom: 8),
// //           child: Text(
// //             label,
// //             style: TextStyle(
// //               fontSize: 13,
// //               fontWeight: FontWeight.w500,
// //               color: Colors.grey[700],
// //             ),
// //           ),
// //         ),
// //         child,
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:modernlogintute/components/my_button.dart';
// import 'package:modernlogintute/components/my_textfield.dart';
// import 'package:modernlogintute/services/api_services.dart';

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
//   final vehicleNumberController = TextEditingController();
//   final idCardNumberController = TextEditingController();

//   // DateTime fields
//   DateTime? designatedCheckIn;
//   DateTime? designatedCheckOut;

//   // Selected IDs
//   int? selectedSiteId;
//   List<int> selectedSectionIds = [];
//   List<int> selectedApproversIds = [];

//   // Data from API
//   List<dynamic> sites = [];
//   List<dynamic> sections = [];
//   List<dynamic> employees = [];

//   // Dropdown visibility states
//   bool isSiteDropdownVisible = false;
//   bool isSectionDropdownVisible = false;
//   bool isApproverDropdownVisible = false;

//   // Search filters
//   String siteSearchQuery = '';
//   String sectionSearchQuery = '';
//   String approverSearchQuery = '';

//   // Focus nodes for handling dropdown dismissal
//   final FocusNode siteFocusNode = FocusNode();
//   final FocusNode sectionFocusNode = FocusNode();
//   final FocusNode approverFocusNode = FocusNode();

//   // Loading states
//   bool isLoading = false;
//   bool isLoadingSites = true;
//   bool isLoadingEmployees = true;
//   bool isLoadingSections = false;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialData();

//     // Add focus listeners to close dropdowns when focus is lost
//     siteFocusNode.addListener(() {
//       if (!siteFocusNode.hasFocus) {
//         Future.delayed(const Duration(milliseconds: 200), () {
//           if (mounted && !siteFocusNode.hasFocus) {
//             setState(() => isSiteDropdownVisible = false);
//           }
//         });
//       }
//     });

//     sectionFocusNode.addListener(() {
//       if (!sectionFocusNode.hasFocus) {
//         Future.delayed(const Duration(milliseconds: 200), () {
//           if (mounted && !sectionFocusNode.hasFocus) {
//             setState(() => isSectionDropdownVisible = false);
//           }
//         });
//       }
//     });

//     approverFocusNode.addListener(() {
//       if (!approverFocusNode.hasFocus) {
//         Future.delayed(const Duration(milliseconds: 200), () {
//           if (mounted && !approverFocusNode.hasFocus) {
//             setState(() => isApproverDropdownVisible = false);
//           }
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     fullNameController.dispose();
//     emailController.dispose();
//     phoneNumberController.dispose();
//     companyNameController.dispose();
//     purposeOfVisitController.dispose();
//     hostDepartmentController.dispose();
//     meetingRoomController.dispose();
//     vehicleNumberController.dispose();
//     idCardNumberController.dispose();
//     siteFocusNode.dispose();
//     sectionFocusNode.dispose();
//     approverFocusNode.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchInitialData() async {
//     await Future.wait([
//       _fetchSites(),
//       _fetchEmployees(),
//     ]);
//   }

//   Future<void> _fetchSites() async {
//     try {
//       final response = await ApiService.getSites();
//       if (mounted) {
//         setState(() {
//           sites = response;
//           isLoadingSites = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => isLoadingSites = false);
//         _showError('Failed to load sites');
//       }
//     }
//   }

//   Future<void> _fetchEmployees() async {
//     try {
//       final response = await ApiService.getEmployees();
//       if (mounted) {
//         setState(() {
//           employees = response;
//           isLoadingEmployees = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => isLoadingEmployees = false);
//         _showError('Failed to load employees');
//       }
//     }
//   }

//   Future<void> _fetchSectionsForSite(int siteId) async {
//     setState(() {
//       isLoadingSections = true;
//       selectedSectionIds = [];
//       sectionSearchQuery = '';
//       isSectionDropdownVisible = false;
//     });

//     try {
//       final response = await ApiService.getSectionsBySite(siteId);
//       if (mounted) {
//         setState(() {
//           sections = response;
//           isLoadingSections = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => isLoadingSections = false);
//         _showError('Failed to load sections');
//       }
//     }
//   }

//   Future<void> _selectCheckInDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: designatedCheckIn ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: Colors.black,
//             colorScheme: const ColorScheme.light(primary: Colors.black),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && mounted) {
//       final TimeOfDay? time = await showTimePicker(
//         context: context,
//         initialTime:
//             TimeOfDay.fromDateTime(designatedCheckIn ?? DateTime.now()),
//         builder: (context, child) {
//           return Theme(
//             data: ThemeData.light().copyWith(
//               primaryColor: Colors.black,
//               colorScheme: const ColorScheme.light(primary: Colors.black),
//             ),
//             child: child!,
//           );
//         },
//       );
//       if (time != null && mounted) {
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
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: Colors.black,
//             colorScheme: const ColorScheme.light(primary: Colors.black),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && mounted) {
//       final TimeOfDay? time = await showTimePicker(
//         context: context,
//         initialTime:
//             TimeOfDay.fromDateTime(designatedCheckOut ?? DateTime.now()),
//         builder: (context, child) {
//           return Theme(
//             data: ThemeData.light().copyWith(
//               primaryColor: Colors.black,
//               colorScheme: const ColorScheme.light(primary: Colors.black),
//             ),
//             child: child!,
//           );
//         },
//       );
//       if (time != null && mounted) {
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

//     if (selectedSiteId == null) {
//       _showError("Please select a site");
//       return;
//     }

//     if (selectedSectionIds.isEmpty) {
//       _showError("Please select at least one section");
//       return;
//     }

//     if (selectedApproversIds.length != 2) {
//       _showError("Exactly 2 approvers are required");
//       return;
//     }

//     if (designatedCheckIn == null) {
//       _showError("Please select check-in time");
//       return;
//     }

//     if (designatedCheckOut == null) {
//       _showError("Please select check-out time");
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final Map<String, dynamic> requestBody = {
//         "site_id": selectedSiteId,
//         "full_name": fullNameController.text.trim(),
//         "email": emailController.text.trim(),
//         "phone_number": phoneNumberController.text.trim(),
//         "requested_section_ids": selectedSectionIds,
//         "selected_approvers_ids": selectedApproversIds,
//         "designated_check_in": _formatForAPI(designatedCheckIn),
//         "designated_check_out": _formatForAPI(designatedCheckOut),
//       };

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
//       if (vehicleNumberController.text.trim().isNotEmpty) {
//         requestBody["vehicle_number"] = vehicleNumberController.text.trim();
//       }
//       if (idCardNumberController.text.trim().isNotEmpty) {
//         requestBody["id_card_number"] = idCardNumberController.text.trim();
//       }

//       final response = await ApiService.createVisitor(requestBody);

//       if (mounted) {
//         if (response['visitor'] != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Visitor created successfully!"),
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 2),
//             ),
//           );
//           Navigator.pop(context);
//         } else {
//           _showError(response.toString());
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _showError("Error: $e");
//       }
//     }

//     if (mounted) {
//       setState(() => isLoading = false);
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//   }

//   String get _selectedSiteName {
//     if (selectedSiteId == null) return "Select a site";
//     final site =
//         sites.firstWhere((s) => s['id'] == selectedSiteId, orElse: () => null);
//     return site != null ? site['name'] : "Select a site";
//   }

//   String get _selectedSectionsPreview {
//     if (selectedSectionIds.isEmpty) return "Select sections";
//     if (selectedSectionIds.length == 1) {
//       final section = sections.firstWhere(
//           (s) => s['id'] == selectedSectionIds.first,
//           orElse: () => null);
//       return section != null ? section['name'] : "1 section selected";
//     }
//     return "${selectedSectionIds.length} sections selected";
//   }

//   String get _selectedApproversPreview {
//     if (selectedApproversIds.isEmpty) return "Select 2 approvers";
//     final names = selectedApproversIds.map((id) {
//       final emp =
//           employees.firstWhere((e) => e['id'] == id, orElse: () => null);
//       return emp != null
//           ? emp['full_name']?.split(' ').first ?? 'Unknown'
//           : 'Unknown';
//     }).join(' & ');
//     return "$names • ${selectedApproversIds.length}/2";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Create Visitor",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeaderCard(),
//                   const SizedBox(height: 24),
//                   _buildRequiredFieldsCard(),
//                   const SizedBox(height: 24),
//                   _buildOptionalFieldsCard(),
//                   const SizedBox(height: 32),
//                   MyButton(
//                     buttonText: "Create Visitor",
//                     onTap: isLoading ? null : _createVisitor,
//                   ),
//                   if (isLoading)
//                     const Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderCard() {
//     return Container(
//       padding: const EdgeInsets.all(24),
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
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(Icons.person_add_alt_1,
//                 color: Colors.blue, size: 28),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Visitor Registration",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "Fill in the details to register a new visitor",
//                   style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRequiredFieldsCard() {
//     return Container(
//       padding: const EdgeInsets.all(24),
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.info, size: 16, color: Colors.red),
//               SizedBox(width: 8),
//               Text(
//                 "Required Fields",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Site Selection
//           _buildFormField(
//             label: "Site *",
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isSiteDropdownVisible = !isSiteDropdownVisible;
//                       if (isSiteDropdownVisible) {
//                         isSectionDropdownVisible = false;
//                         isApproverDropdownVisible = false;
//                         siteSearchQuery = '';
//                       }
//                     });
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[50],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey[300]!),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.business, size: 20, color: Colors.grey[600]),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             _selectedSiteName,
//                             style: TextStyle(
//                               color: selectedSiteId == null
//                                   ? Colors.grey[500]
//                                   : Colors.black87,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           isSiteDropdownVisible
//                               ? Icons.expand_less
//                               : Icons.expand_more,
//                           size: 20,
//                           color: Colors.grey[600],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (isSiteDropdownVisible && !isLoadingSites)
//                   Container(
//                     margin: const EdgeInsets.only(top: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey[200]!),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header with close button
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   autofocus: true,
//                                   decoration: InputDecoration(
//                                     hintText: "Search sites...",
//                                     prefixIcon:
//                                         const Icon(Icons.search, size: 18),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide:
//                                           BorderSide(color: Colors.grey[300]!),
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 10),
//                                     isDense: true,
//                                   ),
//                                   onChanged: (query) {
//                                     setState(() => siteSearchQuery = query);
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 icon: const Icon(Icons.close, size: 20),
//                                 onPressed: () {
//                                   setState(() {
//                                     isSiteDropdownVisible = false;
//                                     siteSearchQuery = '';
//                                   });
//                                 },
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 250,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: sites.where((site) {
//                               final name = site['name']?.toLowerCase() ?? '';
//                               final address =
//                                   site['address']?.toLowerCase() ?? '';
//                               final query = siteSearchQuery.toLowerCase();
//                               return name.contains(query) ||
//                                   address.contains(query);
//                             }).length,
//                             itemBuilder: (context, index) {
//                               final filteredSites = sites.where((site) {
//                                 final name = site['name']?.toLowerCase() ?? '';
//                                 final address =
//                                     site['address']?.toLowerCase() ?? '';
//                                 final query = siteSearchQuery.toLowerCase();
//                                 return name.contains(query) ||
//                                     address.contains(query);
//                               }).toList();

//                               if (filteredSites.isEmpty) {
//                                 return const Padding(
//                                   padding: EdgeInsets.all(32),
//                                   child: Center(
//                                     child: Text("No sites found",
//                                         style: TextStyle(color: Colors.grey)),
//                                   ),
//                                 );
//                               }

//                               final site = filteredSites[index];
//                               final isSelected = selectedSiteId == site['id'];

//                               return InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedSiteId = site['id'];
//                                     isSiteDropdownVisible = false;
//                                     siteSearchQuery = '';
//                                     _fetchSectionsForSite(selectedSiteId!);
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 12),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? Colors.blue.withOpacity(0.05)
//                                         : Colors.transparent,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.business,
//                                           size: 18,
//                                           color: isSelected
//                                               ? Colors.blue
//                                               : Colors.grey[500]),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               site['name'] ?? 'Unknown',
//                                               style: TextStyle(
//                                                 fontWeight: isSelected
//                                                     ? FontWeight.w600
//                                                     : FontWeight.normal,
//                                                 color: isSelected
//                                                     ? Colors.blue
//                                                     : Colors.black87,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             if (site['address'] != null &&
//                                                 site['address']
//                                                     .toString()
//                                                     .isNotEmpty)
//                                               Text(
//                                                 site['address'],
//                                                 style: TextStyle(
//                                                     fontSize: 11,
//                                                     color: Colors.grey[500]),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (isSelected)
//                                         Icon(Icons.check_circle,
//                                             size: 16, color: Colors.blue),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 if (isLoadingSites && isSiteDropdownVisible)
//                   const Padding(
//                     padding: EdgeInsets.all(32),
//                     child: Center(
//                       child: SizedBox(
//                         height: 40,
//                         width: 40,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Sections Selection
//           _buildFormField(
//             label: "Sections *",
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: selectedSiteId != null
//                       ? () {
//                           setState(() {
//                             isSectionDropdownVisible =
//                                 !isSectionDropdownVisible;
//                             if (isSectionDropdownVisible) {
//                               isSiteDropdownVisible = false;
//                               isApproverDropdownVisible = false;
//                               sectionSearchQuery = '';
//                             }
//                           });
//                         }
//                       : null,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 14),
//                     decoration: BoxDecoration(
//                       color: selectedSiteId == null
//                           ? Colors.grey[100]
//                           : Colors.grey[50],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: selectedSiteId == null
//                             ? Colors.grey[200]!
//                             : Colors.grey[300]!,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.location_city,
//                             size: 20,
//                             color: selectedSiteId == null
//                                 ? Colors.grey[400]
//                                 : Colors.grey[600]),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             _selectedSectionsPreview,
//                             style: TextStyle(
//                               color: selectedSectionIds.isEmpty
//                                   ? Colors.grey[500]
//                                   : Colors.black87,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         if (selectedSiteId != null)
//                           Icon(
//                             isSectionDropdownVisible
//                                 ? Icons.expand_less
//                                 : Icons.expand_more,
//                             size: 20,
//                             color: Colors.grey[600],
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (selectedSiteId == null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Row(
//                       children: [
//                         Icon(Icons.info_outline,
//                             size: 12, color: Colors.orange),
//                         const SizedBox(width: 4),
//                         Text(
//                           "Please select a site first",
//                           style: TextStyle(
//                               fontSize: 11, color: Colors.orange[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 if (isSectionDropdownVisible &&
//                     selectedSiteId != null &&
//                     !isLoadingSections)
//                   Container(
//                     margin: const EdgeInsets.only(top: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey[200]!),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header with close button
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Search sections...",
//                                     prefixIcon:
//                                         const Icon(Icons.search, size: 18),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide:
//                                           BorderSide(color: Colors.grey[300]!),
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 10),
//                                     isDense: true,
//                                   ),
//                                   onChanged: (query) {
//                                     setState(() => sectionSearchQuery = query);
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 icon: const Icon(Icons.close, size: 20),
//                                 onPressed: () {
//                                   setState(() {
//                                     isSectionDropdownVisible = false;
//                                     sectionSearchQuery = '';
//                                   });
//                                 },
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Selected count and clear all button
//                         if (selectedSectionIds.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 4),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   '${selectedSectionIds.length} section(s) selected',
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.grey[600]),
//                                 ),
//                                 const Spacer(),
//                                 TextButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       selectedSectionIds.clear();
//                                     });
//                                   },
//                                   style: TextButton.styleFrom(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 4),
//                                     minimumSize: Size.zero,
//                                     tapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                   ),
//                                   child: Text(
//                                     'Clear All',
//                                     style: TextStyle(
//                                         fontSize: 12, color: Colors.red[400]),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         SizedBox(
//                           height: 300,
//                           child: ListView.builder(
//                             itemCount: sections.where((section) {
//                               final name = section['name']?.toLowerCase() ?? '';
//                               final code = section['code']?.toLowerCase() ?? '';
//                               final query = sectionSearchQuery.toLowerCase();
//                               return name.contains(query) ||
//                                   code.contains(query);
//                             }).length,
//                             itemBuilder: (context, index) {
//                               final filteredSections =
//                                   sections.where((section) {
//                                 final name =
//                                     section['name']?.toLowerCase() ?? '';
//                                 final code =
//                                     section['code']?.toLowerCase() ?? '';
//                                 final query = sectionSearchQuery.toLowerCase();
//                                 return name.contains(query) ||
//                                     code.contains(query);
//                               }).toList();

//                               if (filteredSections.isEmpty) {
//                                 return const Padding(
//                                   padding: EdgeInsets.all(32),
//                                   child: Center(
//                                     child: Text("No sections found",
//                                         style: TextStyle(color: Colors.grey)),
//                                   ),
//                                 );
//                               }

//                               final section = filteredSections[index];
//                               final isSelected =
//                                   selectedSectionIds.contains(section['id']);

//                               return InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedSectionIds.remove(section['id']);
//                                     } else {
//                                       selectedSectionIds.add(section['id']);
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 12),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? Colors.blue.withOpacity(0.05)
//                                         : Colors.transparent,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Checkbox(
//                                         value: isSelected,
//                                         onChanged: (checked) {
//                                           setState(() {
//                                             if (checked == true) {
//                                               selectedSectionIds
//                                                   .add(section['id']);
//                                             } else {
//                                               selectedSectionIds
//                                                   .remove(section['id']);
//                                             }
//                                           });
//                                         },
//                                         materialTapTargetSize:
//                                             MaterialTapTargetSize.shrinkWrap,
//                                         visualDensity: VisualDensity.compact,
//                                         activeColor: Colors.blue,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               section['name'] ?? 'Unknown',
//                                               style: TextStyle(
//                                                 fontWeight: isSelected
//                                                     ? FontWeight.w600
//                                                     : FontWeight.normal,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   section['code'] ?? '',
//                                                   style: TextStyle(
//                                                       fontSize: 11,
//                                                       color: Colors.grey[500]),
//                                                 ),
//                                                 if (section[
//                                                         'requires_escort'] ==
//                                                     true) ...[
//                                                   const SizedBox(width: 8),
//                                                   Container(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 6,
//                                                         vertical: 2),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.orange
//                                                           .withOpacity(0.1),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               4),
//                                                     ),
//                                                     child: Text(
//                                                       'Escort Required',
//                                                       style: TextStyle(
//                                                           fontSize: 9,
//                                                           color: Colors
//                                                               .orange[700]),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         // Close button at bottom
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Center(
//                             child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isSectionDropdownVisible = false;
//                                   sectionSearchQuery = '';
//                                 });
//                               },
//                               child: const Text('Close'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 if (isLoadingSections && isSectionDropdownVisible)
//                   const Padding(
//                     padding: EdgeInsets.all(32),
//                     child: Center(
//                       child: SizedBox(
//                         height: 40,
//                         width: 40,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Full Name
//           _buildFormField(
//             label: "Full Name *",
//             child: MyTextFieldValidator(
//               controller: fullNameController,
//               hintText: "John Visitor",
//               obscureText: false,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty)
//                   return "Full name is required";
//                 return null;
//               },
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Email
//           _buildFormField(
//             label: "Email *",
//             child: MyTextFieldValidator(
//               controller: emailController,
//               hintText: "john@example.com",
//               obscureText: false,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty)
//                   return "Email is required";
//                 if (!value.contains('@')) return "Enter a valid email";
//                 return null;
//               },
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Phone Number
//           _buildFormField(
//             label: "Phone Number *",
//             child: MyTextFieldValidator(
//               controller: phoneNumberController,
//               hintText: "+1234567890",
//               obscureText: false,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty)
//                   return "Phone number is required";
//                 return null;
//               },
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Designated Check-in
//           _buildFormField(
//             label: "Designated Check-in *",
//             child: GestureDetector(
//               onTap: () => _selectCheckInDate(context),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[300]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.calendar_today,
//                         size: 20, color: Colors.grey[600]),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         _formatDateTime(designatedCheckIn),
//                         style: TextStyle(
//                           color: designatedCheckIn == null
//                               ? Colors.grey[500]
//                               : Colors.black87,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Icon(Icons.arrow_drop_down,
//                         size: 20, color: Colors.grey[600]),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Designated Check-out
//           _buildFormField(
//             label: "Designated Check-out *",
//             child: GestureDetector(
//               onTap: () => _selectCheckOutDate(context),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[300]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.calendar_today,
//                         size: 20, color: Colors.grey[600]),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         _formatDateTime(designatedCheckOut),
//                         style: TextStyle(
//                           color: designatedCheckOut == null
//                               ? Colors.grey[500]
//                               : Colors.black87,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Icon(Icons.arrow_drop_down,
//                         size: 20, color: Colors.grey[600]),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Approvers Selection
//           _buildFormField(
//             label: "Approvers * (Exactly 2)",
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isApproverDropdownVisible = !isApproverDropdownVisible;
//                       if (isApproverDropdownVisible) {
//                         isSiteDropdownVisible = false;
//                         isSectionDropdownVisible = false;
//                         approverSearchQuery = '';
//                       }
//                     });
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[50],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey[300]!),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.verified_user,
//                             size: 20, color: Colors.grey[600]),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             _selectedApproversPreview,
//                             style: TextStyle(
//                               color: selectedApproversIds.isEmpty
//                                   ? Colors.grey[500]
//                                   : Colors.black87,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           isApproverDropdownVisible
//                               ? Icons.expand_less
//                               : Icons.expand_more,
//                           size: 20,
//                           color: Colors.grey[600],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (selectedApproversIds.length == 2)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.green.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.check_circle,
//                               size: 12, color: Colors.green[600]),
//                           const SizedBox(width: 6),
//                           Text(
//                             "2 approvers selected",
//                             style: TextStyle(
//                                 fontSize: 11, color: Colors.green[600]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 if (isApproverDropdownVisible)
//                   Container(
//                     margin: const EdgeInsets.only(top: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey[200]!),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header with close button
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Search employees...",
//                                     prefixIcon:
//                                         const Icon(Icons.search, size: 18),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide:
//                                           BorderSide(color: Colors.grey[300]!),
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 10),
//                                     isDense: true,
//                                   ),
//                                   onChanged: (query) {
//                                     setState(() => approverSearchQuery = query);
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 icon: const Icon(Icons.close, size: 20),
//                                 onPressed: () {
//                                   setState(() {
//                                     isApproverDropdownVisible = false;
//                                     approverSearchQuery = '';
//                                   });
//                                 },
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (isLoadingEmployees)
//                           const Padding(
//                             padding: EdgeInsets.all(32),
//                             child: Center(
//                               child: SizedBox(
//                                 height: 40,
//                                 width: 40,
//                                 child:
//                                     CircularProgressIndicator(strokeWidth: 2),
//                               ),
//                             ),
//                           )
//                         else
//                           SizedBox(
//                             height: 300,
//                             child: ListView.builder(
//                               itemCount: employees.where((emp) {
//                                 final name =
//                                     emp['full_name']?.toLowerCase() ?? '';
//                                 final email = emp['email']?.toLowerCase() ?? '';
//                                 final query = approverSearchQuery.toLowerCase();
//                                 return name.contains(query) ||
//                                     email.contains(query);
//                               }).length,
//                               itemBuilder: (context, index) {
//                                 final filteredEmployees =
//                                     employees.where((emp) {
//                                   final name =
//                                       emp['full_name']?.toLowerCase() ?? '';
//                                   final email =
//                                       emp['email']?.toLowerCase() ?? '';
//                                   final query =
//                                       approverSearchQuery.toLowerCase();
//                                   return name.contains(query) ||
//                                       email.contains(query);
//                                 }).toList();

//                                 if (filteredEmployees.isEmpty) {
//                                   return const Padding(
//                                     padding: EdgeInsets.all(32),
//                                     child: Center(
//                                       child: Text("No employees found",
//                                           style: TextStyle(color: Colors.grey)),
//                                     ),
//                                   );
//                                 }

//                                 final employee = filteredEmployees[index];
//                                 final isSelected = selectedApproversIds
//                                     .contains(employee['id']);
//                                 final isDisabled = !isSelected &&
//                                     selectedApproversIds.length >= 2;

//                                 return Opacity(
//                                   opacity: isDisabled ? 0.5 : 1.0,
//                                   child: InkWell(
//                                     onTap: isDisabled
//                                         ? null
//                                         : () {
//                                             setState(() {
//                                               if (isSelected) {
//                                                 selectedApproversIds
//                                                     .remove(employee['id']);
//                                               } else if (selectedApproversIds
//                                                       .length <
//                                                   2) {
//                                                 selectedApproversIds
//                                                     .add(employee['id']);
//                                               }
//                                             });
//                                           },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16, vertical: 12),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? Colors.blue.withOpacity(0.05)
//                                             : Colors.transparent,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 16,
//                                             backgroundColor: isSelected
//                                                 ? Colors.blue
//                                                 : Colors.grey[200],
//                                             child: Text(
//                                               (employee['full_name']?[0] ?? '?')
//                                                   .toUpperCase(),
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: isSelected
//                                                     ? Colors.white
//                                                     : Colors.grey[600],
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 12),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   employee['full_name'] ??
//                                                       'Unknown',
//                                                   style: TextStyle(
//                                                     fontWeight: isSelected
//                                                         ? FontWeight.w600
//                                                         : FontWeight.normal,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   employee['email'] ?? '',
//                                                   style: TextStyle(
//                                                       fontSize: 11,
//                                                       color: Colors.grey[500]),
//                                                   maxLines: 1,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                                 if (employee['department'] !=
//                                                     null)
//                                                   Text(
//                                                     '${employee['department']} • ${employee['designation'] ?? ''}',
//                                                     style: TextStyle(
//                                                         fontSize: 10,
//                                                         color:
//                                                             Colors.grey[400]),
//                                                   ),
//                                               ],
//                                             ),
//                                           ),
//                                           if (isSelected)
//                                             Icon(Icons.check_circle,
//                                                 size: 16, color: Colors.blue),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         // Close button at bottom
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Center(
//                             child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isApproverDropdownVisible = false;
//                                   approverSearchQuery = '';
//                                 });
//                               },
//                               child: const Text('Close'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildRequiredFieldsCard() {
//   //   return Container(
//   //     padding: const EdgeInsets.all(24),
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(16),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.black.withOpacity(0.03),
//   //           blurRadius: 8,
//   //           offset: const Offset(0, 2),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         const Row(
//   //           children: [
//   //             Icon(Icons.info, size: 16, color: Colors.red),
//   //             SizedBox(width: 8),
//   //             Text(
//   //               "Required Fields",
//   //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//   //             ),
//   //           ],
//   //         ),
//   //         const SizedBox(height: 24),

//   //         // Site Selection
//   //         _buildFormField(
//   //           label: "Site *",
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               GestureDetector(
//   //                 onTap: () {
//   //                   setState(() {
//   //                     isSiteDropdownVisible = !isSiteDropdownVisible;
//   //                     if (isSiteDropdownVisible) {
//   //                       isSectionDropdownVisible = false;
//   //                       isApproverDropdownVisible = false;
//   //                       siteSearchQuery = '';
//   //                     }
//   //                   });
//   //                 },
//   //                 child: Container(
//   //                   padding: const EdgeInsets.symmetric(
//   //                       horizontal: 16, vertical: 14),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.grey[50],
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     border: Border.all(color: Colors.grey[300]!),
//   //                   ),
//   //                   child: Row(
//   //                     children: [
//   //                       Icon(Icons.business, size: 20, color: Colors.grey[600]),
//   //                       const SizedBox(width: 12),
//   //                       Expanded(
//   //                         child: Text(
//   //                           _selectedSiteName,
//   //                           style: TextStyle(
//   //                             color: selectedSiteId == null
//   //                                 ? Colors.grey[500]
//   //                                 : Colors.black87,
//   //                             fontSize: 14,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                       Icon(
//   //                         isSiteDropdownVisible
//   //                             ? Icons.expand_less
//   //                             : Icons.expand_more,
//   //                         size: 20,
//   //                         color: Colors.grey[600],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //               if (isSiteDropdownVisible && !isLoadingSites)
//   //                 Container(
//   //                   margin: const EdgeInsets.only(top: 8),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     border: Border.all(color: Colors.grey[200]!),
//   //                     boxShadow: [
//   //                       BoxShadow(
//   //                         color: Colors.black.withOpacity(0.05),
//   //                         blurRadius: 8,
//   //                         offset: const Offset(0, 2),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Padding(
//   //                         padding: const EdgeInsets.all(12),
//   //                         child: TextField(
//   //                           autofocus: true,
//   //                           decoration: InputDecoration(
//   //                             hintText: "Search sites...",
//   //                             prefixIcon: const Icon(Icons.search, size: 18),
//   //                             border: OutlineInputBorder(
//   //                               borderRadius: BorderRadius.circular(8),
//   //                               borderSide:
//   //                                   BorderSide(color: Colors.grey[300]!),
//   //                             ),
//   //                             contentPadding: const EdgeInsets.symmetric(
//   //                                 horizontal: 12, vertical: 10),
//   //                             isDense: true,
//   //                           ),
//   //                           onChanged: (query) {
//   //                             setState(() => siteSearchQuery = query);
//   //                           },
//   //                         ),
//   //                       ),
//   //                       SizedBox(
//   //                         height: 250,
//   //                         child: ListView.builder(
//   //                           shrinkWrap: true,
//   //                           itemCount: sites.where((site) {
//   //                             final name = site['name']?.toLowerCase() ?? '';
//   //                             final address =
//   //                                 site['address']?.toLowerCase() ?? '';
//   //                             final query = siteSearchQuery.toLowerCase();
//   //                             return name.contains(query) ||
//   //                                 address.contains(query);
//   //                           }).length,
//   //                           itemBuilder: (context, index) {
//   //                             final filteredSites = sites.where((site) {
//   //                               final name = site['name']?.toLowerCase() ?? '';
//   //                               final address =
//   //                                   site['address']?.toLowerCase() ?? '';
//   //                               final query = siteSearchQuery.toLowerCase();
//   //                               return name.contains(query) ||
//   //                                   address.contains(query);
//   //                             }).toList();

//   //                             if (filteredSites.isEmpty) {
//   //                               return const Padding(
//   //                                 padding: EdgeInsets.all(32),
//   //                                 child: Center(
//   //                                   child: Text("No sites found",
//   //                                       style: TextStyle(color: Colors.grey)),
//   //                                 ),
//   //                               );
//   //                             }

//   //                             final site = filteredSites[index];
//   //                             final isSelected = selectedSiteId == site['id'];

//   //                             return InkWell(
//   //                               onTap: () {
//   //                                 setState(() {
//   //                                   selectedSiteId = site['id'];
//   //                                   isSiteDropdownVisible = false;
//   //                                   siteSearchQuery = '';
//   //                                   _fetchSectionsForSite(selectedSiteId!);
//   //                                 });
//   //                               },
//   //                               child: Container(
//   //                                 padding: const EdgeInsets.symmetric(
//   //                                     horizontal: 16, vertical: 12),
//   //                                 decoration: BoxDecoration(
//   //                                   color: isSelected
//   //                                       ? Colors.blue.withOpacity(0.05)
//   //                                       : Colors.transparent,
//   //                                 ),
//   //                                 child: Row(
//   //                                   children: [
//   //                                     Icon(Icons.business,
//   //                                         size: 18,
//   //                                         color: isSelected
//   //                                             ? Colors.blue
//   //                                             : Colors.grey[500]),
//   //                                     const SizedBox(width: 12),
//   //                                     Expanded(
//   //                                       child: Column(
//   //                                         crossAxisAlignment:
//   //                                             CrossAxisAlignment.start,
//   //                                         children: [
//   //                                           Text(
//   //                                             site['name'] ?? 'Unknown',
//   //                                             style: TextStyle(
//   //                                               fontWeight: isSelected
//   //                                                   ? FontWeight.w600
//   //                                                   : FontWeight.normal,
//   //                                               color: isSelected
//   //                                                   ? Colors.blue
//   //                                                   : Colors.black87,
//   //                                               fontSize: 14,
//   //                                             ),
//   //                                           ),
//   //                                           if (site['address'] != null &&
//   //                                               site['address']
//   //                                                   .toString()
//   //                                                   .isNotEmpty)
//   //                                             Text(
//   //                                               site['address'],
//   //                                               style: TextStyle(
//   //                                                   fontSize: 11,
//   //                                                   color: Colors.grey[500]),
//   //                                               maxLines: 1,
//   //                                               overflow: TextOverflow.ellipsis,
//   //                                             ),
//   //                                         ],
//   //                                       ),
//   //                                     ),
//   //                                     if (isSelected)
//   //                                       Icon(Icons.check_circle,
//   //                                           size: 16, color: Colors.blue),
//   //                                   ],
//   //                                 ),
//   //                               ),
//   //                             );
//   //                           },
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               if (isLoadingSites && isSiteDropdownVisible)
//   //                 const Padding(
//   //                   padding: EdgeInsets.all(32),
//   //                   child: Center(
//   //                     child: SizedBox(
//   //                       height: 40,
//   //                       width: 40,
//   //                       child: CircularProgressIndicator(strokeWidth: 2),
//   //                     ),
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Sections Selection
//   //         _buildFormField(
//   //           label: "Sections *",
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               GestureDetector(
//   //                 onTap: selectedSiteId != null
//   //                     ? () {
//   //                         setState(() {
//   //                           isSectionDropdownVisible =
//   //                               !isSectionDropdownVisible;
//   //                           if (isSectionDropdownVisible) {
//   //                             isSiteDropdownVisible = false;
//   //                             isApproverDropdownVisible = false;
//   //                             sectionSearchQuery = '';
//   //                           }
//   //                         });
//   //                       }
//   //                     : null,
//   //                 child: Container(
//   //                   padding: const EdgeInsets.symmetric(
//   //                       horizontal: 16, vertical: 14),
//   //                   decoration: BoxDecoration(
//   //                     color: selectedSiteId == null
//   //                         ? Colors.grey[100]
//   //                         : Colors.grey[50],
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     border: Border.all(
//   //                       color: selectedSiteId == null
//   //                           ? Colors.grey[200]!
//   //                           : Colors.grey[300]!,
//   //                     ),
//   //                   ),
//   //                   child: Row(
//   //                     children: [
//   //                       Icon(Icons.location_city,
//   //                           size: 20,
//   //                           color: selectedSiteId == null
//   //                               ? Colors.grey[400]
//   //                               : Colors.grey[600]),
//   //                       const SizedBox(width: 12),
//   //                       Expanded(
//   //                         child: Text(
//   //                           _selectedSectionsPreview,
//   //                           style: TextStyle(
//   //                             color: selectedSectionIds.isEmpty
//   //                                 ? Colors.grey[500]
//   //                                 : Colors.black87,
//   //                             fontSize: 14,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                       if (selectedSiteId != null)
//   //                         Icon(
//   //                           isSectionDropdownVisible
//   //                               ? Icons.expand_less
//   //                               : Icons.expand_more,
//   //                           size: 20,
//   //                           color: Colors.grey[600],
//   //                         ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //               if (selectedSiteId == null)
//   //                 Padding(
//   //                   padding: const EdgeInsets.only(top: 8),
//   //                   child: Row(
//   //                     children: [
//   //                       Icon(Icons.info_outline,
//   //                           size: 12, color: Colors.orange),
//   //                       const SizedBox(width: 4),
//   //                       Text(
//   //                         "Please select a site first",
//   //                         style: TextStyle(
//   //                             fontSize: 11, color: Colors.orange[600]),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               if (isSectionDropdownVisible &&
//   //                   selectedSiteId != null &&
//   //                   !isLoadingSections)
//   //                 Container(
//   //                   margin: const EdgeInsets.only(top: 8),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     border: Border.all(color: Colors.grey[200]!),
//   //                     boxShadow: [
//   //                       BoxShadow(
//   //                         color: Colors.black.withOpacity(0.05),
//   //                         blurRadius: 8,
//   //                         offset: const Offset(0, 2),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Padding(
//   //                         padding: const EdgeInsets.all(12),
//   //                         child: TextField(
//   //                           decoration: InputDecoration(
//   //                             hintText: "Search sections...",
//   //                             prefixIcon: const Icon(Icons.search, size: 18),
//   //                             border: OutlineInputBorder(
//   //                               borderRadius: BorderRadius.circular(8),
//   //                               borderSide:
//   //                                   BorderSide(color: Colors.grey[300]!),
//   //                             ),
//   //                             contentPadding: const EdgeInsets.symmetric(
//   //                                 horizontal: 12, vertical: 10),
//   //                             isDense: true,
//   //                           ),
//   //                           onChanged: (query) {
//   //                             setState(() => sectionSearchQuery = query);
//   //                           },
//   //                         ),
//   //                       ),
//   //                       SizedBox(
//   //                         height: 300,
//   //                         child: ListView.builder(
//   //                           itemCount: sections.where((section) {
//   //                             final name = section['name']?.toLowerCase() ?? '';
//   //                             final code = section['code']?.toLowerCase() ?? '';
//   //                             final query = sectionSearchQuery.toLowerCase();
//   //                             return name.contains(query) ||
//   //                                 code.contains(query);
//   //                           }).length,
//   //                           itemBuilder: (context, index) {
//   //                             final filteredSections =
//   //                                 sections.where((section) {
//   //                               final name =
//   //                                   section['name']?.toLowerCase() ?? '';
//   //                               final code =
//   //                                   section['code']?.toLowerCase() ?? '';
//   //                               final query = sectionSearchQuery.toLowerCase();
//   //                               return name.contains(query) ||
//   //                                   code.contains(query);
//   //                             }).toList();

//   //                             if (filteredSections.isEmpty) {
//   //                               return const Padding(
//   //                                 padding: EdgeInsets.all(32),
//   //                                 child: Center(
//   //                                   child: Text("No sections found",
//   //                                       style: TextStyle(color: Colors.grey)),
//   //                                 ),
//   //                               );
//   //                             }

//   //                             final section = filteredSections[index];
//   //                             final isSelected =
//   //                                 selectedSectionIds.contains(section['id']);

//   //                             return InkWell(
//   //                               onTap: () {
//   //                                 setState(() {
//   //                                   if (isSelected) {
//   //                                     selectedSectionIds.remove(section['id']);
//   //                                   } else {
//   //                                     selectedSectionIds.add(section['id']);
//   //                                   }
//   //                                 });
//   //                               },
//   //                               child: Container(
//   //                                 padding: const EdgeInsets.symmetric(
//   //                                     horizontal: 16, vertical: 12),
//   //                                 decoration: BoxDecoration(
//   //                                   color: isSelected
//   //                                       ? Colors.blue.withOpacity(0.05)
//   //                                       : Colors.transparent,
//   //                                 ),
//   //                                 child: Row(
//   //                                   children: [
//   //                                     Checkbox(
//   //                                       value: isSelected,
//   //                                       onChanged: (checked) {
//   //                                         setState(() {
//   //                                           if (checked == true) {
//   //                                             selectedSectionIds
//   //                                                 .add(section['id']);
//   //                                           } else {
//   //                                             selectedSectionIds
//   //                                                 .remove(section['id']);
//   //                                           }
//   //                                         });
//   //                                       },
//   //                                       materialTapTargetSize:
//   //                                           MaterialTapTargetSize.shrinkWrap,
//   //                                       visualDensity: VisualDensity.compact,
//   //                                       activeColor: Colors.blue,
//   //                                     ),
//   //                                     const SizedBox(width: 4),
//   //                                     Expanded(
//   //                                       child: Column(
//   //                                         crossAxisAlignment:
//   //                                             CrossAxisAlignment.start,
//   //                                         children: [
//   //                                           Text(
//   //                                             section['name'] ?? 'Unknown',
//   //                                             style: TextStyle(
//   //                                               fontWeight: isSelected
//   //                                                   ? FontWeight.w600
//   //                                                   : FontWeight.normal,
//   //                                               fontSize: 14,
//   //                                             ),
//   //                                           ),
//   //                                           Row(
//   //                                             children: [
//   //                                               Text(
//   //                                                 section['code'] ?? '',
//   //                                                 style: TextStyle(
//   //                                                     fontSize: 11,
//   //                                                     color: Colors.grey[500]),
//   //                                               ),
//   //                                               if (section[
//   //                                                       'requires_escort'] ==
//   //                                                   true) ...[
//   //                                                 const SizedBox(width: 8),
//   //                                                 Container(
//   //                                                   padding: const EdgeInsets
//   //                                                       .symmetric(
//   //                                                       horizontal: 6,
//   //                                                       vertical: 2),
//   //                                                   decoration: BoxDecoration(
//   //                                                     color: Colors.orange
//   //                                                         .withOpacity(0.1),
//   //                                                     borderRadius:
//   //                                                         BorderRadius.circular(
//   //                                                             4),
//   //                                                   ),
//   //                                                   child: Text(
//   //                                                     'Escort Required',
//   //                                                     style: TextStyle(
//   //                                                         fontSize: 9,
//   //                                                         color: Colors
//   //                                                             .orange[700]),
//   //                                                   ),
//   //                                                 ),
//   //                                               ],
//   //                                             ],
//   //                                           ),
//   //                                         ],
//   //                                       ),
//   //                                     ),
//   //                                   ],
//   //                                 ),
//   //                               ),
//   //                             );
//   //                           },
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               if (isLoadingSections && isSectionDropdownVisible)
//   //                 const Padding(
//   //                   padding: EdgeInsets.all(32),
//   //                   child: Center(
//   //                     child: SizedBox(
//   //                       height: 40,
//   //                       width: 40,
//   //                       child: CircularProgressIndicator(strokeWidth: 2),
//   //                     ),
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Full Name
//   //         _buildFormField(
//   //           label: "Full Name *",
//   //           child: MyTextFieldValidator(
//   //             controller: fullNameController,
//   //             hintText: "John Visitor",
//   //             obscureText: false,
//   //             validator: (value) {
//   //               if (value == null || value.trim().isEmpty)
//   //                 return "Full name is required";
//   //               return null;
//   //             },
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Email
//   //         _buildFormField(
//   //           label: "Email *",
//   //           child: MyTextFieldValidator(
//   //             controller: emailController,
//   //             hintText: "john@example.com",
//   //             obscureText: false,
//   //             validator: (value) {
//   //               if (value == null || value.trim().isEmpty)
//   //                 return "Email is required";
//   //               if (!value.contains('@')) return "Enter a valid email";
//   //               return null;
//   //             },
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Phone Number
//   //         _buildFormField(
//   //           label: "Phone Number *",
//   //           child: MyTextFieldValidator(
//   //             controller: phoneNumberController,
//   //             hintText: "+1234567890",
//   //             obscureText: false,
//   //             validator: (value) {
//   //               if (value == null || value.trim().isEmpty)
//   //                 return "Phone number is required";
//   //               return null;
//   //             },
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Designated Check-in
//   //         _buildFormField(
//   //           label: "Designated Check-in *",
//   //           child: GestureDetector(
//   //             onTap: () => _selectCheckInDate(context),
//   //             child: Container(
//   //               padding:
//   //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//   //               decoration: BoxDecoration(
//   //                 color: Colors.grey[50],
//   //                 borderRadius: BorderRadius.circular(12),
//   //                 border: Border.all(color: Colors.grey[300]!),
//   //               ),
//   //               child: Row(
//   //                 children: [
//   //                   Icon(Icons.calendar_today,
//   //                       size: 20, color: Colors.grey[600]),
//   //                   const SizedBox(width: 12),
//   //                   Expanded(
//   //                     child: Text(
//   //                       _formatDateTime(designatedCheckIn),
//   //                       style: TextStyle(
//   //                         color: designatedCheckIn == null
//   //                             ? Colors.grey[500]
//   //                             : Colors.black87,
//   //                         fontSize: 14,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   Icon(Icons.arrow_drop_down,
//   //                       size: 20, color: Colors.grey[600]),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Designated Check-out
//   //         _buildFormField(
//   //           label: "Designated Check-out *",
//   //           child: GestureDetector(
//   //             onTap: () => _selectCheckOutDate(context),
//   //             child: Container(
//   //               padding:
//   //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//   //               decoration: BoxDecoration(
//   //                 color: Colors.grey[50],
//   //                 borderRadius: BorderRadius.circular(12),
//   //                 border: Border.all(color: Colors.grey[300]!),
//   //               ),
//   //               child: Row(
//   //                 children: [
//   //                   Icon(Icons.calendar_today,
//   //                       size: 20, color: Colors.grey[600]),
//   //                   const SizedBox(width: 12),
//   //                   Expanded(
//   //                     child: Text(
//   //                       _formatDateTime(designatedCheckOut),
//   //                       style: TextStyle(
//   //                         color: designatedCheckOut == null
//   //                             ? Colors.grey[500]
//   //                             : Colors.black87,
//   //                         fontSize: 14,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   Icon(Icons.arrow_drop_down,
//   //                       size: 20, color: Colors.grey[600]),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),

//   //         // Approvers Selection
//   //         _buildFormField(
//   //           label: "Approvers * (Exactly 2)",
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               GestureDetector(
//   //                 onTap: () {
//   //                   setState(() {
//   //                     isApproverDropdownVisible = !isApproverDropdownVisible;
//   //                     if (isApproverDropdownVisible) {
//   //                       isSiteDropdownVisible = false;
//   //                       isSectionDropdownVisible = false;
//   //                       approverSearchQuery = '';
//   //                     }
//   //                   });
//   //                 },
//   //                 child: Container(
//   //                   padding: const EdgeInsets.symmetric(
//   //                       horizontal: 16, vertical: 14),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.grey[50],
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     border: Border.all(color: Colors.grey[300]!),
//   //                   ),
//   //                   child: Row(
//   //                     children: [
//   //                       Icon(Icons.verified_user,
//   //                           size: 20, color: Colors.grey[600]),
//   //                       const SizedBox(width: 12),
//   //                       Expanded(
//   //                         child: Text(
//   //                           _selectedApproversPreview,
//   //                           style: TextStyle(
//   //                             color: selectedApproversIds.isEmpty
//   //                                 ? Colors.grey[500]
//   //                                 : Colors.black87,
//   //                             fontSize: 14,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                       Icon(
//   //                         isApproverDropdownVisible
//   //                             ? Icons.expand_less
//   //                             : Icons.expand_more,
//   //                         size: 20,
//   //                         color: Colors.grey[600],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //               if (selectedApproversIds.length == 2)
//   //                 Padding(
//   //                   padding: const EdgeInsets.only(top: 8),
//   //                   child: Container(
//   //                     padding: const EdgeInsets.symmetric(
//   //                         horizontal: 10, vertical: 6),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.green.withOpacity(0.1),
//   //                       borderRadius: BorderRadius.circular(6),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Icon(Icons.check_circle,
//   //                             size: 12, color: Colors.green[600]),
//   //                         const SizedBox(width: 6),
//   //                         Text(
//   //                           "2 approvers selected",
//   //                           style: TextStyle(
//   //                               fontSize: 11, color: Colors.green[600]),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               if (isApproverDropdownVisible)
//   //                 Container(
//   //                   margin: const EdgeInsets.only(top: 8),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     border: Border.all(color: Colors.grey[200]!),
//   //                     boxShadow: [
//   //                       BoxShadow(
//   //                         color: Colors.black.withOpacity(0.05),
//   //                         blurRadius: 8,
//   //                         offset: const Offset(0, 2),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Padding(
//   //                         padding: const EdgeInsets.all(12),
//   //                         child: TextField(
//   //                           decoration: InputDecoration(
//   //                             hintText: "Search employees...",
//   //                             prefixIcon: const Icon(Icons.search, size: 18),
//   //                             border: OutlineInputBorder(
//   //                               borderRadius: BorderRadius.circular(8),
//   //                               borderSide:
//   //                                   BorderSide(color: Colors.grey[300]!),
//   //                             ),
//   //                             contentPadding: const EdgeInsets.symmetric(
//   //                                 horizontal: 12, vertical: 10),
//   //                             isDense: true,
//   //                           ),
//   //                           onChanged: (query) {
//   //                             setState(() => approverSearchQuery = query);
//   //                           },
//   //                         ),
//   //                       ),
//   //                       if (isLoadingEmployees)
//   //                         const Padding(
//   //                           padding: EdgeInsets.all(32),
//   //                           child: Center(
//   //                             child: SizedBox(
//   //                               height: 40,
//   //                               width: 40,
//   //                               child:
//   //                                   CircularProgressIndicator(strokeWidth: 2),
//   //                             ),
//   //                           ),
//   //                         )
//   //                       else
//   //                         SizedBox(
//   //                           height: 300,
//   //                           child: ListView.builder(
//   //                             itemCount: employees.where((emp) {
//   //                               final name =
//   //                                   emp['full_name']?.toLowerCase() ?? '';
//   //                               final email = emp['email']?.toLowerCase() ?? '';
//   //                               final query = approverSearchQuery.toLowerCase();
//   //                               return name.contains(query) ||
//   //                                   email.contains(query);
//   //                             }).length,
//   //                             itemBuilder: (context, index) {
//   //                               final filteredEmployees =
//   //                                   employees.where((emp) {
//   //                                 final name =
//   //                                     emp['full_name']?.toLowerCase() ?? '';
//   //                                 final email =
//   //                                     emp['email']?.toLowerCase() ?? '';
//   //                                 final query =
//   //                                     approverSearchQuery.toLowerCase();
//   //                                 return name.contains(query) ||
//   //                                     email.contains(query);
//   //                               }).toList();

//   //                               if (filteredEmployees.isEmpty) {
//   //                                 return const Padding(
//   //                                   padding: EdgeInsets.all(32),
//   //                                   child: Center(
//   //                                     child: Text("No employees found",
//   //                                         style: TextStyle(color: Colors.grey)),
//   //                                   ),
//   //                                 );
//   //                               }

//   //                               final employee = filteredEmployees[index];
//   //                               final isSelected = selectedApproversIds
//   //                                   .contains(employee['id']);
//   //                               final isDisabled = !isSelected &&
//   //                                   selectedApproversIds.length >= 2;

//   //                               return Opacity(
//   //                                 opacity: isDisabled ? 0.5 : 1.0,
//   //                                 child: InkWell(
//   //                                   onTap: isDisabled
//   //                                       ? null
//   //                                       : () {
//   //                                           setState(() {
//   //                                             if (isSelected) {
//   //                                               selectedApproversIds
//   //                                                   .remove(employee['id']);
//   //                                             } else if (selectedApproversIds
//   //                                                     .length <
//   //                                                 2) {
//   //                                               selectedApproversIds
//   //                                                   .add(employee['id']);
//   //                                             }
//   //                                           });
//   //                                         },
//   //                                   child: Container(
//   //                                     padding: const EdgeInsets.symmetric(
//   //                                         horizontal: 16, vertical: 12),
//   //                                     decoration: BoxDecoration(
//   //                                       color: isSelected
//   //                                           ? Colors.blue.withOpacity(0.05)
//   //                                           : Colors.transparent,
//   //                                     ),
//   //                                     child: Row(
//   //                                       children: [
//   //                                         CircleAvatar(
//   //                                           radius: 16,
//   //                                           backgroundColor: isSelected
//   //                                               ? Colors.blue
//   //                                               : Colors.grey[200],
//   //                                           child: Text(
//   //                                             (employee['full_name']?[0] ?? '?')
//   //                                                 .toUpperCase(),
//   //                                             style: TextStyle(
//   //                                               fontSize: 12,
//   //                                               fontWeight: FontWeight.bold,
//   //                                               color: isSelected
//   //                                                   ? Colors.white
//   //                                                   : Colors.grey[600],
//   //                                             ),
//   //                                           ),
//   //                                         ),
//   //                                         const SizedBox(width: 12),
//   //                                         Expanded(
//   //                                           child: Column(
//   //                                             crossAxisAlignment:
//   //                                                 CrossAxisAlignment.start,
//   //                                             children: [
//   //                                               Text(
//   //                                                 employee['full_name'] ??
//   //                                                     'Unknown',
//   //                                                 style: TextStyle(
//   //                                                   fontWeight: isSelected
//   //                                                       ? FontWeight.w600
//   //                                                       : FontWeight.normal,
//   //                                                   fontSize: 14,
//   //                                                 ),
//   //                                               ),
//   //                                               Text(
//   //                                                 employee['email'] ?? '',
//   //                                                 style: TextStyle(
//   //                                                     fontSize: 11,
//   //                                                     color: Colors.grey[500]),
//   //                                                 maxLines: 1,
//   //                                                 overflow:
//   //                                                     TextOverflow.ellipsis,
//   //                                               ),
//   //                                               if (employee['department'] !=
//   //                                                   null)
//   //                                                 Text(
//   //                                                   '${employee['department']} • ${employee['designation'] ?? ''}',
//   //                                                   style: TextStyle(
//   //                                                       fontSize: 10,
//   //                                                       color:
//   //                                                           Colors.grey[400]),
//   //                                                 ),
//   //                                             ],
//   //                                           ),
//   //                                         ),
//   //                                         if (isSelected)
//   //                                           Icon(Icons.check_circle,
//   //                                               size: 16, color: Colors.blue),
//   //                                       ],
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               );
//   //                             },
//   //                           ),
//   //                         ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget _buildOptionalFieldsCard() {
//     return Container(
//       padding: const EdgeInsets.all(24),
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.info_outline, size: 16, color: Colors.grey),
//               SizedBox(width: 8),
//               Text(
//                 "Optional Fields",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           _buildFormField(
//             label: "Company Name",
//             child: MyTextField(
//               controller: companyNameController,
//               hintText: "Tech Solutions Inc.",
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildFormField(
//             label: "Purpose of Visit",
//             child: MyTextField(
//               controller: purposeOfVisitController,
//               hintText: "Meeting with IT department",
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildFormField(
//             label: "Host Department",
//             child: MyTextField(
//               controller: hostDepartmentController,
//               hintText: "IT Department",
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildFormField(
//             label: "Meeting Room",
//             child: MyTextField(
//               controller: meetingRoomController,
//               hintText: "Conference Room A",
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildFormField(
//             label: "Vehicle Number",
//             child: MyTextField(
//               controller: vehicleNumberController,
//               hintText: "KA01AB1234",
//               obscureText: false,
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildFormField(
//             label: "ID Card Number",
//             child: MyTextField(
//               controller: idCardNumberController,
//               hintText: "ID123456",
//               obscureText: false,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormField({
//     required String label,
//     required Widget child,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 4, bottom: 8),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[700],
//             ),
//           ),
//         ),
//         child,
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/services/api_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io' show Platform;

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
        // Read the file as bytes for web compatibility
        final bytes = await pickedFile.readAsBytes();

        // Generate a safe filename (works on both mobile and web)
        // Don't use pickedFile.name on web - it's not supported
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

  // Update the _pickImage method
  // Future<void> _pickImage(ImageSource source) async {
  //   try {
  //     XFile? pickedFile;

  //     pickedFile = await _imagePicker.pickImage(
  //       source: source,
  //       maxWidth: 1024,
  //       maxHeight: 1024,
  //       imageQuality: 80,
  //     );

  //     if (pickedFile != null && mounted) {
  //       // Read the file as bytes for web compatibility
  //       final bytes = await pickedFile.readAsBytes();

  //       // Get file name - handle null case for web
  //       String fileName = 'photo.jpg';
  //       try {
  //         // For mobile, name is available
  //         if (pickedFile.name != null && pickedFile.name.isNotEmpty) {
  //           fileName = pickedFile.name;
  //         }
  //       } catch (e) {
  //         // For web, name might not be available, use default
  //         fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //       }

  //       setState(() {
  //         selectedImageBytes = bytes;
  //         selectedImageName = fileName;
  //         usePhotoUrl = false;
  //         photoUrl = null;
  //         photoUrlController.clear();
  //       });
  //     }
  //   } catch (e) {
  //     _showError('Error picking image: $e');
  //   }
  // }

  // Future<void> _pickImage(ImageSource source) async {
  //   try {
  //     XFile? pickedFile;

  //     if (source == ImageSource.camera) {
  //       pickedFile = await _imagePicker.pickImage(
  //         source: source,
  //         maxWidth: 1024,
  //         maxHeight: 1024,
  //         imageQuality: 80,
  //       );
  //     } else {
  //       pickedFile = await _imagePicker.pickImage(
  //         source: source,
  //         maxWidth: 1024,
  //         maxHeight: 1024,
  //         imageQuality: 80,
  //       );
  //     }

  //     if (pickedFile != null && mounted) {
  //       // Read the file as bytes for web compatibility
  //       final bytes = await pickedFile.readAsBytes();
  //       setState(() {
  //         selectedImageBytes = bytes;
  //         selectedImageName = pickedFile.name;
  //         usePhotoUrl = false;
  //         photoUrl = null;
  //         photoUrlController.clear();
  //       });
  //     }
  //   } catch (e) {
  //     _showError('Error picking image: $e');
  //   }
  // }

  void _showImagePickerDialog() {
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
        "requested_section_ids": selectedSectionIds, // This is a List<int>
        "selected_approvers_ids": selectedApproversIds, // This is a List<int>
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

      // Debug: Print the request body before sending
      print('Request body before sending:');
      print(
          '  selected_section_ids: ${requestBody["requested_section_ids"]} (type: ${requestBody["requested_section_ids"].runtimeType})');
      print(
          '  selected_approvers_ids: ${requestBody["selected_approvers_ids"]} (type: ${requestBody["selected_approvers_ids"].runtimeType})');
      print(
          '  Number of approvers: ${requestBody["selected_approvers_ids"].length}');

      Map<String, dynamic> response;

      // Check if we have a photo file or URL
      if (selectedImageBytes != null) {
        // Use multipart request for file upload
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

  // String get _selectedApproversPreview {
  //   if (selectedApproversIds.isEmpty) return "Select 2 approvers";
  //   final names = selectedApproversIds.map((id) {
  //     final emp =
  //         employees.firstWhere((e) => e['id'] == id, orElse: () => null);
  //     return emp != null
  //         ? emp['full_name']?.split(' ').first ?? 'Unknown'
  //         : 'Unknown';
  //   }).join(' & ');
  //   return "$names • ${selectedApproversIds.length}/2";
  // }

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

  // Widget _buildPhotoSection() {
  //   return Container(
  //     padding: const EdgeInsets.all(24),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.03),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Row(
  //           children: [
  //             Icon(Icons.photo_camera, size: 16, color: Colors.purple),
  //             SizedBox(width: 8),
  //             Text(
  //               "Visitor Photo (Optional)",
  //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),

  //         // Photo preview
  //         Container(
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             color: Colors.grey[50],
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: Colors.grey[300]!),
  //           ),
  //           child: Column(
  //             children: [
  //               // Preview area
  //               Container(
  //                 height: 150,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: selectedImageBytes != null
  //                     ? ClipRRect(
  //                         borderRadius: BorderRadius.circular(12),
  //                         child: Image.memory(
  //                           selectedImageBytes!,
  //                           width: double.infinity,
  //                           height: 150,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       )
  //                     : photoUrl != null && photoUrl!.isNotEmpty
  //                         ? ClipRRect(
  //                             borderRadius: BorderRadius.circular(12),
  //                             child: Image.network(
  //                               photoUrl!,
  //                               width: double.infinity,
  //                               height: 150,
  //                               fit: BoxFit.cover,
  //                               errorBuilder: (context, error, stackTrace) {
  //                                 return Container(
  //                                   width: double.infinity,
  //                                   height: 150,
  //                                   color: Colors.grey[200],
  //                                   child: const Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       Icon(Icons.broken_image,
  //                                           size: 48, color: Colors.grey),
  //                                       SizedBox(height: 8),
  //                                       Text(
  //                                         'Failed to load image',
  //                                         style: TextStyle(color: Colors.grey),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           )
  //                         : Container(
  //                             width: double.infinity,
  //                             height: 150,
  //                             color: Colors.grey[100],
  //                             child: const Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Icon(Icons.photo_camera,
  //                                     size: 48, color: Colors.grey),
  //                                 SizedBox(height: 8),
  //                                 Text(
  //                                   'No photo selected',
  //                                   style: TextStyle(color: Colors.grey),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //               ),

  //               // Action buttons
  //               Padding(
  //                 padding: const EdgeInsets.all(12),
  //                 child: Row(
  //                   children: [
  //                     Expanded(
  //                       child: OutlinedButton.icon(
  //                         onPressed: _showImagePickerDialog,
  //                         icon: const Icon(Icons.add_photo_alternate, size: 18),
  //                         label: const Text('Add Photo'),
  //                         style: OutlinedButton.styleFrom(
  //                           padding: const EdgeInsets.symmetric(vertical: 10),
  //                           side: BorderSide(color: Colors.purple.shade300),
  //                           foregroundColor: Colors.purple,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 12),
  //                     if (selectedImageBytes != null ||
  //                         (photoUrl != null && photoUrl!.isNotEmpty))
  //                       Expanded(
  //                         child: OutlinedButton.icon(
  //                           onPressed: _removePhoto,
  //                           icon: const Icon(Icons.delete_outline, size: 18),
  //                           label: const Text('Remove'),
  //                           style: OutlinedButton.styleFrom(
  //                             padding: const EdgeInsets.symmetric(vertical: 10),
  //                             side: BorderSide(color: Colors.red.shade300),
  //                             foregroundColor: Colors.red,
  //                           ),
  //                         ),
  //                       ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),

  //         // Info text
  //         if (selectedImageBytes == null &&
  //             (photoUrl == null || photoUrl!.isEmpty))
  //           Padding(
  //             padding: const EdgeInsets.only(top: 8),
  //             child: Row(
  //               children: [
  //                 Icon(Icons.info_outline, size: 12, color: Colors.grey[500]),
  //                 const SizedBox(width: 4),
  //                 Expanded(
  //                   child: Text(
  //                     'You can upload an image from gallery, take a photo, or provide an image URL',
  //                     style: TextStyle(fontSize: 11, color: Colors.grey[500]),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

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

  // Widget _buildApproverDropdown() {
  //   final filteredEmployees = employees.where((emp) {
  //     final name = emp['full_name']?.toLowerCase() ?? '';
  //     final email = emp['email']?.toLowerCase() ?? '';
  //     final query = approverSearchQuery.toLowerCase();
  //     return name.contains(query) || email.contains(query);
  //   }).toList();

  //   return Container(
  //     margin: const EdgeInsets.only(top: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey[200]!),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextField(
  //                   decoration: InputDecoration(
  //                     hintText: "Search employees...",
  //                     prefixIcon: const Icon(Icons.search, size: 18),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                       borderSide: BorderSide(color: Colors.grey[300]!),
  //                     ),
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         horizontal: 12, vertical: 10),
  //                     isDense: true,
  //                   ),
  //                   onChanged: (query) {
  //                     setState(() => approverSearchQuery = query);
  //                   },
  //                 ),
  //               ),
  //               const SizedBox(width: 8),
  //               IconButton(
  //                 icon: const Icon(Icons.close, size: 20),
  //                 onPressed: () {
  //                   setState(() {
  //                     isApproverDropdownVisible = false;
  //                     approverSearchQuery = '';
  //                   });
  //                 },
  //                 padding: EdgeInsets.zero,
  //                 constraints: const BoxConstraints(),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 300,
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: filteredEmployees.length,
  //             itemBuilder: (context, index) {
  //               final employee = filteredEmployees[index];
  //               final isSelected =
  //                   selectedApproversIds.contains(employee['id']);
  //               final isDisabled =
  //                   !isSelected && selectedApproversIds.length >= 2;

  //               return Opacity(
  //                 opacity: isDisabled ? 0.5 : 1.0,
  //                 child: InkWell(
  //                   onTap: isDisabled
  //                       ? null
  //                       : () {
  //                           setState(() {
  //                             if (isSelected) {
  //                               selectedApproversIds.remove(employee['id']);
  //                             } else if (selectedApproversIds.length < 2) {
  //                               selectedApproversIds.add(employee['id']);
  //                             }
  //                           });
  //                         },
  //                   child: Container(
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 16, vertical: 12),
  //                     decoration: BoxDecoration(
  //                       color: isSelected
  //                           ? Colors.blue.withOpacity(0.05)
  //                           : Colors.transparent,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 16,
  //                           backgroundColor:
  //                               isSelected ? Colors.blue : Colors.grey[200],
  //                           child: Text(
  //                             (employee['full_name']?[0] ?? '?').toUpperCase(),
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.bold,
  //                               color: isSelected
  //                                   ? Colors.white
  //                                   : Colors.grey[600],
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(width: 12),
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 employee['full_name'] ?? 'Unknown',
  //                                 style: TextStyle(
  //                                   fontWeight: isSelected
  //                                       ? FontWeight.w600
  //                                       : FontWeight.normal,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                               Text(
  //                                 employee['email'] ?? '',
  //                                 style: TextStyle(
  //                                     fontSize: 11, color: Colors.grey[500]),
  //                                 maxLines: 1,
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                               if (employee['department'] != null)
  //                                 Text(
  //                                   '${employee['department']} • ${employee['designation'] ?? ''}',
  //                                   style: TextStyle(
  //                                       fontSize: 10, color: Colors.grey[400]),
  //                                 ),
  //                             ],
  //                           ),
  //                         ),
  //                         if (isSelected)
  //                           Icon(Icons.check_circle,
  //                               size: 16, color: Colors.blue),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: TextButton(
  //               onPressed: () {
  //                 setState(() {
  //                   isApproverDropdownVisible = false;
  //                   approverSearchQuery = '';
  //                 });
  //               },
  //               child: const Text('Close'),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Purpose of Visit",
            child: MyTextField(
              controller: purposeOfVisitController,
              hintText: "Meeting with IT department",
              obscureText: false,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Host Department",
            child: MyTextField(
              controller: hostDepartmentController,
              hintText: "IT Department",
              obscureText: false,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Meeting Room",
            child: MyTextField(
              controller: meetingRoomController,
              hintText: "Conference Room A",
              obscureText: false,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "Vehicle Number",
            child: MyTextField(
              controller: vehicleNumberController,
              hintText: "KA01AB1234",
              obscureText: false,
            ),
          ),
          const SizedBox(height: 20),
          _buildFormField(
            label: "ID Card Number",
            child: MyTextField(
              controller: idCardNumberController,
              hintText: "ID123456",
              obscureText: false,
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

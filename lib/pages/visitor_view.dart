// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class VisitorViewPage extends StatefulWidget {
//   final Map<String, dynamic> visitorData;

//   const VisitorViewPage({super.key, required this.visitorData});

//   @override
//   State<VisitorViewPage> createState() => _VisitorViewPageState();
// }

// class _VisitorViewPageState extends State<VisitorViewPage> {
//   bool _isSectionDetailsExpanded = false;
//   Map<int, bool> _expandedSections = {};

//   @override
//   void initState() {
//     super.initState();
//     List<dynamic> sections =
//         widget.visitorData['section_approval_summary'] ?? [];
//     for (int i = 0; i < sections.length; i++) {
//       _expandedSections[i] = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Visitor Details",
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Status Card
//             _buildStatusCard(),
//             const SizedBox(height: 20),

//             // Visitor Information Card
//             _buildInfoCard(),
//             const SizedBox(height: 20),

//             // Visit Details Card
//             _buildVisitDetailsCard(),
//             const SizedBox(height: 20),

//             // Section Approval Summary Card (Collapsible)
//             _buildSectionApprovalSummaryCard(),
//             const SizedBox(height: 20),

//             // Employee Approvers Card
//             _buildEmployeeApproversCard(),
//             const SizedBox(height: 20),

//             // Visitor Approvals Card (from visitor_approvals)
//             _buildVisitorApprovalsCard(),
//             const SizedBox(height: 20),

//             // Section Requests Card
//             _buildSectionRequestsCard(),
//             const SizedBox(height: 20),

//             // Created By Card
//             _buildCreatedByCard(),
//             const SizedBox(height: 20),

//             // Timeline Card
//             _buildTimelineCard(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusCard() {
//     String status = widget.visitorData['status'] ?? 'pending';
//     Color statusColor = _getStatusColor(status);
//     IconData statusIcon = _getStatusIcon(status);

//     return Container(
//       padding: const EdgeInsets.all(16),
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
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(statusIcon, color: statusColor, size: 28),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Visit Status",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   status.toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: statusColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               status,
//               style: TextStyle(
//                 color: statusColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.person_outline, size: 20, color: Colors.blue),
//               SizedBox(width: 8),
//               Text(
//                 "Visitor Information",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           _buildInfoRow(
//             icon: Icons.person,
//             label: "Full Name",
//             value: widget.visitorData['full_name'] ?? 'N/A',
//           ),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//             icon: Icons.email,
//             label: "Email",
//             value: widget.visitorData['email'] ?? 'N/A',
//           ),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//             icon: Icons.phone,
//             label: "Phone Number",
//             value: widget.visitorData['phone_number'] ?? 'N/A',
//           ),
//           if (widget.visitorData['company_name'] != null &&
//               widget.visitorData['company_name'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.business,
//               label: "Company",
//               value: widget.visitorData['company_name'],
//             ),
//           ],
//           if (widget.visitorData['vehicle_number'] != null &&
//               widget.visitorData['vehicle_number'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.directions_car,
//               label: "Vehicle Number",
//               value: widget.visitorData['vehicle_number'],
//             ),
//           ],
//           if (widget.visitorData['id_card_number'] != null &&
//               widget.visitorData['id_card_number'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.badge,
//               label: "ID Card Number",
//               value: widget.visitorData['id_card_number'],
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildVisitDetailsCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.calendar_today, size: 20, color: Colors.orange),
//               SizedBox(width: 8),
//               Text(
//                 "Visit Details",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           _buildInfoRow(
//             icon: Icons.login,
//             label: "Designated Check-in",
//             value: _formatDateTime(widget.visitorData['designated_check_in']),
//           ),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//             icon: Icons.logout,
//             label: "Designated Check-out",
//             value: _formatDateTime(widget.visitorData['designated_check_out']),
//           ),
//           if (widget.visitorData['purpose_of_visit'] != null &&
//               widget.visitorData['purpose_of_visit'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.info_outline,
//               label: "Purpose",
//               value: widget.visitorData['purpose_of_visit'],
//             ),
//           ],
//           if (widget.visitorData['host_department'] != null &&
//               widget.visitorData['host_department'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.business_center,
//               label: "Host Department",
//               value: widget.visitorData['host_department'],
//             ),
//           ],
//           if (widget.visitorData['meeting_room'] != null &&
//               widget.visitorData['meeting_room'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.meeting_room,
//               label: "Meeting Room",
//               value: widget.visitorData['meeting_room'],
//             ),
//           ],
//           if (widget.visitorData['actual_check_in'] != null) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.check_circle,
//               label: "Actual Check-in",
//               value: _formatDateTime(widget.visitorData['actual_check_in']),
//               valueColor: Colors.green,
//             ),
//           ],
//           if (widget.visitorData['actual_check_out'] != null) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               icon: Icons.check_circle_outline,
//               label: "Actual Check-out",
//               value: _formatDateTime(widget.visitorData['actual_check_out']),
//               valueColor: Colors.orange,
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionApprovalSummaryCard() {
//     List<dynamic> sections =
//         widget.visitorData['section_approval_summary'] ?? [];

//     if (sections.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     // Calculate totals
//     int totalSections = sections.length;
//     int approvedSections =
//         sections.where((s) => s['approval_status'] == 'approved').length;
//     int pendingSections =
//         sections.where((s) => s['approval_status'] == 'pending').length;
//     int rejectedSections =
//         sections.where((s) => s['approval_status'] == 'rejected').length;

//     return Container(
//       padding: const EdgeInsets.all(20),
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
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _isSectionDetailsExpanded = !_isSectionDetailsExpanded;
//                 // If collapsing, collapse all individual sections too
//                 if (!_isSectionDetailsExpanded) {
//                   for (int i = 0; i < sections.length; i++) {
//                     _expandedSections[i] = false;
//                   }
//                 }
//               });
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     Icon(Icons.location_city, size: 20, color: Colors.indigo),
//                     SizedBox(width: 8),
//                     Text(
//                       "Section Access Summary",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Icon(
//                   _isSectionDetailsExpanded
//                       ? Icons.expand_less
//                       : Icons.expand_more,
//                   color: Colors.indigo,
//                 ),
//               ],
//             ),
//           ),
//           const Divider(height: 24),

//           // Summary Stats (Always visible)
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue.withOpacity(0.2)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildSummaryItem(
//                   label: 'Total Sections',
//                   value: totalSections.toString(),
//                   color: Colors.blue,
//                 ),
//                 Container(
//                   width: 1,
//                   height: 30,
//                   color: Colors.grey[300],
//                 ),
//                 _buildSummaryItem(
//                   label: 'Approved',
//                   value: approvedSections.toString(),
//                   color: Colors.green,
//                 ),
//                 Container(
//                   width: 1,
//                   height: 30,
//                   color: Colors.grey[300],
//                 ),
//                 _buildSummaryItem(
//                   label: 'Pending',
//                   value: pendingSections.toString(),
//                   color: Colors.orange,
//                 ),
//                 if (rejectedSections > 0) ...[
//                   Container(
//                     width: 1,
//                     height: 30,
//                     color: Colors.grey[300],
//                   ),
//                   _buildSummaryItem(
//                     label: 'Rejected',
//                     value: rejectedSections.toString(),
//                     color: Colors.red,
//                   ),
//                 ],
//               ],
//             ),
//           ),

//           // Section Details (Collapsible)
//           if (_isSectionDetailsExpanded) ...[
//             const SizedBox(height: 20),
//             const Text(
//               "Section Details",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),
//             ...List.generate(sections.length, (index) {
//               return _buildSectionDetailCard(sections[index], index);
//             }),
//           ],
//         ],
//       ),
//     );
//   }

//   // Widget _buildSectionDetailCard(Map<String, dynamic> section, int index) {
//   //   String approvalStatus = section['approval_status'] ?? 'pending';
//   //   Color statusColor = approvalStatus == 'approved'
//   //       ? Colors.green
//   //       : (approvalStatus == 'rejected' ? Colors.red : Colors.orange);
//   //   IconData statusIcon = approvalStatus == 'approved'
//   //       ? Icons.check_circle
//   //       : (approvalStatus == 'rejected' ? Icons.cancel : Icons.pending);

//   //   bool consensusReached = section['consensus_reached'] ?? false;
//   //   int totalApprovers = section['total_approvers'] ?? 0;
//   //   int approvedCount = section['approved_count'] ?? 0;
//   //   int pendingCount = section['pending_count'] ?? 0;
//   //   int rejectedCount = section['rejected_count'] ?? 0;

//   //   List<dynamic> approversDetails = section['approvers_details'] ?? [];

//   //   return Container(
//   //     margin: const EdgeInsets.only(bottom: 16),
//   //     decoration: BoxDecoration(
//   //       color: statusColor.withOpacity(0.05),
//   //       borderRadius: BorderRadius.circular(12),
//   //       border: Border.all(color: statusColor.withOpacity(0.2)),
//   //     ),
//   //     child: Column(
//   //       children: [
//   //         // Section Header (Always visible, clickable to expand/collapse)
//   //         InkWell(
//   //           onTap: () {
//   //             setState(() {
//   //               _expandedSections[index] = !(_expandedSections[index] ?? false);
//   //             });
//   //           },
//   //           borderRadius: BorderRadius.circular(12),
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(16),
//   //             child: Column(
//   //               children: [
//   //                 Row(
//   //                   children: [
//   //                     Container(
//   //                       padding: const EdgeInsets.all(8),
//   //                       decoration: BoxDecoration(
//   //                         color: statusColor.withOpacity(0.1),
//   //                         borderRadius: BorderRadius.circular(8),
//   //                       ),
//   //                       child: Icon(statusIcon, color: statusColor, size: 20),
//   //                     ),
//   //                     const SizedBox(width: 12),
//   //                     Expanded(
//   //                       child: Column(
//   //                         crossAxisAlignment: CrossAxisAlignment.start,
//   //                         children: [
//   //                           Text(
//   //                             section['section_name'] ?? 'Unknown Section',
//   //                             style: const TextStyle(
//   //                               fontWeight: FontWeight.bold,
//   //                               fontSize: 15,
//   //                             ),
//   //                           ),
//   //                           const SizedBox(height: 2),
//   //                           Text(
//   //                             '${section['location_name'] ?? 'Unknown Location'} • ${section['section_code'] ?? ''}',
//   //                             style: TextStyle(
//   //                               fontSize: 11,
//   //                               color: Colors.grey[600],
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ),
//   //                     Container(
//   //                       padding: const EdgeInsets.symmetric(
//   //                           horizontal: 10, vertical: 4),
//   //                       decoration: BoxDecoration(
//   //                         color: statusColor.withOpacity(0.1),
//   //                         borderRadius: BorderRadius.circular(12),
//   //                       ),
//   //                       child: Text(
//   //                         approvalStatus.toUpperCase(),
//   //                         style: TextStyle(
//   //                           fontSize: 11,
//   //                           fontWeight: FontWeight.w600,
//   //                           color: statusColor,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     const SizedBox(width: 8),
//   //                     Icon(
//   //                       (_expandedSections[index] ?? false)
//   //                           ? Icons.expand_less
//   //                           : Icons.expand_more,
//   //                       color: Colors.grey[600],
//   //                     ),
//   //                   ],
//   //                 ),
//   //                 const SizedBox(height: 12),
//   //                 // Approval Stats (Always visible)
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                   children: [
//   //                     _buildApproverStat('Total', totalApprovers, Colors.blue),
//   //                     _buildApproverStat(
//   //                         'Approved', approvedCount, Colors.green),
//   //                     _buildApproverStat(
//   //                         'Pending', pendingCount, Colors.orange),
//   //                     if (rejectedCount > 0)
//   //                       _buildApproverStat(
//   //                           'Rejected', rejectedCount, Colors.red),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),

//   //         // Expanded Content
//   //         if (_expandedSections[index] ?? false) ...[
//   //           const Divider(height: 1, indent: 16, endIndent: 16),
//   //           const SizedBox(height: 12),
//   //           Padding(
//   //             padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 if (!consensusReached && approvalStatus == 'pending') ...[
//   //                   Container(
//   //                     padding: const EdgeInsets.all(8),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.orange.withOpacity(0.1),
//   //                       borderRadius: BorderRadius.circular(8),
//   //                     ),
//   //                     child: const Row(
//   //                       children: [
//   //                         Icon(Icons.info_outline,
//   //                             size: 14, color: Colors.orange),
//   //                         SizedBox(width: 8),
//   //                         Expanded(
//   //                           child: Text(
//   //                             'Waiting for all approvers to respond',
//   //                             style:
//   //                                 TextStyle(fontSize: 11, color: Colors.orange),
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   const SizedBox(height: 12),
//   //                 ],

//   //                 // Approvers Details
//   //                 if (approversDetails.isNotEmpty) ...[
//   //                   const Text(
//   //                     'Approvers Details:',
//   //                     style: TextStyle(
//   //                       fontSize: 12,
//   //                       fontWeight: FontWeight.w600,
//   //                       color: Colors.black87,
//   //                     ),
//   //                   ),
//   //                   const SizedBox(height: 8),
//   //                   ...approversDetails
//   //                       .map((approver) => _buildApproverDetail(approver)),
//   //                 ],

//   //                 // Tracking Status
//   //                 if (section['tracking_status'] != null &&
//   //                     section['tracking_status'] != 'not_started') ...[
//   //                   const SizedBox(height: 12),
//   //                   Container(
//   //                     padding: const EdgeInsets.all(10),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.blue.withOpacity(0.05),
//   //                       borderRadius: BorderRadius.circular(8),
//   //                       border: Border.all(color: Colors.blue.withOpacity(0.2)),
//   //                     ),
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         const Text(
//   //                           'Tracking Status:',
//   //                           style: TextStyle(
//   //                             fontSize: 11,
//   //                             fontWeight: FontWeight.w600,
//   //                             color: Colors.blue,
//   //                           ),
//   //                         ),
//   //                         const SizedBox(height: 6),
//   //                         Row(
//   //                           children: [
//   //                             Icon(
//   //                               section['checked_in'] == true
//   //                                   ? Icons.check_circle
//   //                                   : Icons.pending,
//   //                               size: 14,
//   //                               color: section['checked_in'] == true
//   //                                   ? Colors.green
//   //                                   : Colors.orange,
//   //                             ),
//   //                             const SizedBox(width: 6),
//   //                             Text(
//   //                               section['tracking_status']?.toUpperCase() ??
//   //                                   'N/A',
//   //                               style: TextStyle(
//   //                                 fontSize: 11,
//   //                                 color: section['checked_in'] == true
//   //                                     ? Colors.green
//   //                                     : Colors.orange,
//   //                                 fontWeight: FontWeight.w500,
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                         if (section['check_in_time'] != null) ...[
//   //                           const SizedBox(height: 4),
//   //                           Text(
//   //                             'Check-in: ${_formatDateTime(section['check_in_time'])}',
//   //                             style: const TextStyle(fontSize: 10),
//   //                           ),
//   //                         ],
//   //                         if (section['check_out_time'] != null) ...[
//   //                           const SizedBox(height: 2),
//   //                           Text(
//   //                             'Check-out: ${_formatDateTime(section['check_out_time'])}',
//   //                             style: const TextStyle(fontSize: 10),
//   //                           ),
//   //                         ],
//   //                         if (section['duration_minutes'] > 0) ...[
//   //                           const SizedBox(height: 2),
//   //                           Text(
//   //                             'Duration: ${section['duration_minutes']} minutes',
//   //                             style: const TextStyle(fontSize: 10),
//   //                           ),
//   //                         ],
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget _buildSectionDetailCard(Map<String, dynamic> section, int index) {
//     String approvalStatus = section['approval_status'] ?? 'pending';

//     // Update color for partially_approved status
//     Color statusColor = approvalStatus == 'approved'
//         ? Colors.green
//         : (approvalStatus == 'rejected'
//             ? Colors.red
//             : (approvalStatus == 'partially_approved'
//                 ? Colors.blue
//                 : Colors.orange));

//     IconData statusIcon = approvalStatus == 'approved'
//         ? Icons.check_circle
//         : (approvalStatus == 'rejected'
//             ? Icons.cancel
//             : (approvalStatus == 'partially_approved'
//                 ? Icons.pending_actions
//                 : Icons.pending));

//     bool consensusReached = section['consensus_reached'] ?? false;
//     int totalApprovers = section['total_approvers'] ?? 0;
//     int approvedCount = section['approved_count'] ?? 0;
//     int pendingCount = section['pending_count'] ?? 0;
//     int rejectedCount = section['rejected_count'] ?? 0;

//     List<dynamic> approversDetails = section['approvers_details'] ?? [];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: statusColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: statusColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           // Section Header
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _expandedSections[index] = !(_expandedSections[index] ?? false);
//               });
//             },
//             borderRadius: BorderRadius.circular(12),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: statusColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Icon(statusIcon, color: statusColor, size: 20),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               section['section_name'] ?? 'Unknown Section',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               '${section['location_name'] ?? 'Unknown Location'} • ${section['section_code'] ?? ''}',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: statusColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           approvalStatus.toUpperCase().replaceAll('_', ' '),
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: statusColor,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Icon(
//                         (_expandedSections[index] ?? false)
//                             ? Icons.expand_less
//                             : Icons.expand_more,
//                         color: Colors.grey[600],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   // Approval Stats
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildApproverStat('Total', totalApprovers, Colors.blue),
//                       _buildApproverStat(
//                           'Approved', approvedCount, Colors.green),
//                       if (pendingCount > 0)
//                         _buildApproverStat(
//                             'Pending', pendingCount, Colors.orange),
//                       if (rejectedCount > 0)
//                         _buildApproverStat(
//                             'Rejected', rejectedCount, Colors.red),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Expanded Content
//           if (_expandedSections[index] ?? false) ...[
//             const Divider(height: 1, indent: 16, endIndent: 16),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Status message
//                   if (approvalStatus == 'partially_approved') ...[
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.info_outline,
//                               size: 14, color: Colors.blue),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Section partially approved - waiting for other approver(s)',
//                               style:
//                                   TextStyle(fontSize: 11, color: Colors.blue),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                   ],

//                   if (!consensusReached && approvalStatus == 'pending') ...[
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.info_outline,
//                               size: 14, color: Colors.orange),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Waiting for all approvers to respond',
//                               style:
//                                   TextStyle(fontSize: 11, color: Colors.orange),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                   ],

//                   // Approvers Details
//                   if (approversDetails.isNotEmpty) ...[
//                     const Text(
//                       'Approvers Details:',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     ...approversDetails
//                         .map((approver) => _buildApproverDetail(approver)),
//                   ],

//                   // Tracking Status
//                   if (section['tracking_status'] != null &&
//                       section['tracking_status'] != 'not_started') ...[
//                     const SizedBox(height: 12),
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.blue.withOpacity(0.2)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Tracking Status:',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.blue,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Row(
//                             children: [
//                               Icon(
//                                 section['checked_in'] == true
//                                     ? Icons.check_circle
//                                     : Icons.pending,
//                                 size: 14,
//                                 color: section['checked_in'] == true
//                                     ? Colors.green
//                                     : Colors.orange,
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 section['tracking_status']?.toUpperCase() ??
//                                     'N/A',
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   color: section['checked_in'] == true
//                                       ? Colors.green
//                                       : Colors.orange,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (section['check_in_time'] != null) ...[
//                             const SizedBox(height: 4),
//                             Text(
//                               'Check-in: ${_formatDateTime(section['check_in_time'])}',
//                               style: const TextStyle(fontSize: 10),
//                             ),
//                           ],
//                           if (section['check_out_time'] != null) ...[
//                             const SizedBox(height: 2),
//                             Text(
//                               'Check-out: ${_formatDateTime(section['check_out_time'])}',
//                               style: const TextStyle(fontSize: 10),
//                             ),
//                           ],
//                           if (section['duration_minutes'] > 0) ...[
//                             const SizedBox(height: 2),
//                             Text(
//                               'Duration: ${section['duration_minutes']} minutes',
//                               style: const TextStyle(fontSize: 10),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildApproverStat(String label, int count, Color color) {
//     return Column(
//       children: [
//         Text(
//           count.toString(),
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildApproverDetail(Map<String, dynamic> approver) {
//     String status = approver['status'] ?? 'pending';
//     Color statusColor = status == 'approved'
//         ? Colors.green
//         : (status == 'rejected' ? Colors.red : Colors.orange);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Icon(
//               status == 'approved'
//                   ? Icons.check
//                   : (status == 'rejected' ? Icons.close : Icons.schedule),
//               size: 14,
//               color: statusColor,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   approver['approver_name'] ?? 'Unknown',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 13,
//                   ),
//                 ),
//                 Text(
//                   approver['approver_email'] ?? '',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey[500],
//                   ),
//                 ),
//                 if (approver['comments'] != null &&
//                     approver['comments'].toString().isNotEmpty)
//                   Text(
//                     'Comment: ${approver['comments']}',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 if (approver['rejection_reason'] != null &&
//                     approver['rejection_reason'].toString().isNotEmpty)
//                   Text(
//                     'Rejection: ${approver['rejection_reason']}',
//                     style: const TextStyle(
//                       fontSize: 10,
//                       color: Colors.red,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           if (approver['responded_at'] != null)
//             Text(
//               _formatTimeOnly(approver['responded_at']),
//               style: TextStyle(
//                 fontSize: 10,
//                 color: Colors.grey[500],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmployeeApproversCard() {
//     List<dynamic> approvers = widget.visitorData['approved_by_details'] ?? [];

//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.verified_user, size: 20, color: Colors.green),
//               SizedBox(width: 8),
//               Text(
//                 "Employee Approvers",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           if (approvers.isEmpty)
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Center(
//                 child: Text(
//                   "No employee approvers assigned",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             )
//           else
//             ...approvers.map((approver) => Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Icon(Icons.check_circle,
//                             color: Colors.green, size: 20),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               approver['full_name'] ?? 'N/A',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               approver['email'] ?? 'N/A',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             if (approver['department'] != null &&
//                                 approver['department'].toString().isNotEmpty)
//                               Text(
//                                 '${approver['department']} • ${approver['designation'] ?? ''}',
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                             if (approver['is_available'] == true)
//                               Container(
//                                 margin: const EdgeInsets.only(top: 4),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 6,
//                                   vertical: 2,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: const Text(
//                                   'Available',
//                                   style: TextStyle(
//                                     fontSize: 9,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//         ],
//       ),
//     );
//   }

//   Widget _buildVisitorApprovalsCard() {
//     List<dynamic> visitorApprovals =
//         widget.visitorData['visitor_approvals'] ?? [];

//     if (visitorApprovals.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.assignment_turned_in, size: 20, color: Colors.teal),
//               SizedBox(width: 8),
//               Text(
//                 "Visitor Approvals",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           ...visitorApprovals.map((approval) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: approval['status'] == 'approved'
//                             ? Colors.green.withOpacity(0.1)
//                             : Colors.orange.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         approval['status'] == 'approved'
//                             ? Icons.check_circle
//                             : Icons.pending,
//                         size: 18,
//                         color: approval['status'] == 'approved'
//                             ? Colors.green
//                             : Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             approval['approver_name'] ?? 'Unknown',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 13,
//                             ),
//                           ),
//                           Text(
//                             'Status: ${approval['status']?.toUpperCase() ?? 'PENDING'}',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: approval['status'] == 'approved'
//                                   ? Colors.green
//                                   : Colors.orange,
//                             ),
//                           ),
//                           if (approval['comments'] != null &&
//                               approval['comments'].toString().isNotEmpty)
//                             Text(
//                               approval['comments'],
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     if (approval['responded_at'] != null)
//                       Text(
//                         _formatTimeOnly(approval['responded_at']),
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionRequestsCard() {
//     List<dynamic> sectionRequests =
//         widget.visitorData['section_requests'] ?? [];

//     if (sectionRequests.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.request_page, size: 20, color: Colors.purple),
//               SizedBox(width: 8),
//               Text(
//                 "Section Requests",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           ...sectionRequests.map((request) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.purple.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Icon(Icons.location_on,
//                           size: 18, color: Colors.purple),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             request['section_name'] ?? 'Unknown Section',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 13,
//                             ),
//                           ),
//                           Text(
//                             'Requested: ${_formatDateTime(request['requested_at'])}',
//                             style: TextStyle(
//                               fontSize: 10,
//                               color: Colors.grey[500],
//                             ),
//                           ),
//                           if (request['notes'] != null &&
//                               request['notes'].toString().isNotEmpty)
//                             Text(
//                               request['notes'],
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildCreatedByCard() {
//     Map<String, dynamic>? createdBy = widget.visitorData['created_by_details'];

//     if (createdBy == null) return const SizedBox.shrink();

//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.person_add, size: 20, color: Colors.purple),
//               SizedBox(width: 8),
//               Text(
//                 "Created By",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.purple.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.person, color: Colors.purple, size: 20),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       createdBy['full_name'] ?? 'N/A',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       createdBy['email'] ?? 'N/A',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       '${createdBy['department'] ?? ''} • ${createdBy['designation'] ?? ''}',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       _formatDateTime(widget.visitorData['created_at']),
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimelineCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
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
//               Icon(Icons.timeline, size: 20, color: Colors.blue),
//               SizedBox(width: 8),
//               Text(
//                 "Timeline",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           _buildTimelineItem(
//             icon: Icons.create,
//             title: "Created",
//             value: _formatDateTime(widget.visitorData['created_at']),
//             color: Colors.blue,
//           ),
//           if (widget.visitorData['actual_check_in'] != null) ...[
//             const SizedBox(height: 16),
//             _buildTimelineItem(
//               icon: Icons.login,
//               title: "Actual Check-in",
//               value: _formatDateTime(widget.visitorData['actual_check_in']),
//               color: Colors.green,
//             ),
//           ],
//           if (widget.visitorData['actual_check_out'] != null) ...[
//             const SizedBox(height: 16),
//             _buildTimelineItem(
//               icon: Icons.logout,
//               title: "Actual Check-out",
//               value: _formatDateTime(widget.visitorData['actual_check_out']),
//               color: Colors.orange,
//             ),
//           ],
//           const SizedBox(height: 16),
//           _buildTimelineItem(
//             icon: Icons.update,
//             title: "Last Updated",
//             value: _formatDateTime(widget.visitorData['updated_at']),
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     Color valueColor = Colors.black87,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 18, color: Colors.grey[600]),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: valueColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTimelineItem({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color color,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, size: 16, color: color),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryItem({
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 11,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatDateTime(String? dateTimeString) {
//     if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
//     } catch (e) {
//       return dateTimeString;
//     }
//   }

//   String _formatTimeOnly(String? dateTimeString) {
//     if (dateTimeString == null || dateTimeString.isEmpty) return '';
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat('hh:mm a').format(dateTime);
//     } catch (e) {
//       return '';
//     }
//   }

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

//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Icons.check_circle;
//       case 'pending':
//         return Icons.pending_actions;
//       case 'rejected':
//         return Icons.cancel;
//       case 'checked_in':
//         return Icons.login;
//       case 'checked_out':
//         return Icons.logout;
//       default:
//         return Icons.info;
//     }
//   }
// }

// **********************************************

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:modernlogintute/services/api_services.dart';

// class VisitorViewPage extends StatefulWidget {
//   final Map<String, dynamic> visitorData;

//   const VisitorViewPage({super.key, required this.visitorData});

//   @override
//   State<VisitorViewPage> createState() => _VisitorViewPageState();
// }

// class _VisitorViewPageState extends State<VisitorViewPage> {
//   bool _isSectionDetailsExpanded = false;
//   Map<int, bool> _expandedSections = {};

//   // Loading states
//   bool _isSiteCheckInLoading = false;
//   bool _isSiteCheckOutLoading = false;
//   Map<int, bool> _sectionActionLoading = {};

//   // Store updated visitor data
//   late Map<String, dynamic> _visitorData;

//   @override
//   void initState() {
//     super.initState();
//     _visitorData = Map.from(widget.visitorData);
//     List<dynamic> sections = _visitorData['section_approval_summary'] ?? [];
//     for (int i = 0; i < sections.length; i++) {
//       _expandedSections[i] = false;
//       _sectionActionLoading[i] = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Visitor Details",
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context, _visitorData),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshData,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               _buildStatusCard(),
//               const SizedBox(height: 20),
//               _buildInfoCard(),
//               const SizedBox(height: 20),
//               _buildVisitDetailsCard(),
//               const SizedBox(height: 20),
//               _buildSectionApprovalSummaryCard(),
//               const SizedBox(height: 20),
//               _buildEmployeeApproversCard(),
//               const SizedBox(height: 20),
//               _buildVisitorApprovalsCard(),
//               const SizedBox(height: 20),
//               _buildSectionRequestsCard(),
//               const SizedBox(height: 20),
//               _buildCreatedByCard(),
//               const SizedBox(height: 20),
//               _buildTimelineCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _refreshData() async {
//     try {
//       final visitorId = _visitorData['id'];
//       final response = await ApiService.getVisitor(visitorId);
//       if (mounted) {
//         setState(() {
//           _visitorData = response;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Failed to refresh: $e'),
//               backgroundColor: Colors.red),
//         );
//       }
//     }
//   }

//   Future<void> _siteCheckIn() async {
//     final visitorId = _visitorData['id'];

//     setState(() => _isSiteCheckInLoading = true);

//     try {
//       final response = await ApiService.checkInVisitor(visitorId);

//       setState(() {
//         _visitorData['status'] = 'checked_in';
//         _visitorData['actual_check_in'] = response['check_in_time'];
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               '✅ ${response['message'] ?? 'Visitor checked in successfully'}'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 3),
//         ),
//       );

//       await _refreshData();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     } finally {
//       if (mounted) setState(() => _isSiteCheckInLoading = false);
//     }
//   }

//   Future<void> _siteCheckOut() async {
//     final visitorId = _visitorData['id'];

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Check Out Visitor'),
//         content: Text(
//             'Are you sure you want to check out ${_visitorData['full_name']}?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Check Out'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true) return;

//     setState(() => _isSiteCheckOutLoading = true);

//     try {
//       final response = await ApiService.checkOutVisitor(visitorId);

//       setState(() {
//         _visitorData['status'] = 'checked_out';
//         _visitorData['actual_check_out'] = response['check_out_time'];
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               '✅ ${response['message'] ?? 'Visitor checked out successfully'}'),
//           backgroundColor: Colors.orange,
//           duration: const Duration(seconds: 3),
//         ),
//       );

//       await _refreshData();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     } finally {
//       if (mounted) setState(() => _isSiteCheckOutLoading = false);
//     }
//   }

//   Future<void> _sectionCheckIn(
//       int sectionId, String sectionName, int sectionIndex) async {
//     final visitorId = _visitorData['id'];

//     setState(() {
//       _sectionActionLoading[sectionIndex] = true;
//     });

//     try {
//       final response = await ApiService.sectionCheckIn(visitorId, sectionId);

//       setState(() {
//         final sections = _visitorData['section_approval_summary'] as List;
//         if (sectionIndex < sections.length) {
//           sections[sectionIndex]['tracking_status'] = 'in_progress';
//           sections[sectionIndex]['checked_in'] = true;
//           sections[sectionIndex]['check_in_time'] =
//               response['section_check_in'];
//         }
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text('✅ ${response['message'] ?? 'Checked into $sectionName'}'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );

//       await _refreshData();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _sectionActionLoading[sectionIndex] = false;
//         });
//       }
//     }
//   }

//   Future<void> _sectionCheckOut(
//       int sectionId, String sectionName, int sectionIndex) async {
//     final visitorId = _visitorData['id'];

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Check Out of Section'),
//         content: Text('Are you sure you want to check out of "$sectionName"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Check Out'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true) return;

//     setState(() {
//       _sectionActionLoading[sectionIndex] = true;
//     });

//     try {
//       final response = await ApiService.sectionCheckOut(visitorId, sectionId);

//       setState(() {
//         final sections = _visitorData['section_approval_summary'] as List;
//         if (sectionIndex < sections.length) {
//           sections[sectionIndex]['tracking_status'] = 'completed';
//           sections[sectionIndex]['checked_out'] = true;
//           sections[sectionIndex]['check_out_time'] =
//               response['section_check_out'];
//           sections[sectionIndex]['duration_minutes'] =
//               response['duration_minutes'];
//         }
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text('✅ ${response['message'] ?? 'Checked out of $sectionName'}'),
//           backgroundColor: Colors.orange,
//           duration: const Duration(seconds: 2),
//         ),
//       );

//       await _refreshData();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _sectionActionLoading[sectionIndex] = false;
//         });
//       }
//     }
//   }

//   Widget _buildStatusCard() {
//     String status = _visitorData['status'] ?? 'pending';
//     Color statusColor = _getStatusColor(status);
//     IconData statusIcon = _getStatusIcon(status);

//     bool canCheckIn = status == 'approved' || status == 'partially_approved';
//     bool canCheckOut = status == 'checked_in';

//     return Container(
//       padding: const EdgeInsets.all(16),
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
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: statusColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(statusIcon, color: statusColor, size: 28),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Visit Status",
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       status.toUpperCase(),
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: statusColor),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: statusColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   status.replaceAll('_', ' '),
//                   style: TextStyle(
//                       color: statusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//           if (canCheckIn || canCheckOut)
//             Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: Row(
//                 children: [
//                   if (canCheckIn)
//                     Expanded(
//                       child: ElevatedButton.icon(
//                         onPressed: _isSiteCheckInLoading ? null : _siteCheckIn,
//                         icon: _isSiteCheckInLoading
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child:
//                                     CircularProgressIndicator(strokeWidth: 2))
//                             : const Icon(Icons.login, size: 18),
//                         label: Text(_isSiteCheckInLoading
//                             ? 'Checking in...'
//                             : 'Site Check-in'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                     ),
//                   if (canCheckIn && canCheckOut) const SizedBox(width: 12),
//                   if (canCheckOut)
//                     Expanded(
//                       child: ElevatedButton.icon(
//                         onPressed:
//                             _isSiteCheckOutLoading ? null : _siteCheckOut,
//                         icon: _isSiteCheckOutLoading
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child:
//                                     CircularProgressIndicator(strokeWidth: 2))
//                             : const Icon(Icons.logout, size: 18),
//                         label: Text(_isSiteCheckOutLoading
//                             ? 'Checking out...'
//                             : 'Site Check-out'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.person_outline, size: 20, color: Colors.blue),
//               SizedBox(width: 8),
//               Text("Visitor Information",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const Divider(height: 24),
//           _buildInfoRow(
//               icon: Icons.person,
//               label: "Full Name",
//               value: _visitorData['full_name'] ?? 'N/A'),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//               icon: Icons.email,
//               label: "Email",
//               value: _visitorData['email'] ?? 'N/A'),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//               icon: Icons.phone,
//               label: "Phone Number",
//               value: _visitorData['phone_number'] ?? 'N/A'),
//           if (_visitorData['company_name'] != null &&
//               _visitorData['company_name'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.business,
//                 label: "Company",
//                 value: _visitorData['company_name']),
//           ],
//           if (_visitorData['vehicle_number'] != null &&
//               _visitorData['vehicle_number'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.directions_car,
//                 label: "Vehicle Number",
//                 value: _visitorData['vehicle_number']),
//           ],
//           if (_visitorData['id_card_number'] != null &&
//               _visitorData['id_card_number'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.badge,
//                 label: "ID Card Number",
//                 value: _visitorData['id_card_number']),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildVisitDetailsCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.calendar_today, size: 20, color: Colors.orange),
//               SizedBox(width: 8),
//               Text("Visit Details",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const Divider(height: 24),
//           _buildInfoRow(
//               icon: Icons.login,
//               label: "Designated Check-in",
//               value: _formatDateTime(_visitorData['designated_check_in'])),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//               icon: Icons.logout,
//               label: "Designated Check-out",
//               value: _formatDateTime(_visitorData['designated_check_out'])),
//           if (_visitorData['purpose_of_visit'] != null &&
//               _visitorData['purpose_of_visit'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.info_outline,
//                 label: "Purpose",
//                 value: _visitorData['purpose_of_visit']),
//           ],
//           if (_visitorData['host_department'] != null &&
//               _visitorData['host_department'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.business_center,
//                 label: "Host Department",
//                 value: _visitorData['host_department']),
//           ],
//           if (_visitorData['meeting_room'] != null &&
//               _visitorData['meeting_room'].toString().isNotEmpty) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.meeting_room,
//                 label: "Meeting Room",
//                 value: _visitorData['meeting_room']),
//           ],
//           if (_visitorData['actual_check_in'] != null) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.check_circle,
//                 label: "Actual Check-in",
//                 value: _formatDateTime(_visitorData['actual_check_in']),
//                 valueColor: Colors.green),
//           ],
//           if (_visitorData['actual_check_out'] != null) ...[
//             const SizedBox(height: 16),
//             _buildInfoRow(
//                 icon: Icons.check_circle_outline,
//                 label: "Actual Check-out",
//                 value: _formatDateTime(_visitorData['actual_check_out']),
//                 valueColor: Colors.orange),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionApprovalSummaryCard() {
//     List<dynamic> sections = _visitorData['section_approval_summary'] ?? [];

//     if (sections.isEmpty) return const SizedBox.shrink();

//     int totalSections = sections.length;
//     int approvedSections =
//         sections.where((s) => s['approval_status'] == 'approved').length;
//     int pendingSections =
//         sections.where((s) => s['approval_status'] == 'pending').length;
//     int rejectedSections =
//         sections.where((s) => s['approval_status'] == 'rejected').length;
//     int partiallyApproved = sections
//         .where((s) => s['approval_status'] == 'partially_approved')
//         .length;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _isSectionDetailsExpanded = !_isSectionDetailsExpanded;
//                 if (!_isSectionDetailsExpanded) {
//                   for (int i = 0; i < sections.length; i++) {
//                     _expandedSections[i] = false;
//                   }
//                 }
//               });
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     Icon(Icons.location_city, size: 20, color: Colors.indigo),
//                     SizedBox(width: 8),
//                     Text("Section Access Summary",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Icon(
//                     _isSectionDetailsExpanded
//                         ? Icons.expand_less
//                         : Icons.expand_more,
//                     color: Colors.indigo),
//               ],
//             ),
//           ),
//           const Divider(height: 24),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue.withOpacity(0.2)),
//             ),
//             child: Wrap(
//               spacing: 16,
//               runSpacing: 8,
//               alignment: WrapAlignment.spaceAround,
//               children: [
//                 _buildSummaryItem(
//                     label: 'Total Sections',
//                     value: totalSections.toString(),
//                     color: Colors.blue),
//                 _buildSummaryItem(
//                     label: 'Approved',
//                     value: approvedSections.toString(),
//                     color: Colors.green),
//                 if (partiallyApproved > 0)
//                   _buildSummaryItem(
//                       label: 'Partial',
//                       value: partiallyApproved.toString(),
//                       color: Colors.blue),
//                 if (pendingSections > 0)
//                   _buildSummaryItem(
//                       label: 'Pending',
//                       value: pendingSections.toString(),
//                       color: Colors.orange),
//                 if (rejectedSections > 0)
//                   _buildSummaryItem(
//                       label: 'Rejected',
//                       value: rejectedSections.toString(),
//                       color: Colors.red),
//               ],
//             ),
//           ),
//           if (_isSectionDetailsExpanded) ...[
//             const SizedBox(height: 20),
//             const Text("Section Details",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 12),
//             ...List.generate(sections.length,
//                 (index) => _buildSectionDetailCard(sections[index], index)),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionDetailCard(Map<String, dynamic> section, int index) {
//     String approvalStatus = section['approval_status'] ?? 'pending';
//     String trackingStatus = section['tracking_status'] ?? 'not_started';
//     bool isAccessible = approvalStatus == 'approved';
//     bool canCheckIn = isAccessible && trackingStatus == 'not_started';
//     bool canCheckOut = isAccessible && trackingStatus == 'in_progress';
//     bool isLoading = _sectionActionLoading[index] ?? false;

//     Color statusColor = approvalStatus == 'approved'
//         ? Colors.green
//         : (approvalStatus == 'rejected'
//             ? Colors.red
//             : (approvalStatus == 'partially_approved'
//                 ? Colors.blue
//                 : Colors.orange));

//     IconData statusIcon = approvalStatus == 'approved'
//         ? Icons.check_circle
//         : (approvalStatus == 'rejected'
//             ? Icons.cancel
//             : (approvalStatus == 'partially_approved'
//                 ? Icons.pending_actions
//                 : Icons.pending));

//     bool consensusReached = section['consensus_reached'] ?? false;
//     int totalApprovers = section['total_approvers'] ?? 0;
//     int approvedCount = section['approved_count'] ?? 0;
//     int pendingCount = section['pending_count'] ?? 0;
//     int rejectedCount = section['rejected_count'] ?? 0;
//     List<dynamic> approversDetails = section['approvers_details'] ?? [];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: statusColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: statusColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _expandedSections[index] = !(_expandedSections[index] ?? false);
//               });
//             },
//             borderRadius: BorderRadius.circular(12),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                             color: statusColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Icon(statusIcon, color: statusColor, size: 20),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(section['section_name'] ?? 'Unknown Section',
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 15)),
//                             const SizedBox(height: 2),
//                             Text(
//                                 '${section['location_name'] ?? 'Unknown Location'} • ${section['section_code'] ?? ''}',
//                                 style: TextStyle(
//                                     fontSize: 11, color: Colors.grey[600])),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                             color: statusColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12)),
//                         child: Text(
//                             approvalStatus.toUpperCase().replaceAll('_', ' '),
//                             style: TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w600,
//                                 color: statusColor)),
//                       ),
//                       const SizedBox(width: 8),
//                       Icon(
//                           (_expandedSections[index] ?? false)
//                               ? Icons.expand_less
//                               : Icons.expand_more,
//                           color: Colors.grey[600]),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildApproverStat('Total', totalApprovers, Colors.blue),
//                       _buildApproverStat(
//                           'Approved', approvedCount, Colors.green),
//                       if (pendingCount > 0)
//                         _buildApproverStat(
//                             'Pending', pendingCount, Colors.orange),
//                       if (rejectedCount > 0)
//                         _buildApproverStat(
//                             'Rejected', rejectedCount, Colors.red),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (_expandedSections[index] ?? false) ...[
//             const Divider(height: 1, indent: 16, endIndent: 16),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (isAccessible && (canCheckIn || canCheckOut))
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 12),
//                       child: Row(
//                         children: [
//                           if (canCheckIn)
//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 onPressed: isLoading
//                                     ? null
//                                     : () => _sectionCheckIn(
//                                         section['section_id'],
//                                         section['section_name'],
//                                         index),
//                                 icon: isLoading
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child: CircularProgressIndicator(
//                                             strokeWidth: 2))
//                                     : const Icon(Icons.login, size: 16),
//                                 label: const Text('Check In'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                   foregroundColor: Colors.white,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8)),
//                                 ),
//                               ),
//                             ),
//                           if (canCheckIn && canCheckOut)
//                             const SizedBox(width: 12),
//                           if (canCheckOut)
//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 onPressed: isLoading
//                                     ? null
//                                     : () => _sectionCheckOut(
//                                         section['section_id'],
//                                         section['section_name'],
//                                         index),
//                                 icon: isLoading
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child: CircularProgressIndicator(
//                                             strokeWidth: 2))
//                                     : const Icon(Icons.logout, size: 16),
//                                 label: const Text('Check Out'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.orange,
//                                   foregroundColor: Colors.white,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8)),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   if (approvalStatus == 'partially_approved')
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.info_outline,
//                               size: 14, color: Colors.blue),
//                           SizedBox(width: 8),
//                           Expanded(
//                               child: Text(
//                                   'Section partially approved - waiting for other approver(s)',
//                                   style: TextStyle(
//                                       fontSize: 11, color: Colors.blue))),
//                         ],
//                       ),
//                     ),
//                   if (!consensusReached && approvalStatus == 'pending') ...[
//                     const SizedBox(height: 12),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           color: Colors.orange.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.info_outline,
//                               size: 14, color: Colors.orange),
//                           SizedBox(width: 8),
//                           Expanded(
//                               child: Text(
//                                   'Waiting for all approvers to respond',
//                                   style: TextStyle(
//                                       fontSize: 11, color: Colors.orange))),
//                         ],
//                       ),
//                     ),
//                   ],
//                   if (approversDetails.isNotEmpty) ...[
//                     const SizedBox(height: 12),
//                     const Text('Approvers Details:',
//                         style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w600)),
//                     const SizedBox(height: 8),
//                     ...approversDetails
//                         .map((approver) => _buildApproverDetail(approver)),
//                   ],
//                   if (trackingStatus != 'not_started') ...[
//                     const SizedBox(height: 12),
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.blue.withOpacity(0.2)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text('Tracking Status:',
//                               style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.blue)),
//                           const SizedBox(height: 6),
//                           Row(
//                             children: [
//                               Icon(
//                                   section['checked_in'] == true
//                                       ? Icons.check_circle
//                                       : Icons.pending,
//                                   size: 14,
//                                   color: section['checked_in'] == true
//                                       ? Colors.green
//                                       : Colors.orange),
//                               const SizedBox(width: 6),
//                               Text(trackingStatus.toUpperCase(),
//                                   style: TextStyle(
//                                       fontSize: 11,
//                                       color: section['checked_in'] == true
//                                           ? Colors.green
//                                           : Colors.orange,
//                                       fontWeight: FontWeight.w500)),
//                             ],
//                           ),
//                           if (section['check_in_time'] != null) ...[
//                             const SizedBox(height: 4),
//                             Text(
//                                 'Check-in: ${_formatDateTime(section['check_in_time'])}',
//                                 style: const TextStyle(fontSize: 10)),
//                           ],
//                           if (section['check_out_time'] != null) ...[
//                             const SizedBox(height: 2),
//                             Text(
//                                 'Check-out: ${_formatDateTime(section['check_out_time'])}',
//                                 style: const TextStyle(fontSize: 10)),
//                           ],
//                           if ((section['duration_minutes'] ?? 0) > 0) ...[
//                             const SizedBox(height: 2),
//                             Text(
//                                 'Duration: ${section['duration_minutes']} minutes',
//                                 style: const TextStyle(fontSize: 10)),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildEmployeeApproversCard() {
//     List<dynamic> approvers = _visitorData['approved_by_details'] ?? [];
//     if (approvers.isEmpty) return const SizedBox.shrink();

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(children: [
//             Icon(Icons.verified_user, size: 20, color: Colors.green),
//             SizedBox(width: 8),
//             Text("Employee Approvers",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
//           ]),
//           const Divider(height: 24),
//           ...approvers.map((approver) => Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Row(
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             color: Colors.green.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Icon(Icons.check_circle,
//                             color: Colors.green, size: 20)),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(approver['full_name'] ?? 'N/A',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w600, fontSize: 14)),
//                           const SizedBox(height: 2),
//                           Text(approver['email'] ?? 'N/A',
//                               style: TextStyle(
//                                   fontSize: 12, color: Colors.grey[600])),
//                           if (approver['department'] != null &&
//                               approver['department'].toString().isNotEmpty)
//                             Text(
//                                 '${approver['department']} • ${approver['designation'] ?? ''}',
//                                 style: TextStyle(
//                                     fontSize: 11, color: Colors.grey[500])),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildVisitorApprovalsCard() {
//     List<dynamic> visitorApprovals = _visitorData['visitor_approvals'] ?? [];
//     if (visitorApprovals.isEmpty) return const SizedBox.shrink();

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(children: [
//             Icon(Icons.assignment_turned_in, size: 20, color: Colors.teal),
//             SizedBox(width: 8),
//             Text("Visitor Approvals",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
//           ]),
//           const Divider(height: 24),
//           ...visitorApprovals.map((approval) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Row(
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                             color: approval['status'] == 'approved'
//                                 ? Colors.green.withOpacity(0.1)
//                                 : Colors.orange.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Icon(
//                             approval['status'] == 'approved'
//                                 ? Icons.check_circle
//                                 : Icons.pending,
//                             size: 18,
//                             color: approval['status'] == 'approved'
//                                 ? Colors.green
//                                 : Colors.orange)),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(approval['approver_name'] ?? 'Unknown',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w500, fontSize: 13)),
//                           Text(
//                               'Status: ${approval['status']?.toUpperCase() ?? 'PENDING'}',
//                               style: TextStyle(
//                                   fontSize: 11,
//                                   color: approval['status'] == 'approved'
//                                       ? Colors.green
//                                       : Colors.orange)),
//                           if (approval['comments'] != null &&
//                               approval['comments'].toString().isNotEmpty)
//                             Text(approval['comments'],
//                                 style: TextStyle(
//                                     fontSize: 10, color: Colors.grey[600])),
//                         ],
//                       ),
//                     ),
//                     if (approval['responded_at'] != null)
//                       Text(_formatTimeOnly(approval['responded_at']),
//                           style:
//                               TextStyle(fontSize: 10, color: Colors.grey[500])),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionRequestsCard() {
//     List<dynamic> sectionRequests = _visitorData['section_requests'] ?? [];
//     if (sectionRequests.isEmpty) return const SizedBox.shrink();

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(children: [
//             Icon(Icons.request_page, size: 20, color: Colors.purple),
//             SizedBox(width: 8),
//             Text("Section Requests",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
//           ]),
//           const Divider(height: 24),
//           ...sectionRequests.map((request) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Row(
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                             color: Colors.purple.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8)),
//                         child: const Icon(Icons.location_on,
//                             size: 18, color: Colors.purple)),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(request['section_name'] ?? 'Unknown Section',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w500, fontSize: 13)),
//                           Text(
//                               'Requested: ${_formatDateTime(request['requested_at'])}',
//                               style: TextStyle(
//                                   fontSize: 10, color: Colors.grey[500])),
//                           if (request['notes'] != null &&
//                               request['notes'].toString().isNotEmpty)
//                             Text(request['notes'],
//                                 style: TextStyle(
//                                     fontSize: 10, color: Colors.grey[600])),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildCreatedByCard() {
//     Map<String, dynamic>? createdBy = _visitorData['created_by_details'];
//     if (createdBy == null) return const SizedBox.shrink();

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(children: [
//             Icon(Icons.person_add, size: 20, color: Colors.purple),
//             SizedBox(width: 8),
//             Text("Created By",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
//           ]),
//           const Divider(height: 24),
//           Row(
//             children: [
//               Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       color: Colors.purple.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)),
//                   child:
//                       const Icon(Icons.person, color: Colors.purple, size: 20)),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(createdBy['full_name'] ?? 'N/A',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 14)),
//                     const SizedBox(height: 2),
//                     Text(createdBy['email'] ?? 'N/A',
//                         style:
//                             TextStyle(fontSize: 12, color: Colors.grey[600])),
//                     const SizedBox(height: 2),
//                     Text(
//                         '${createdBy['department'] ?? ''} • ${createdBy['designation'] ?? ''}',
//                         style:
//                             TextStyle(fontSize: 11, color: Colors.grey[500])),
//                     const SizedBox(height: 4),
//                     Text(_formatDateTime(_visitorData['created_at']),
//                         style:
//                             TextStyle(fontSize: 11, color: Colors.grey[500])),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimelineCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(children: [
//             Icon(Icons.timeline, size: 20, color: Colors.blue),
//             SizedBox(width: 8),
//             Text("Timeline",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
//           ]),
//           const Divider(height: 24),
//           _buildTimelineItem(
//               icon: Icons.create,
//               title: "Created",
//               value: _formatDateTime(_visitorData['created_at']),
//               color: Colors.blue),
//           if (_visitorData['actual_check_in'] != null) ...[
//             const SizedBox(height: 16),
//             _buildTimelineItem(
//                 icon: Icons.login,
//                 title: "Actual Check-in",
//                 value: _formatDateTime(_visitorData['actual_check_in']),
//                 color: Colors.green),
//           ],
//           if (_visitorData['actual_check_out'] != null) ...[
//             const SizedBox(height: 16),
//             _buildTimelineItem(
//                 icon: Icons.logout,
//                 title: "Actual Check-out",
//                 value: _formatDateTime(_visitorData['actual_check_out']),
//                 color: Colors.orange),
//           ],
//           const SizedBox(height: 16),
//           _buildTimelineItem(
//               icon: Icons.update,
//               title: "Last Updated",
//               value: _formatDateTime(_visitorData['updated_at']),
//               color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//       {required IconData icon,
//       required String label,
//       required String value,
//       Color valueColor = Colors.black87}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 18, color: Colors.grey[600]),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label,
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500)),
//               const SizedBox(height: 4),
//               Text(value, style: TextStyle(fontSize: 14, color: valueColor)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTimelineItem(
//       {required IconData icon,
//       required String title,
//       required String value,
//       required Color color}) {
//     return Row(
//       children: [
//         Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Icon(icon, size: 16, color: color)),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500)),
//               const SizedBox(height: 2),
//               Text(value,
//                   style: const TextStyle(
//                       fontSize: 13, fontWeight: FontWeight.w500)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryItem(
//       {required String label, required String value, required Color color}) {
//     return Column(
//       children: [
//         Text(value,
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: color)),
//         const SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
//       ],
//     );
//   }

//   Widget _buildApproverStat(String label, int count, Color color) {
//     return Column(
//       children: [
//         Text(count.toString(),
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: color)),
//         const SizedBox(height: 2),
//         Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
//       ],
//     );
//   }

//   Widget _buildApproverDetail(Map<String, dynamic> approver) {
//     String status = approver['status'] ?? 'pending';
//     Color statusColor = status == 'approved'
//         ? Colors.green
//         : (status == 'rejected' ? Colors.red : Colors.orange);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//                 color: statusColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(6)),
//             child: Icon(
//                 status == 'approved'
//                     ? Icons.check
//                     : (status == 'rejected' ? Icons.close : Icons.schedule),
//                 size: 14,
//                 color: statusColor),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(approver['approver_name'] ?? 'Unknown',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w500, fontSize: 13)),
//                 Text(approver['approver_email'] ?? '',
//                     style: TextStyle(fontSize: 10, color: Colors.grey[500])),
//                 if (approver['comments'] != null &&
//                     approver['comments'].toString().isNotEmpty)
//                   Text('Comment: ${approver['comments']}',
//                       style: TextStyle(fontSize: 10, color: Colors.grey[600])),
//                 if (approver['rejection_reason'] != null &&
//                     approver['rejection_reason'].toString().isNotEmpty)
//                   Text('Rejection: ${approver['rejection_reason']}',
//                       style: const TextStyle(fontSize: 10, color: Colors.red)),
//               ],
//             ),
//           ),
//           if (approver['responded_at'] != null)
//             Text(_formatTimeOnly(approver['responded_at']),
//                 style: TextStyle(fontSize: 10, color: Colors.grey[500])),
//         ],
//       ),
//     );
//   }

//   String _formatDateTime(String? dateTimeString) {
//     if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
//     } catch (e) {
//       return dateTimeString;
//     }
//   }

//   String _formatTimeOnly(String? dateTimeString) {
//     if (dateTimeString == null || dateTimeString.isEmpty) return '';
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat('hh:mm a').format(dateTime);
//     } catch (e) {
//       return '';
//     }
//   }

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

//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Icons.check_circle;
//       case 'pending':
//         return Icons.pending_actions;
//       case 'rejected':
//         return Icons.cancel;
//       case 'checked_in':
//         return Icons.login;
//       case 'checked_out':
//         return Icons.logout;
//       default:
//         return Icons.info;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modernlogintute/services/api_services.dart';

class VisitorViewPage extends StatefulWidget {
  final Map<String, dynamic> visitorData;

  const VisitorViewPage({super.key, required this.visitorData});

  @override
  State<VisitorViewPage> createState() => _VisitorViewPageState();
}

class _VisitorViewPageState extends State<VisitorViewPage> {
  bool _isSectionDetailsExpanded = false;
  Map<int, bool> _expandedSections = {};

  // Loading states
  bool _isSiteCheckInLoading = false;
  bool _isSiteCheckOutLoading = false;
  Map<int, bool> _sectionActionLoading = {};

  // Track active section (only one section can be active at a time)
  int? _activeSectionId;
  int? _activeSectionIndex;

  // Store updated visitor data
  late Map<String, dynamic> _visitorData;

  @override
  void initState() {
    super.initState();
    _visitorData = Map.from(widget.visitorData);
    List<dynamic> sections = _visitorData['section_approval_summary'] ?? [];
    for (int i = 0; i < sections.length; i++) {
      _expandedSections[i] = false;
      _sectionActionLoading[i] = false;

      // Check if any section is currently checked in (in_progress)
      if (sections[i]['tracking_status'] == 'in_progress') {
        _activeSectionId = sections[i]['section_id'];
        _activeSectionIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Visitor Details",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, _visitorData),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildStatusCard(),
              const SizedBox(height: 20),
              _buildInfoCard(),
              const SizedBox(height: 20),
              _buildVisitDetailsCard(),
              const SizedBox(height: 20),
              _buildSectionApprovalSummaryCard(),
              const SizedBox(height: 20),
              _buildEmployeeApproversCard(),
              const SizedBox(height: 20),
              _buildVisitorApprovalsCard(),
              const SizedBox(height: 20),
              _buildSectionRequestsCard(),
              const SizedBox(height: 20),
              _buildCreatedByCard(),
              const SizedBox(height: 20),
              _buildTimelineCard(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    try {
      final visitorId = _visitorData['id'];
      final response = await ApiService.getVisitor(visitorId);
      if (mounted) {
        setState(() {
          _visitorData = response;
          // Update active section based on refreshed data
          final sections = _visitorData['section_approval_summary'] ?? [];
          _activeSectionId = null;
          _activeSectionIndex = null;
          for (int i = 0; i < sections.length; i++) {
            if (sections[i]['tracking_status'] == 'in_progress') {
              _activeSectionId = sections[i]['section_id'];
              _activeSectionIndex = i;
              break;
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to refresh: $e'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _siteCheckIn() async {
    final visitorId = _visitorData['id'];

    setState(() => _isSiteCheckInLoading = true);

    try {
      final response = await ApiService.checkInVisitor(visitorId);

      setState(() {
        _visitorData['status'] = 'checked_in';
        _visitorData['actual_check_in'] = response['check_in_time'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '✅ ${response['message'] ?? 'Visitor checked in successfully'}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      await _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSiteCheckInLoading = false);
    }
  }

  Future<void> _siteCheckOut() async {
    // Check if there's an active section before allowing site check-out
    if (_activeSectionId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              '⚠️ Please check out of the current section before checking out of the site'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final visitorId = _visitorData['id'];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Check Out Visitor'),
        content: Text(
            'Are you sure you want to check out ${_visitorData['full_name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Check Out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isSiteCheckOutLoading = true);

    try {
      final response = await ApiService.checkOutVisitor(visitorId);

      setState(() {
        _visitorData['status'] = 'checked_out';
        _visitorData['actual_check_out'] = response['check_out_time'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '✅ ${response['message'] ?? 'Visitor checked out successfully'}'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
        ),
      );

      await _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSiteCheckOutLoading = false);
    }
  }

  Future<void> _sectionCheckIn(
      int sectionId, String sectionName, int sectionIndex) async {
    final visitorId = _visitorData['id'];

    // Check if visitor is checked in to the site first
    if (_visitorData['status'] != 'checked_in') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              '⚠️ Please check in to the site first before accessing sections'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Check if another section is already active
    if (_activeSectionId != null && _activeSectionId != sectionId) {
      // Find the active section name
      String activeSectionName = '';
      final sections = _visitorData['section_approval_summary'] as List;
      for (var section in sections) {
        if (section['section_id'] == _activeSectionId) {
          activeSectionName = section['section_name'] ?? 'Unknown';
          break;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '⚠️ Please check out of "$activeSectionName" first before accessing another section'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      _sectionActionLoading[sectionIndex] = true;
    });

    try {
      final response = await ApiService.sectionCheckIn(visitorId, sectionId);

      setState(() {
        final sections = _visitorData['section_approval_summary'] as List;
        if (sectionIndex < sections.length) {
          sections[sectionIndex]['tracking_status'] = 'in_progress';
          sections[sectionIndex]['checked_in'] = true;
          sections[sectionIndex]['check_in_time'] =
              response['section_check_in'];
        }
        _activeSectionId = sectionId;
        _activeSectionIndex = sectionIndex;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Checked into $sectionName'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      await _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _sectionActionLoading[sectionIndex] = false;
        });
      }
    }
  }

  Future<void> _sectionCheckOut(
      int sectionId, String sectionName, int sectionIndex) async {
    final visitorId = _visitorData['id'];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Check Out of Section'),
        content: Text('Are you sure you want to check out of "$sectionName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Check Out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _sectionActionLoading[sectionIndex] = true;
    });

    try {
      final response = await ApiService.sectionCheckOut(visitorId, sectionId);

      setState(() {
        final sections = _visitorData['section_approval_summary'] as List;
        if (sectionIndex < sections.length) {
          sections[sectionIndex]['tracking_status'] = 'completed';
          sections[sectionIndex]['checked_out'] = true;
          sections[sectionIndex]['check_out_time'] =
              response['section_check_out'];
          sections[sectionIndex]['duration_minutes'] =
              response['duration_minutes'];
        }
        // Clear active section since this one is checked out
        if (_activeSectionId == sectionId) {
          _activeSectionId = null;
          _activeSectionIndex = null;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Checked out of $sectionName'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
        ),
      );

      await _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _sectionActionLoading[sectionIndex] = false;
        });
      }
    }
  }

  Widget _buildStatusCard() {
    String status = _visitorData['status'] ?? 'pending';
    Color statusColor = _getStatusColor(status);
    IconData statusIcon = _getStatusIcon(status);

    bool canCheckIn =
        (status == 'approved' || status == 'partially_approved') &&
            status != 'checked_in';
    bool canCheckOut = status == 'checked_in';

    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(statusIcon, color: statusColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Visit Status",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status.toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: statusColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status.replaceAll('_', ' '),
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          if (canCheckIn || canCheckOut)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  if (canCheckIn)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isSiteCheckInLoading ? null : _siteCheckIn,
                        icon: _isSiteCheckInLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.login, size: 18),
                        label: Text(_isSiteCheckInLoading
                            ? 'Checking in...'
                            : 'Site Check-in'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  if (canCheckIn && canCheckOut) const SizedBox(width: 12),
                  if (canCheckOut)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:
                            _isSiteCheckOutLoading ? null : _siteCheckOut,
                        icon: _isSiteCheckOutLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.logout, size: 18),
                        label: Text(_isSiteCheckOutLoading
                            ? 'Checking out...'
                            : 'Site Check-out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          // Show active section info if any
          if (_activeSectionId != null && status == 'checked_in')
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      'Currently in: ',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        _getActiveSectionName(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.blue),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getActiveSectionName() {
    if (_activeSectionId == null) return 'None';
    final sections = _visitorData['section_approval_summary'] as List;
    for (var section in sections) {
      if (section['section_id'] == _activeSectionId) {
        return section['section_name'] ?? 'Unknown Section';
      }
    }
    return 'Unknown';
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, size: 20, color: Colors.blue),
              SizedBox(width: 8),
              Text("Visitor Information",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow(
              icon: Icons.person,
              label: "Full Name",
              value: _visitorData['full_name'] ?? 'N/A'),
          const SizedBox(height: 16),
          _buildInfoRow(
              icon: Icons.email,
              label: "Email",
              value: _visitorData['email'] ?? 'N/A'),
          const SizedBox(height: 16),
          _buildInfoRow(
              icon: Icons.phone,
              label: "Phone Number",
              value: _visitorData['phone_number'] ?? 'N/A'),
          if (_visitorData['company_name'] != null &&
              _visitorData['company_name'].toString().isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.business,
                label: "Company",
                value: _visitorData['company_name']),
          ],
          if (_visitorData['vehicle_number'] != null &&
              _visitorData['vehicle_number'].toString().isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.directions_car,
                label: "Vehicle Number",
                value: _visitorData['vehicle_number']),
          ],
          if (_visitorData['id_card_number'] != null &&
              _visitorData['id_card_number'].toString().isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.badge,
                label: "ID Card Number",
                value: _visitorData['id_card_number']),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_today, size: 20, color: Colors.orange),
              SizedBox(width: 8),
              Text("Visit Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow(
              icon: Icons.login,
              label: "Designated Check-in",
              value: _formatDateTime(_visitorData['designated_check_in'])),
          const SizedBox(height: 16),
          _buildInfoRow(
              icon: Icons.logout,
              label: "Designated Check-out",
              value: _formatDateTime(_visitorData['designated_check_out'])),
          if (_visitorData['purpose_of_visit'] != null &&
              _visitorData['purpose_of_visit'].toString().isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.info_outline,
                label: "Purpose",
                value: _visitorData['purpose_of_visit']),
          ],
          if (_visitorData['host_department'] != null &&
              _visitorData['host_department'].toString().isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.business_center,
                label: "Host Department",
                value: _visitorData['host_department']),
          ],
          if (_visitorData['meeting_room'] != null &&
              _visitorData['meeting_room'].toString().isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.meeting_room,
                label: "Meeting Room",
                value: _visitorData['meeting_room']),
          ],
          if (_visitorData['actual_check_in'] != null) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.check_circle,
                label: "Actual Check-in",
                value: _formatDateTime(_visitorData['actual_check_in']),
                valueColor: Colors.green),
          ],
          if (_visitorData['actual_check_out'] != null) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
                icon: Icons.check_circle_outline,
                label: "Actual Check-out",
                value: _formatDateTime(_visitorData['actual_check_out']),
                valueColor: Colors.orange),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionApprovalSummaryCard() {
    List<dynamic> sections = _visitorData['section_approval_summary'] ?? [];

    if (sections.isEmpty) return const SizedBox.shrink();

    int totalSections = sections.length;
    int approvedSections =
        sections.where((s) => s['approval_status'] == 'approved').length;
    int pendingSections =
        sections.where((s) => s['approval_status'] == 'pending').length;
    int rejectedSections =
        sections.where((s) => s['approval_status'] == 'rejected').length;
    int partiallyApproved = sections
        .where((s) => s['approval_status'] == 'partially_approved')
        .length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isSectionDetailsExpanded = !_isSectionDetailsExpanded;
                if (!_isSectionDetailsExpanded) {
                  for (int i = 0; i < sections.length; i++) {
                    _expandedSections[i] = false;
                  }
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_city, size: 20, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text("Section Access Summary",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(
                    _isSectionDetailsExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: Colors.indigo),
              ],
            ),
          ),
          const Divider(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withOpacity(0.2)),
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                    label: 'Total Sections',
                    value: totalSections.toString(),
                    color: Colors.blue),
                _buildSummaryItem(
                    label: 'Approved',
                    value: approvedSections.toString(),
                    color: Colors.green),
                if (partiallyApproved > 0)
                  _buildSummaryItem(
                      label: 'Partial',
                      value: partiallyApproved.toString(),
                      color: Colors.blue),
                if (pendingSections > 0)
                  _buildSummaryItem(
                      label: 'Pending',
                      value: pendingSections.toString(),
                      color: Colors.orange),
                if (rejectedSections > 0)
                  _buildSummaryItem(
                      label: 'Rejected',
                      value: rejectedSections.toString(),
                      color: Colors.red),
              ],
            ),
          ),
          if (_isSectionDetailsExpanded) ...[
            const SizedBox(height: 20),
            const Text("Section Details",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...List.generate(sections.length,
                (index) => _buildSectionDetailCard(sections[index], index)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionDetailCard(Map<String, dynamic> section, int index) {
    String approvalStatus = section['approval_status'] ?? 'pending';
    String trackingStatus = section['tracking_status'] ?? 'pending';
    bool isAccessible = approvalStatus == 'approved';
    bool isSiteCheckedIn = _visitorData['status'] == 'checked_in';
    bool isActiveSection = _activeSectionId == section['section_id'];
    bool isAnySectionActive = _activeSectionId != null;

    // Conditions for showing buttons
    bool canCheckIn = isAccessible &&
        isSiteCheckedIn &&
        !isActiveSection &&
        !isAnySectionActive &&
        trackingStatus != 'completed';
    bool canCheckOut =
        isAccessible && isActiveSection && trackingStatus == 'in_progress';
    bool isDisabledDueToOtherActive = isAccessible &&
        isSiteCheckedIn &&
        isAnySectionActive &&
        !isActiveSection;

    bool isLoading = _sectionActionLoading[index] ?? false;

    Color statusColor = approvalStatus == 'approved'
        ? Colors.green
        : (approvalStatus == 'rejected'
            ? Colors.red
            : (approvalStatus == 'partially_approved'
                ? Colors.blue
                : Colors.orange));

    IconData statusIcon = approvalStatus == 'approved'
        ? Icons.check_circle
        : (approvalStatus == 'rejected'
            ? Icons.cancel
            : (approvalStatus == 'partially_approved'
                ? Icons.pending_actions
                : Icons.pending));

    bool consensusReached = section['consensus_reached'] ?? false;
    int totalApprovers = section['total_approvers'] ?? 0;
    int approvedCount = section['approved_count'] ?? 0;
    int pendingCount = section['pending_count'] ?? 0;
    int rejectedCount = section['rejected_count'] ?? 0;
    List<dynamic> approversDetails = section['approvers_details'] ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[index] = !(_expandedSections[index] ?? false);
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(statusIcon, color: statusColor, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    section['section_name'] ??
                                        'Unknown Section',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                if (isActiveSection)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'ACTIVE',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                                '${section['location_name'] ?? 'Unknown Location'} • ${section['section_code'] ?? ''}',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                            approvalStatus.toUpperCase().replaceAll('_', ' '),
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: statusColor)),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                          (_expandedSections[index] ?? false)
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: Colors.grey[600]),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildApproverStat('Total', totalApprovers, Colors.blue),
                      _buildApproverStat(
                          'Approved', approvedCount, Colors.green),
                      if (pendingCount > 0)
                        _buildApproverStat(
                            'Pending', pendingCount, Colors.orange),
                      if (rejectedCount > 0)
                        _buildApproverStat(
                            'Rejected', rejectedCount, Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_expandedSections[index] ?? false) ...[
            const Divider(height: 1, indent: 16, endIndent: 16),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Check-in/out buttons
                  if (isAccessible)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          if (canCheckIn)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () => _sectionCheckIn(
                                        section['section_id'],
                                        section['section_name'],
                                        index),
                                icon: isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2))
                                    : const Icon(Icons.login, size: 16),
                                label: const Text('Check In'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          if (canCheckOut)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () => _sectionCheckOut(
                                        section['section_id'],
                                        section['section_name'],
                                        index),
                                icon: isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2))
                                    : const Icon(Icons.logout, size: 16),
                                label: const Text('Check Out'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          if (isDisabledDueToOtherActive)
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Check out active section first',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                  if (!isSiteCheckedIn &&
                      isAccessible &&
                      trackingStatus != 'completed')
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 14, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Please check in to the site first to access sections',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (approvalStatus == 'partially_approved')
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 14, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Section partially approved - waiting for other approver(s)',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (!consensusReached && approvalStatus == 'pending') ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 14, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Waiting for all approvers to respond',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (approversDetails.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text('Approvers Details:',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...approversDetails
                        .map((approver) => _buildApproverDetail(approver)),
                  ],

                  if (trackingStatus != 'pending') ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tracking Status:',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                  section['checked_in'] == true
                                      ? Icons.check_circle
                                      : Icons.pending,
                                  size: 14,
                                  color: section['checked_in'] == true
                                      ? Colors.green
                                      : Colors.orange),
                              const SizedBox(width: 6),
                              Text(trackingStatus.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: section['checked_in'] == true
                                          ? Colors.green
                                          : Colors.orange,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          if (section['check_in_time'] != null) ...[
                            const SizedBox(height: 4),
                            Text(
                                'Check-in: ${_formatDateTime(section['check_in_time'])}',
                                style: const TextStyle(fontSize: 10)),
                          ],
                          if (section['check_out_time'] != null) ...[
                            const SizedBox(height: 2),
                            Text(
                                'Check-out: ${_formatDateTime(section['check_out_time'])}',
                                style: const TextStyle(fontSize: 10)),
                          ],
                          if ((section['duration_minutes'] ?? 0) > 0) ...[
                            const SizedBox(height: 2),
                            Text(
                                'Duration: ${section['duration_minutes']} minutes',
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmployeeApproversCard() {
    List<dynamic> approvers = _visitorData['approved_by_details'] ?? [];
    if (approvers.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.verified_user, size: 20, color: Colors.green),
            SizedBox(width: 8),
            Text("Employee Approvers",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
          const Divider(height: 24),
          ...approvers.map((approver) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.check_circle,
                            color: Colors.green, size: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(approver['full_name'] ?? 'N/A',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(approver['email'] ?? 'N/A',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600])),
                          if (approver['department'] != null &&
                              approver['department'].toString().isNotEmpty)
                            Text(
                                '${approver['department']} • ${approver['designation'] ?? ''}',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[500])),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildVisitorApprovalsCard() {
    List<dynamic> visitorApprovals = _visitorData['visitor_approvals'] ?? [];
    if (visitorApprovals.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.assignment_turned_in, size: 20, color: Colors.teal),
            SizedBox(width: 8),
            Text("Visitor Approvals",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
          const Divider(height: 24),
          ...visitorApprovals.map((approval) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: approval['status'] == 'approved'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                            approval['status'] == 'approved'
                                ? Icons.check_circle
                                : Icons.pending,
                            size: 18,
                            color: approval['status'] == 'approved'
                                ? Colors.green
                                : Colors.orange)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(approval['approver_name'] ?? 'Unknown',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13)),
                          Text(
                              'Status: ${approval['status']?.toUpperCase() ?? 'PENDING'}',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: approval['status'] == 'approved'
                                      ? Colors.green
                                      : Colors.orange)),
                          if (approval['comments'] != null &&
                              approval['comments'].toString().isNotEmpty)
                            Text(approval['comments'],
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    if (approval['responded_at'] != null)
                      Text(_formatTimeOnly(approval['responded_at']),
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSectionRequestsCard() {
    List<dynamic> sectionRequests = _visitorData['section_requests'] ?? [];
    if (sectionRequests.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.request_page, size: 20, color: Colors.purple),
            SizedBox(width: 8),
            Text("Section Requests",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
          const Divider(height: 24),
          ...sectionRequests.map((request) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.location_on,
                            size: 18, color: Colors.purple)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request['section_name'] ?? 'Unknown Section',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13)),
                          Text(
                              'Requested: ${_formatDateTime(request['requested_at'])}',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[500])),
                          if (request['notes'] != null &&
                              request['notes'].toString().isNotEmpty)
                            Text(request['notes'],
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCreatedByCard() {
    Map<String, dynamic>? createdBy = _visitorData['created_by_details'];
    if (createdBy == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.person_add, size: 20, color: Colors.purple),
            SizedBox(width: 8),
            Text("Created By",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
          const Divider(height: 24),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child:
                      const Icon(Icons.person, color: Colors.purple, size: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(createdBy['full_name'] ?? 'N/A',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(createdBy['email'] ?? 'N/A',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(height: 2),
                    Text(
                        '${createdBy['department'] ?? ''} • ${createdBy['designation'] ?? ''}',
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey[500])),
                    const SizedBox(height: 4),
                    Text(_formatDateTime(_visitorData['created_at']),
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.timeline, size: 20, color: Colors.blue),
            SizedBox(width: 8),
            Text("Timeline",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ]),
          const Divider(height: 24),
          _buildTimelineItem(
              icon: Icons.create,
              title: "Created",
              value: _formatDateTime(_visitorData['created_at']),
              color: Colors.blue),
          if (_visitorData['actual_check_in'] != null) ...[
            const SizedBox(height: 16),
            _buildTimelineItem(
                icon: Icons.login,
                title: "Actual Check-in",
                value: _formatDateTime(_visitorData['actual_check_in']),
                color: Colors.green),
          ],
          if (_visitorData['actual_check_out'] != null) ...[
            const SizedBox(height: 16),
            _buildTimelineItem(
                icon: Icons.logout,
                title: "Actual Check-out",
                value: _formatDateTime(_visitorData['actual_check_out']),
                color: Colors.orange),
          ],
          const SizedBox(height: 16),
          _buildTimelineItem(
              icon: Icons.update,
              title: "Last Updated",
              value: _formatDateTime(_visitorData['updated_at']),
              color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon,
      required String label,
      required String value,
      Color valueColor = Colors.black87}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 14, color: valueColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
      {required IconData icon,
      required String title,
      required String value,
      required Color color}) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: color)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
      {required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildApproverStat(String label, int count, Color color) {
    return Column(
      children: [
        Text(count.toString(),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildApproverDetail(Map<String, dynamic> approver) {
    String status = approver['status'] ?? 'pending';
    Color statusColor = status == 'approved'
        ? Colors.green
        : (status == 'rejected' ? Colors.red : Colors.orange);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6)),
            child: Icon(
                status == 'approved'
                    ? Icons.check
                    : (status == 'rejected' ? Icons.close : Icons.schedule),
                size: 14,
                color: statusColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(approver['approver_name'] ?? 'Unknown',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13)),
                Text(approver['approver_email'] ?? '',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                if (approver['comments'] != null &&
                    approver['comments'].toString().isNotEmpty)
                  Text('Comment: ${approver['comments']}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                if (approver['rejection_reason'] != null &&
                    approver['rejection_reason'].toString().isNotEmpty)
                  Text('Rejection: ${approver['rejection_reason']}',
                      style: const TextStyle(fontSize: 10, color: Colors.red)),
              ],
            ),
          ),
          if (approver['responded_at'] != null)
            Text(_formatTimeOnly(approver['responded_at']),
                style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  String _formatTimeOnly(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'checked_in':
        return Colors.blue;
      case 'checked_out':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending_actions;
      case 'rejected':
        return Icons.cancel;
      case 'checked_in':
        return Icons.login;
      case 'checked_out':
        return Icons.logout;
      default:
        return Icons.info;
    }
  }
}

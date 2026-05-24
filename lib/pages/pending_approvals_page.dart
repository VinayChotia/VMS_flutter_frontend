// // lib/pages/pending_approvals_page.dart

// import 'package:flutter/material.dart';
// import 'package:modernlogintute/services/api_services.dart';
// import 'package:intl/intl.dart';

// class PendingApprovalsPage extends StatefulWidget {
//   const PendingApprovalsPage({super.key});

//   @override
//   State<PendingApprovalsPage> createState() => _PendingApprovalsPageState();
// }

// class _PendingApprovalsPageState extends State<PendingApprovalsPage> {
//   List<dynamic> _pendingApprovals = [];
//   bool _isLoading = true;
//   String? _errorMessage;

//   // Track which visitor's sections are expanded
//   Set<int> _expandedVisitors = {};

//   // Track which section is currently being processed
//   int? _processingVisitorId;
//   int? _processingSectionId;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPendingApprovals();
//   }

//   Future<void> _fetchPendingApprovals() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final token = await ApiService.getAccessToken();
//       if (token == null) {
//         setState(() {
//           _errorMessage = 'Please login to view pending approvals';
//           _isLoading = false;
//         });
//         return;
//       }

//       final response = await ApiService.getMyPendingSectionApprovals();

//       setState(() {
//         _pendingApprovals = response['pending_approvals'] ?? [];
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   // Update the _approveSection method in PendingApprovalsPage
//   Future<void> _approveSection(
//       int visitorId, int sectionId, String sectionName) async {
//     setState(() {
//       _processingVisitorId = visitorId;
//       _processingSectionId = sectionId;
//     });

//     try {
//       final response = await ApiService.approveSection(
//           visitorId, sectionId, 'approved',
//           comments: 'Approved');

//       // Check for success in response
//       if (response['success'] == true || response['visitor_status'] != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('✅ Approved: $sectionName'),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 2),
//           ),
//         );

//         // Refresh the list
//         await _fetchPendingApprovals();
//       } else {
//         _showError(response['message'] ??
//             response['error'] ??
//             'Failed to approve section');
//       }
//     } catch (e) {
//       _showError('Error approving section: ${e.toString()}');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _processingVisitorId = null;
//           _processingSectionId = null;
//         });
//       }
//     }
//   }

// // Update the _rejectSection method
//   Future<void> _rejectSection(
//       int visitorId, int sectionId, String sectionName) async {
//     final TextEditingController reasonController = TextEditingController();

//     final result = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Reject Section'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Are you sure you want to reject access to "$sectionName"?'),
//             const SizedBox(height: 16),
//             TextField(
//               controller: reasonController,
//               decoration: const InputDecoration(
//                 hintText: 'Reason for rejection',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Reject'),
//           ),
//         ],
//       ),
//     );

//     if (result == true) {
//       setState(() {
//         _processingVisitorId = visitorId;
//         _processingSectionId = sectionId;
//       });

//       try {
//         final rejectionReason = reasonController.text.trim();
//         final comments = rejectionReason.isNotEmpty
//             ? rejectionReason
//             : 'Rejected by approver';

//         final response = await ApiService.approveSection(
//             visitorId, sectionId, 'rejected',
//             comments: comments);

//         if (response['success'] == true || response['visitor_status'] != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('❌ Rejected: $sectionName'),
//               backgroundColor: Colors.orange,
//               duration: const Duration(seconds: 2),
//             ),
//           );

//           await _fetchPendingApprovals();
//         } else {
//           _showError(response['message'] ??
//               response['error'] ??
//               'Failed to reject section');
//         }
//       } catch (e) {
//         _showError('Error rejecting section: ${e.toString()}');
//       } finally {
//         if (mounted) {
//           setState(() {
//             _processingVisitorId = null;
//             _processingSectionId = null;
//           });
//         }
//       }
//     }
//     reasonController.dispose();
//   }

//   // Future<void> _approveSection(int visitorId, int sectionId, String sectionName) async {
//   //   setState(() {
//   //     _processingVisitorId = visitorId;
//   //     _processingSectionId = sectionId;
//   //   });

//   //   try {
//   //     final response = await ApiService.approveSection(visitorId, sectionId, 'approved');

//   //     if (response['success'] == true) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text('✅ Approved: $sectionName'),
//   //           backgroundColor: Colors.green,
//   //           duration: const Duration(seconds: 2),
//   //         ),
//   //       );

//   //       // Refresh the list
//   //       await _fetchPendingApprovals();
//   //     } else {
//   //       _showError(response['message'] ?? 'Failed to approve section');
//   //     }
//   //   } catch (e) {
//   //     _showError('Error approving section: $e');
//   //   } finally {
//   //     setState(() {
//   //       _processingVisitorId = null;
//   //       _processingSectionId = null;
//   //     });
//   //   }
//   // }

//   // Future<void> _rejectSection(int visitorId, int sectionId, String sectionName) async {
//   //   final TextEditingController reasonController = TextEditingController();

//   //   final result = await showDialog<bool>(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Reject Section'),
//   //       content: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //           Text('Are you sure you want to reject access to "$sectionName"?'),
//   //           const SizedBox(height: 16),
//   //           TextField(
//   //             controller: reasonController,
//   //             decoration: const InputDecoration(
//   //               hintText: 'Reason for rejection (optional)',
//   //               border: OutlineInputBorder(),
//   //             ),
//   //             maxLines: 3,
//   //           ),
//   //         ],
//   //       ),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context, false),
//   //           child: const Text('Cancel'),
//   //         ),
//   //         ElevatedButton(
//   //           style: ElevatedButton.styleFrom(
//   //             backgroundColor: Colors.red,
//   //             foregroundColor: Colors.white,
//   //           ),
//   //           onPressed: () => Navigator.pop(context, true),
//   //           child: const Text('Reject'),
//   //         ),
//   //       ],
//   //     ),
//   //   );

//   //   if (result == true) {
//   //     setState(() {
//   //       _processingVisitorId = visitorId;
//   //       _processingSectionId = sectionId;
//   //     });

//   //     try {
//   //       final response = await ApiService.approveSection(
//   //         visitorId,
//   //         sectionId,
//   //         'rejected',
//   //         comments: reasonController.text
//   //       );

//   //       if (response['success'] == true) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text('❌ Rejected: $sectionName'),
//   //             backgroundColor: Colors.orange,
//   //             duration: const Duration(seconds: 2),
//   //           ),
//   //         );

//   //         await _fetchPendingApprovals();
//   //       } else {
//   //         _showError(response['message'] ?? 'Failed to reject section');
//   //       }
//   //     } catch (e) {
//   //       _showError('Error rejecting section: $e');
//   //     } finally {
//   //       setState(() {
//   //         _processingVisitorId = null;
//   //         _processingSectionId = null;
//   //       });
//   //     }
//   //   }
//   // }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//   }

//   String _formatDateTime(DateTime? dateTime) {
//     if (dateTime == null) return 'Not set';
//     return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
//   }

//   void _toggleExpanded(int visitorId) {
//     setState(() {
//       if (_expandedVisitors.contains(visitorId)) {
//         _expandedVisitors.remove(visitorId);
//       } else {
//         _expandedVisitors.add(visitorId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Pending Approvals",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: _fetchPendingApprovals,
//             tooltip: 'Refresh',
//           ),
//         ],
//       ),
//       body: _buildBody(),
//     );
//   }

//   Widget _buildBody() {
//     if (_isLoading) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text('Loading pending approvals...'),
//           ],
//         ),
//       );
//     }

//     if (_errorMessage != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//             const SizedBox(height: 16),
//             Text(
//               _errorMessage!,
//               style: const TextStyle(color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _fetchPendingApprovals,
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_pendingApprovals.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.check_circle_outline,
//                 size: 80, color: Colors.green[300]),
//             const SizedBox(height: 16),
//             const Text(
//               'No Pending Approvals',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'All visitor requests have been processed',
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _pendingApprovals.length,
//       itemBuilder: (context, index) {
//         final approval = _pendingApprovals[index];
//         return _VisitorApprovalCard(
//           approval: approval,
//           isExpanded: _expandedVisitors.contains(approval['visitor_id']),
//           onToggleExpand: () => _toggleExpanded(approval['visitor_id']),
//           onApproveSection: (sectionId, sectionName) =>
//               _approveSection(approval['visitor_id'], sectionId, sectionName),
//           onRejectSection: (sectionId, sectionName) =>
//               _rejectSection(approval['visitor_id'], sectionId, sectionName),
//           isProcessing: _processingVisitorId == approval['visitor_id'],
//           processingSectionId: _processingSectionId,
//           formatDateTime: _formatDateTime,
//         );
//       },
//     );
//   }
// }

// class _VisitorApprovalCard extends StatelessWidget {
//   final dynamic approval;
//   final bool isExpanded;
//   final VoidCallback onToggleExpand;
//   final Function(int, String) onApproveSection;
//   final Function(int, String) onRejectSection;
//   final bool isProcessing;
//   final int? processingSectionId;
//   final String Function(DateTime?) formatDateTime;

//   const _VisitorApprovalCard({
//     required this.approval,
//     required this.isExpanded,
//     required this.onToggleExpand,
//     required this.onApproveSection,
//     required this.onRejectSection,
//     required this.isProcessing,
//     required this.processingSectionId,
//     required this.formatDateTime,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final visitorName = approval['visitor_name'] ?? 'Unknown';
//     final companyName = approval['company_name'] ?? '';
//     final purpose = approval['purpose_of_visit'] ?? '';
//     final siteName = approval['site_name'] ?? 'N/A';
//     final createdBy = approval['created_by'] ?? 'Unknown';
//     final createdAt = approval['created_at'] != null
//         ? DateTime.tryParse(approval['created_at'])
//         : null;

//     final myProgress = approval['my_progress'] ?? {};
//     final totalPending = myProgress['pending'] ?? 0;
//     final totalApproved = myProgress['approved'] ?? 0;
//     final totalSections = myProgress['total_sections'] ?? 0;
//     final isCompleted = myProgress['completed'] ?? false;

//     final otherApprover = approval['other_approver'] ?? {};
//     final otherApproverName = otherApprover['name'] ?? 'Unknown';
//     final otherApprovedCount = otherApprover['approved_count'] ?? 0;

//     final pendingSections =
//         List<dynamic>.from(approval['pending_sections'] ?? []);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           InkWell(
//             onTap: onToggleExpand,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       // Visitor Avatar
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Center(
//                           child: Text(
//                             visitorName.isNotEmpty
//                                 ? visitorName[0].toUpperCase()
//                                 : 'V',
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               visitorName,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             if (companyName.isNotEmpty)
//                               Text(
//                                 companyName,
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 Icon(Icons.location_on,
//                                     size: 12, color: Colors.grey[500]),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   siteName,
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.grey[600]),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Icon(Icons.person_outline,
//                                     size: 12, color: Colors.grey[500]),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   'By: $createdBy',
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.grey[600]),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Progress indicator
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: isCompleted
//                               ? Colors.green.shade50
//                               : Colors.orange.shade50,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           isCompleted ? 'Completed' : '${totalPending} pending',
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: isCompleted
//                                 ? Colors.green.shade700
//                                 : Colors.orange.shade700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   // Visit details
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Row(
//                           children: [
//                             Icon(Icons.calendar_today,
//                                 size: 12, color: Colors.grey[500]),
//                             const SizedBox(width: 4),
//                             Text(
//                               formatDateTime(
//                                   approval['designated_check_in'] != null
//                                       ? DateTime.tryParse(
//                                           approval['designated_check_in'])
//                                       : null),
//                               style: TextStyle(
//                                   fontSize: 11, color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Row(
//                           children: [
//                             Icon(Icons.access_time,
//                                 size: 12, color: Colors.grey[500]),
//                             const SizedBox(width: 4),
//                             Text(
//                               formatDateTime(
//                                   approval['designated_check_out'] != null
//                                       ? DateTime.tryParse(
//                                           approval['designated_check_out'])
//                                       : null),
//                               style: TextStyle(
//                                   fontSize: 11, color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (purpose.isNotEmpty) ...[
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.info_outline,
//                             size: 12, color: Colors.grey[500]),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             purpose,
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[700]),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                   const SizedBox(height: 12),
//                   // Progress bar
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(4),
//                           child: LinearProgressIndicator(
//                             value: totalSections > 0
//                                 ? totalApproved / totalSections
//                                 : 0,
//                             backgroundColor: Colors.grey[200],
//                             color: Colors.blue,
//                             minHeight: 6,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         '$totalApproved/$totalSections',
//                         style: const TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   // Other approver status
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.people_outline,
//                             size: 12, color: Colors.grey[600]),
//                         const SizedBox(width: 4),
//                         Text(
//                           'Other Approver: $otherApproverName • $otherApprovedCount/${totalSections} approved',
//                           style:
//                               TextStyle(fontSize: 11, color: Colors.grey[700]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         isExpanded ? 'Tap to collapse' : 'Tap to expand',
//                         style: TextStyle(fontSize: 11, color: Colors.grey[500]),
//                       ),
//                       Icon(
//                         isExpanded ? Icons.expand_less : Icons.expand_more,
//                         size: 18,
//                         color: Colors.grey[500],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Expanded Sections
//           if (isExpanded && pendingSections.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(bottom: 12),
//                     child: Text(
//                       'Sections Pending Your Approval',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   ...pendingSections.map((section) => _SectionApprovalTile(
//                         section: section,
//                         onApprove: () =>
//                             onApproveSection(section['id'], section['name']),
//                         onReject: () =>
//                             onRejectSection(section['id'], section['name']),
//                         isLoading: isProcessing &&
//                             processingSectionId == section['id'],
//                       )),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _SectionApprovalTile extends StatelessWidget {
//   final dynamic section;
//   final VoidCallback onApprove;
//   final VoidCallback onReject;
//   final bool isLoading;

//   const _SectionApprovalTile({
//     required this.section,
//     required this.onApprove,
//     required this.onReject,
//     required this.isLoading,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final sectionName = section['name'] ?? 'Unknown';
//     final location = section['location'] ?? '';
//     final requiresEscort = section['requires_escort'] ?? false;
//     final sectionType = section['section_type'] ?? '';

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   requiresEscort ? Icons.security : Icons.location_on,
//                   size: 20,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       sectionName,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     if (location.isNotEmpty)
//                       Text(
//                         location,
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     if (sectionType.isNotEmpty)
//                       Container(
//                         margin: const EdgeInsets.only(top: 4),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 6, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           sectionType,
//                           style:
//                               TextStyle(fontSize: 10, color: Colors.grey[700]),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               if (requiresEscort)
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade50,
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(color: Colors.orange.shade200),
//                   ),
//                   child: Text(
//                     'Escort Required',
//                     style:
//                         TextStyle(fontSize: 9, color: Colors.orange.shade700),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: isLoading ? null : onReject,
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.red,
//                     side: const BorderSide(color: Colors.red),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : const Text('Reject'),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : onApprove,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Colors.white,
//                           ),
//                         )
//                       : const Text('Approve'),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modernlogintute/services/api_services.dart';
import 'package:intl/intl.dart';

const String baseUrl = 'https://vms-backend-drf-new.azurewebsites.net';

class PendingApprovalsPage extends StatefulWidget {
  const PendingApprovalsPage({super.key});

  @override
  State<PendingApprovalsPage> createState() => _PendingApprovalsPageState();
}

class _PendingApprovalsPageState extends State<PendingApprovalsPage> {
  List<dynamic> _pendingApprovals = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Track which visitor's sections are expanded
  Set<int> _expandedVisitors = {};

  // Track which section is currently being processed
  int? _processingVisitorId;
  int? _processingSectionId;

  @override
  void initState() {
    super.initState();
    _fetchPendingApprovals();
  }

  Future<void> _fetchPendingApprovals() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await ApiService.getAccessToken();
      if (token == null) {
        setState(() {
          _errorMessage = 'Please login to view pending approvals';
          _isLoading = false;
        });
        return;
      }

      final response = await ApiService.getMyPendingSectionApprovals();

      setState(() {
        _pendingApprovals = response['pending_approvals'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Helper method to get full image URL
  String _getFullImageUrl(String? photoPath) {
    if (photoPath == null || photoPath.isEmpty) return '';
    // If it's already a full URL, return as is
    if (photoPath.startsWith('http')) return photoPath;
    // Otherwise, prepend the base URL
    if (photoPath.startsWith('/')) {
      return '$baseUrl$photoPath';
    } else {
      return '$baseUrl/$photoPath';
    }
  }

  Future<void> _approveSection(
      int visitorId, int sectionId, String sectionName) async {
    setState(() {
      _processingVisitorId = visitorId;
      _processingSectionId = sectionId;
    });

    try {
      final response = await ApiService.approveSection(
          visitorId, sectionId, 'approved',
          comments: 'Approved');

      if (response['success'] == true || response['visitor_status'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Approved: $sectionName'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        await _fetchPendingApprovals();
      } else {
        _showError(response['message'] ??
            response['error'] ??
            'Failed to approve section');
      }
    } catch (e) {
      _showError('Error approving section: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _processingVisitorId = null;
          _processingSectionId = null;
        });
      }
    }
  }

  Future<void> _rejectSection(
      int visitorId, int sectionId, String sectionName) async {
    final TextEditingController reasonController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Section'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to reject access to "$sectionName"?'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Reason for rejection',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        _processingVisitorId = visitorId;
        _processingSectionId = sectionId;
      });

      try {
        final rejectionReason = reasonController.text.trim();
        final comments = rejectionReason.isNotEmpty
            ? rejectionReason
            : 'Rejected by approver';

        final response = await ApiService.approveSection(
            visitorId, sectionId, 'rejected',
            comments: comments);

        if (response['success'] == true || response['visitor_status'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Rejected: $sectionName'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
            ),
          );

          await _fetchPendingApprovals();
        } else {
          _showError(response['message'] ??
              response['error'] ??
              'Failed to reject section');
        }
      } catch (e) {
        _showError('Error rejecting section: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() {
            _processingVisitorId = null;
            _processingSectionId = null;
          });
        }
      }
    }
    reasonController.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 'Not set';
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  void _toggleExpanded(int visitorId) {
    setState(() {
      if (_expandedVisitors.contains(visitorId)) {
        _expandedVisitors.remove(visitorId);
      } else {
        _expandedVisitors.add(visitorId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Pending Approvals",
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
            onPressed: _fetchPendingApprovals,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading pending approvals...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchPendingApprovals,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_pendingApprovals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline,
                size: 80, color: Colors.green[300]),
            const SizedBox(height: 16),
            const Text(
              'No Pending Approvals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'All visitor requests have been processed',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pendingApprovals.length,
      itemBuilder: (context, index) {
        final approval = _pendingApprovals[index];
        return _VisitorApprovalCard(
          approval: approval,
          isExpanded: _expandedVisitors.contains(approval['visitor_id']),
          onToggleExpand: () => _toggleExpanded(approval['visitor_id']),
          onApproveSection: (sectionId, sectionName) =>
              _approveSection(approval['visitor_id'], sectionId, sectionName),
          onRejectSection: (sectionId, sectionName) =>
              _rejectSection(approval['visitor_id'], sectionId, sectionName),
          isProcessing: _processingVisitorId == approval['visitor_id'],
          processingSectionId: _processingSectionId,
          formatDateTime: _formatDateTime,
          getFullImageUrl: _getFullImageUrl,
        );
      },
    );
  }
}

class _VisitorApprovalCard extends StatelessWidget {
  final dynamic approval;
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final Function(int, String) onApproveSection;
  final Function(int, String) onRejectSection;
  final bool isProcessing;
  final int? processingSectionId;
  final String Function(String?) formatDateTime;
  final String Function(String?) getFullImageUrl;

  const _VisitorApprovalCard({
    required this.approval,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.onApproveSection,
    required this.onRejectSection,
    required this.isProcessing,
    required this.processingSectionId,
    required this.formatDateTime,
    required this.getFullImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final visitorName = approval['visitor_name'] ?? 'Unknown';
    final visitorEmail = approval['visitor_email'] ?? '';
    final visitorPhone = approval['visitor_phone'] ?? '';
    final companyName = approval['company_name'] ?? '';
    final purpose = approval['purpose_of_visit'] ?? '';
    final siteName = approval['site_name'] ?? 'N/A';
    final createdBy = approval['created_by'] ?? 'Unknown';
    final visitorPhoto = approval['visitor_photo']; // Use visitor_photo field
    final overallStatus = approval['overall_status'] ?? 'pending';
    final approvalMode = approval['approval_mode'] ?? 'consensus_based';
    final consensusRule = approval['consensus_rule'] ?? '';

    final myProgress = approval['my_progress'] ?? {};
    final totalPending = myProgress['pending'] ?? 0;
    final totalApproved = myProgress['approved'] ?? 0;
    final totalSections = myProgress['total_sections'] ?? 0;
    final isCompleted = myProgress['completed'] ?? false;

    final otherApprover = approval['other_approver'] ?? {};
    final otherApproverName = otherApprover['name'] ?? 'Unknown';
    final otherApprovedCount = otherApprover['approved_count'] ?? 0;

    final pendingSections =
        List<dynamic>.from(approval['pending_sections'] ?? []);

    // Get full image URL
    final fullImageUrl = getFullImageUrl(visitorPhoto);

    print('Visitor: $visitorName, Photo URL: $fullImageUrl'); // Debug print

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Header
          InkWell(
            onTap: onToggleExpand,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Visitor Avatar with Photo
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: fullImageUrl.isNotEmpty
                              ? Image.network(
                                  fullImageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    print(
                                        'Error loading image for $visitorName: $error');
                                    return Center(
                                      child: Text(
                                        visitorName.isNotEmpty
                                            ? visitorName[0].toUpperCase()
                                            : 'V',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    visitorName.isNotEmpty
                                        ? visitorName[0].toUpperCase()
                                        : 'V',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              visitorName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (visitorEmail.isNotEmpty)
                              Text(
                                visitorEmail,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            if (visitorPhone.isNotEmpty)
                              Text(
                                visitorPhone,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 12, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  siteName,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600]),
                                ),
                                const SizedBox(width: 12),
                                Icon(Icons.person_outline,
                                    size: 12, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  'By: $createdBy',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Status indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: overallStatus == 'pending'
                              ? Colors.orange.shade50
                              : overallStatus == 'approved'
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          overallStatus.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: overallStatus == 'pending'
                                ? Colors.orange.shade700
                                : overallStatus == 'approved'
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Visit details - Check-in/Check-out
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 12, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Text(
                              'Check-in: ${formatDateTime(approval['designated_check_in'])}',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 12, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Text(
                              'Check-out: ${formatDateTime(approval['designated_check_out'])}',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (companyName.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.business, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            companyName,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (purpose.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            purpose,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  // Approval Mode Info
                  if (consensusRule.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 12, color: Colors.blue.shade700),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              consensusRule,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: totalSections > 0
                                ? totalApproved / totalSections
                                : 0,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$totalApproved/$totalSections',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Other approver status
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.people_outline,
                            size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Other Approver: $otherApproverName • $otherApprovedCount/$totalSections approved',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isExpanded ? 'Tap to collapse' : 'Tap to expand',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expanded Sections
          if (isExpanded && pendingSections.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Sections Pending Your Approval',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ...pendingSections.map((section) => _SectionApprovalTile(
                        section: section,
                        onApprove: () =>
                            onApproveSection(section['id'], section['name']),
                        onReject: () =>
                            onRejectSection(section['id'], section['name']),
                        isLoading: isProcessing &&
                            processingSectionId == section['id'],
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionApprovalTile extends StatelessWidget {
  final dynamic section;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final bool isLoading;

  const _SectionApprovalTile({
    required this.section,
    required this.onApprove,
    required this.onReject,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final sectionName = section['name'] ?? 'Unknown';
    final sectionCode = section['code'] ?? '';
    final location = section['location'] ?? '';
    final requiresEscort = section['requires_escort'] ?? false;
    final sectionType = section['section_type'] ?? '';
    final dailyCapacity = section['daily_capacity'] ?? 0;
    final currentOccupancy = section['current_occupancy'] ?? 0;
    final availableSpots = dailyCapacity - currentOccupancy;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  requiresEscort ? Icons.security : Icons.location_on,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sectionName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (sectionCode.isNotEmpty)
                      Text(
                        'Code: $sectionCode',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                    if (location.isNotEmpty)
                      Text(
                        location,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    if (sectionType.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          sectionType,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                        ),
                      ),
                    if (availableSpots > 0)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Available: $availableSpots/$dailyCapacity spots',
                          style: TextStyle(
                            fontSize: 10,
                            color: availableSpots > 10
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (requiresEscort)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Text(
                    'Escort Required',
                    style:
                        TextStyle(fontSize: 9, color: Colors.orange.shade700),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isLoading ? null : onReject,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Reject'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: isLoading ? null : onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

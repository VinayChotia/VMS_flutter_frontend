// // import 'dart:convert';
// // import 'dart:js_interop';
// // import 'package:flutter/material.dart';
// // import 'package:mobile_scanner/mobile_scanner.dart';
// // import 'package:modernlogintute/pages/visitor_view.dart';
// // import 'package:modernlogintute/services/api_services.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:web/web.dart' as web;

// // class QRScannerPage extends StatefulWidget {
// //   const QRScannerPage({super.key});

// //   @override
// //   State<QRScannerPage> createState() => _QRScannerPageState();
// // }

// // class _QRScannerPageState extends State<QRScannerPage> {
// //   MobileScannerController? _scannerController;
// //   bool _isProcessing = false;
// //   bool _hasPermission = false;
// //   bool _isCheckingPermission = true;
// //   String? _permissionError;
// //   bool _isPermanentlyDenied = false;

// //   // Camera switching state
// //   CameraFacing _currentCameraFacing = CameraFacing.back;
// //   bool _isSwitchingCamera = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _requestCameraPermission();
// //   }

// //   @override
// //   void dispose() {
// //     _scannerController?.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _requestCameraPermission() async {
// //     setState(() {
// //       _isCheckingPermission = true;
// //       _permissionError = null;
// //       _isPermanentlyDenied = false;
// //     });

// //     if (kIsWeb) {
// //       await _requestWebCameraPermission();
// //     } else {
// //       await _requestMobileCameraPermission();
// //     }

// //     setState(() {
// //       _isCheckingPermission = false;
// //     });
// //   }

// //   Future<void> _requestWebCameraPermission() async {
// //     final result = await _requestWebCameraWithFacingMode();

// //     if (result == 'granted') {
// //       _scannerController = MobileScannerController(
// //         facing: _currentCameraFacing,
// //         torchEnabled: false,
// //       );
// //       setState(() => _hasPermission = true);
// //     } else if (result == 'denied_permanently') {
// //       setState(() {
// //         _hasPermission = false;
// //         _isPermanentlyDenied = true;
// //         _permissionError =
// //             'Camera access is blocked. Click the camera icon in your browser\'s address bar to allow access, then retry.';
// //       });
// //     } else {
// //       setState(() {
// //         _hasPermission = false;
// //         _isPermanentlyDenied = false;
// //         _permissionError =
// //             'Camera permission was denied. Please allow camera access to scan QR codes.';
// //       });
// //     }
// //   }

// //   Future<String> _requestWebCameraWithFacingMode() async {
// //     try {
// //       final facingMode = _currentCameraFacing == CameraFacing.front ? 'user' : 'environment';
// //       final constraints = web.MediaStreamConstraints(
// //         video: web.MediaTrackConstraints(facingMode: facingMode.toJS).toJS,
// //       );
// //       final stream = await web.window.navigator.mediaDevices
// //           .getUserMedia(constraints)
// //           .toDart;

// //       final tracks = stream.getVideoTracks().toDart;
// //       for (final track in tracks) {
// //         track.stop();
// //       }
// //       return 'granted';
// //     } catch (e) {
// //       final error = e.toString();
// //       if (error.contains('NotAllowedError') || error.contains('PermissionDeniedError')) {
// //         return 'denied_permanently';
// //       }
// //       if (error.contains('OverconstrainedError')) {
// //         // Fallback to default camera
// //         try {
// //           final constraints = web.MediaStreamConstraints(video: true.toJS);
// //           final stream = await web.window.navigator.mediaDevices
// //               .getUserMedia(constraints)
// //               .toDart;
// //           final tracks = stream.getVideoTracks().toDart;
// //           for (final track in tracks) {
// //             track.stop();
// //           }
// //           return 'granted';
// //         } catch (_) {
// //           return 'denied';
// //         }
// //       }
// //       return 'denied';
// //     }
// //   }

// //   Future<void> _requestMobileCameraPermission() async {
// //     final status = await Permission.camera.status;

// //     if (status.isGranted) {
// //       _scannerController = MobileScannerController(
// //         facing: _currentCameraFacing,
// //       );
// //       setState(() => _hasPermission = true);
// //       return;
// //     }

// //     if (status.isPermanentlyDenied) {
// //       setState(() {
// //         _hasPermission = false;
// //         _isPermanentlyDenied = true;
// //         _permissionError =
// //             'Camera permission is permanently denied. Please enable it from app settings.';
// //       });
// //       return;
// //     }

// //     final result = await Permission.camera.request();

// //     if (result.isGranted) {
// //       _scannerController = MobileScannerController(
// //         facing: _currentCameraFacing,
// //       );
// //       setState(() => _hasPermission = true);
// //     } else if (result.isPermanentlyDenied) {
// //       setState(() {
// //         _hasPermission = false;
// //         _isPermanentlyDenied = true;
// //         _permissionError =
// //             'Camera permission is permanently denied. Please enable it from app settings.';
// //       });
// //     } else {
// //       setState(() {
// //         _hasPermission = false;
// //         _isPermanentlyDenied = false;
// //         _permissionError =
// //             'Camera permission was denied. Tap "Grant Permission" to try again.';
// //       });
// //     }
// //   }

// //   /// Handles camera switching for both Web and Mobile
// //   Future<void> _switchCamera() async {
// //     if (_isSwitchingCamera) return;

// //     setState(() {
// //       _isSwitchingCamera = true;
// //     });

// //     try {
// //       // Toggle camera facing
// //       final newFacing = _currentCameraFacing == CameraFacing.back
// //           ? CameraFacing.front
// //           : CameraFacing.back;

// //       if (kIsWeb) {
// //         // For Web: Reinitialize the controller with new facing mode
// //         final oldController = _scannerController;
// //         final result = await _requestWebCameraWithFacingModeForSwitch(newFacing);

// //         if (result == 'granted') {
// //           _currentCameraFacing = newFacing;
// //           await oldController?.dispose();
// //           _scannerController = MobileScannerController(
// //             facing: _currentCameraFacing,
// //           );
// //           setState(() {});
// //         } else {
// //           _showErrorDialog('Camera Switch Failed',
// //               'Could not switch to ${newFacing == CameraFacing.front ? 'front' : 'back'} camera. Please check your camera permissions.');
// //         }
// //       } else {
// //         // For Mobile: Use built-in switchCamera
// //         await _scannerController?.switchCamera();
// //         _currentCameraFacing = newFacing;
// //       }
// //     } catch (e) {
// //       _showErrorDialog('Camera Switch Failed',
// //           'Unable to switch camera. Error: ${e.toString()}');
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isSwitchingCamera = false;
// //         });
// //       }
// //     }
// //   }

// //   Future<String> _requestWebCameraWithFacingModeForSwitch(CameraFacing facing) async {
// //     try {
// //       final facingMode = facing == CameraFacing.front ? 'user' : 'environment';
// //       final constraints = web.MediaStreamConstraints(
// //         video: web.MediaTrackConstraints(facingMode: facingMode.toJS).toJS,
// //       );
// //       final stream = await web.window.navigator.mediaDevices
// //           .getUserMedia(constraints)
// //           .toDart;

// //       final tracks = stream.getVideoTracks().toDart;
// //       for (final track in tracks) {
// //         track.stop();
// //       }
// //       return 'granted';
// //     } catch (e) {
// //       return 'denied';
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         title: const Text('Scan QR Code'),
// //         backgroundColor: Colors.black,
// //         foregroundColor: Colors.white,
// //         actions: [
// //           if (_hasPermission) ...[
// //             // Flashlight button (not available on Web for front camera)
// //             if (!kIsWeb || _currentCameraFacing == CameraFacing.back)
// //               IconButton(
// //                 icon: const Icon(Icons.flash_on),
// //                 onPressed: () => _scannerController?.toggleTorch(),
// //               ),
// //             // Camera switch button
// //             IconButton(
// //               icon: _isSwitchingCamera
// //                   ? const SizedBox(
// //                       width: 24,
// //                       height: 24,
// //                       child: CircularProgressIndicator(
// //                         strokeWidth: 2,
// //                         color: Colors.white,
// //                       ),
// //                     )
// //                   : const Icon(Icons.switch_camera),
// //               onPressed: _isSwitchingCamera ? null : _switchCamera,
// //             ),
// //           ],
// //         ],
// //       ),
// //       body: _buildBody(),
// //     );
// //   }

// //   Widget _buildBody() {
// //     if (_isCheckingPermission) {
// //       return const Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CircularProgressIndicator(color: Colors.white),
// //             SizedBox(height: 16),
// //             Text(
// //               'Requesting camera permission...',
// //               style: TextStyle(color: Colors.white),
// //             ),
// //           ],
// //         ),
// //       );
// //     }

// //     if (!_hasPermission) {
// //       return _buildPermissionDeniedUI();
// //     }

// //     return _buildScannerUI();
// //   }

// //   Widget _buildPermissionDeniedUI() {
// //     return Center(
// //       child: Padding(
// //         padding: const EdgeInsets.all(32.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Icon(Icons.no_photography_outlined,
// //                 size: 80, color: Colors.white54),
// //             const SizedBox(height: 24),
// //             const Text(
// //               'Camera Permission Required',
// //               style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 12),
// //             Text(
// //               _permissionError ?? 'Camera access is needed to scan QR codes.',
// //               style: const TextStyle(fontSize: 14, color: Colors.white60),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 32),
// //             if (_isPermanentlyDenied && !kIsWeb)
// //               ElevatedButton.icon(
// //                 onPressed: () => openAppSettings(),
// //                 icon: const Icon(Icons.settings),
// //                 label: const Text('Open App Settings'),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Colors.black,
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //                 ),
// //               )
// //             else if (kIsWeb && _isPermanentlyDenied)
// //               ElevatedButton.icon(
// //                 onPressed: () {
// //                   // Show instructions for web permission
// //                   _showWebPermissionInstructions();
// //                 },
// //                 icon: const Icon(Icons.help_outline),
// //                 label: const Text('How to Allow Camera'),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Colors.black,
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //                 ),
// //               )
// //             else
// //               ElevatedButton.icon(
// //                 onPressed: _requestCameraPermission,
// //                 icon: const Icon(Icons.camera_alt),
// //                 label: const Text('Grant Permission'),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   foregroundColor: Colors.black,
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showWebPermissionInstructions() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: Colors.grey[900],
// //         title: const Text('Allow Camera Access',
// //             style: TextStyle(color: Colors.white)),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'To scan QR codes, you need to allow camera access:',
// //               style: TextStyle(color: Colors.white70),
// //             ),
// //             const SizedBox(height: 16),
// //             Row(
// //               children: [
// //                 const Icon(Icons.lock_clock, color: Colors.white70),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Text(
// //                     'Click the ${kIsWeb && (() { try { return web.window.location.protocol == 'https:'; } catch (_) { return false; } })() ? '🔒 camera icon' : '📷 camera icon'} in your browser\'s address bar',
// //                     style: const TextStyle(color: Colors.white70),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //             Row(
// //               children: [
// //                 const Icon(Icons.settings, color: Colors.white70),
// //                 const SizedBox(width: 12),
// //                 const Expanded(
// //                   child: Text(
// //                     'Select "Allow" from the permission dropdown',
// //                     style: TextStyle(color: Colors.white70),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //             Row(
// //               children: [
// //                 const Icon(Icons.refresh, color: Colors.white70),
// //                 const SizedBox(width: 12),
// //                 const Expanded(
// //                   child: Text(
// //                     'Click "Retry" below after enabling',
// //                     style: TextStyle(color: Colors.white70),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text('Cancel'),
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //               _requestCameraPermission();
// //             },
// //             child: const Text('Retry'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildScannerUI() {
// //     if (_scannerController == null) return const SizedBox.shrink();

// //     return Stack(
// //       children: [
// //         MobileScanner(
// //           controller: _scannerController!,
// //           onDetect: (capture) {
// //             if (_isProcessing) return;
// //             for (final barcode in capture.barcodes) {
// //               if (barcode.rawValue != null) {
// //                 _processQRCode(barcode.rawValue!);
// //                 break;
// //               }
// //             }
// //           },
// //           errorBuilder: (context, error, child) {
// //             return Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Icon(Icons.error_outline, size: 48, color: Colors.red),
// //                   const SizedBox(height: 16),
// //                   const Text(
// //                     'Camera Error',
// //                     style: TextStyle(color: Colors.white, fontSize: 18),
// //                   ),
// //                   Text(
// //                     error.errorCode.toString(),
// //                     style: const TextStyle(color: Colors.white70),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   ElevatedButton(
// //                     onPressed: () => _requestCameraPermission(),
// //                     child: const Text('Retry'),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //         // Dark overlay with transparent cutout
// //         IgnorePointer(
// //           child: CustomPaint(
// //             painter: _OverlayPainter(),
// //             child: const SizedBox.expand(),
// //           ),
// //         ),
// //         // Corner brackets
// //         Center(
// //           child: SizedBox(
// //             width: 280,
// //             height: 280,
// //             child: Stack(
// //               children: [
// //                 Positioned(
// //                     top: 0, left: 0, child: _cornerBracket(topLeft: true)),
// //                 Positioned(
// //                     top: 0, right: 0, child: _cornerBracket(topRight: true)),
// //                 Positioned(
// //                     bottom: 0,
// //                     left: 0,
// //                     child: _cornerBracket(bottomLeft: true)),
// //                 Positioned(
// //                     bottom: 0,
// //                     right: 0,
// //                     child: _cornerBracket(bottomRight: true)),
// //               ],
// //             ),
// //           ),
// //         ),
// //         // Camera facing indicator (shows which camera is active)
// //         Positioned(
// //           top: 60,
// //           right: 16,
// //           child: Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //             decoration: BoxDecoration(
// //               color: Colors.black54,
// //               borderRadius: BorderRadius.circular(20),
// //             ),
// //             child: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Icon(
// //                   _currentCameraFacing == CameraFacing.front
// //                       ? Icons.camera_front
// //                       : Icons.camera_rear,
// //                   size: 16,
// //                   color: Colors.white,
// //                 ),
// //                 const SizedBox(width: 4),
// //                 Text(
// //                   _currentCameraFacing == CameraFacing.front ? 'Front' : 'Back',
// //                   style: const TextStyle(color: Colors.white, fontSize: 12),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //         const Align(
// //           alignment: Alignment(0, 0.65),
// //           child: Text(
// //             'Align QR code within the frame',
// //             style: TextStyle(color: Colors.white70, fontSize: 14),
// //           ),
// //         ),
// //         if (_isProcessing)
// //           Container(
// //             color: Colors.black.withOpacity(0.85),
// //             child: const Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   CircularProgressIndicator(color: Colors.white),
// //                   SizedBox(height: 20),
// //                   Text('Processing QR Code...',
// //                       style: TextStyle(color: Colors.white)),
// //                 ],
// //               ),
// //             ),
// //           ),
// //       ],
// //     );
// //   }

// //   Widget _cornerBracket({
// //     bool topLeft = false,
// //     bool topRight = false,
// //     bool bottomLeft = false,
// //     bool bottomRight = false,
// //   }) {
// //     const len = 30.0;
// //     const thickness = 4.0;
// //     const color = Colors.greenAccent;

// //     return SizedBox(
// //       width: len,
// //       height: len,
// //       child: CustomPaint(
// //         painter: _BracketPainter(
// //           color: color,
// //           thickness: thickness,
// //           topLeft: topLeft,
// //           topRight: topRight,
// //           bottomLeft: bottomLeft,
// //           bottomRight: bottomRight,
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _processQRCode(String qrData) async {
// //     setState(() => _isProcessing = true);
// //     _scannerController?.stop();

// //     try {
// //       final Map<String, dynamic> data = jsonDecode(qrData);

// //       if (data['type'] == 'visitor_checkin') {
// //         final int visitorId = data['visitor_id'];
// //         final token = await ApiService.getAccessToken();

// //         if (token != null) {
// //           if (mounted) {
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => VisitorViewPage(
// //                   visitorId: visitorId,
// //                   fetchData: true,
// //                 ),
// //               ),
// //             );
// //           }
// //         } else {
// //           await ApiService.savePendingVisitorId(visitorId);
// //           if (mounted) Navigator.pushReplacementNamed(context, '/login');
// //         }
// //       } else {
// //         _showErrorDialog('Invalid QR Code',
// //             'This QR code is not a valid visitor check-in code.');
// //       }
// //     } catch (e) {
// //       _showErrorDialog(
// //           'Invalid QR Code', 'Could not parse QR code. Please try again.');
// //     } finally {
// //       if (mounted) {
// //         setState(() => _isProcessing = false);
// //         _scannerController?.start();
// //       }
// //     }
// //   }

// //   void _showErrorDialog(String title, String message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: Colors.grey[900],
// //         title: Text(title, style: const TextStyle(color: Colors.white)),
// //         content: Text(message, style: const TextStyle(color: Colors.white70)),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //               if (mounted) {
// //                 setState(() => _isProcessing = false);
// //                 _scannerController?.start();
// //               }
// //             },
// //             child: const Text('Scan Again', style: TextStyle(color: Colors.white)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ─── Painters ────────────────────────────────────────────────────────────────

// // class _OverlayPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()..color = Colors.black.withOpacity(0.6);
// //     const cutoutSize = 280.0;
// //     final cx = size.width / 2;
// //     final cy = size.height / 2;
// //     final rect = Rect.fromCenter(
// //         center: Offset(cx, cy), width: cutoutSize, height: cutoutSize);
// //     final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

// //     final path = Path()
// //       ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
// //       ..addRRect(rrect)
// //       ..fillType = PathFillType.evenOdd;

// //     canvas.drawPath(path, paint);
// //   }

// //   @override
// //   bool shouldRepaint(_OverlayPainter old) => false;
// // }

// // class _BracketPainter extends CustomPainter {
// //   final Color color;
// //   final double thickness;
// //   final bool topLeft, topRight, bottomLeft, bottomRight;

// //   const _BracketPainter({
// //     required this.color,
// //     required this.thickness,
// //     this.topLeft = false,
// //     this.topRight = false,
// //     this.bottomLeft = false,
// //     this.bottomRight = false,
// //   });

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = color
// //       ..strokeWidth = thickness
// //       ..style = PaintingStyle.stroke
// //       ..strokeCap = StrokeCap.round;

// //     final w = size.width;
// //     final h = size.height;

// //     if (topLeft) {
// //       canvas.drawLine(const Offset(0, 0), Offset(w, 0), paint);
// //       canvas.drawLine(const Offset(0, 0), Offset(0, h), paint);
// //     }
// //     if (topRight) {
// //       canvas.drawLine(Offset(0, 0), Offset(w, 0), paint);
// //       canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
// //     }
// //     if (bottomLeft) {
// //       canvas.drawLine(Offset(0, h), Offset(w, h), paint);
// //       canvas.drawLine(const Offset(0, 0), Offset(0, h), paint);
// //     }
// //     if (bottomRight) {
// //       canvas.drawLine(Offset(0, h), Offset(w, h), paint);
// //       canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(_BracketPainter old) => false;
// // }

// import 'dart:convert';
// import 'dart:js_interop';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:modernlogintute/pages/visitor_view.dart';
// import 'package:modernlogintute/services/api_services.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:web/web.dart' as web;

// class QRScannerPage extends StatefulWidget {
//   const QRScannerPage({super.key});

//   @override
//   State<QRScannerPage> createState() => _QRScannerPageState();
// }

// class _QRScannerPageState extends State<QRScannerPage> {
//   MobileScannerController? _scannerController;
//   bool _isProcessing = false;
//   bool _hasPermission = false;
//   bool _isCheckingPermission = true;
//   String? _permissionError;
//   bool _isPermanentlyDenied = false;

//   // Camera switching state
//   CameraFacing _currentCameraFacing = CameraFacing.back;
//   bool _isSwitchingCamera = false;

//   @override
//   void initState() {
//     super.initState();
//     _requestCameraPermission();
//   }

//   @override
//   void dispose() {
//     _scannerController?.dispose();
//     super.dispose();
//   }

//   Future<void> _requestCameraPermission() async {
//     setState(() {
//       _isCheckingPermission = true;
//       _permissionError = null;
//       _isPermanentlyDenied = false;
//     });

//     if (kIsWeb) {
//       await _requestWebCameraPermission();
//     } else {
//       await _requestMobileCameraPermission();
//     }

//     setState(() {
//       _isCheckingPermission = false;
//     });
//   }

//   Future<void> _requestWebCameraPermission() async {
//     final result = await _requestWebCameraWithFacingMode();

//     if (result == 'granted') {
//       _scannerController = MobileScannerController(
//         facing: _currentCameraFacing,
//         torchEnabled: false,
//       );
//       setState(() => _hasPermission = true);
//     } else if (result == 'denied_permanently') {
//       setState(() {
//         _hasPermission = false;
//         _isPermanentlyDenied = true;
//         _permissionError =
//             'Camera access is blocked. Click the camera icon in your browser\'s address bar to allow access, then retry.';
//       });
//     } else {
//       setState(() {
//         _hasPermission = false;
//         _isPermanentlyDenied = false;
//         _permissionError =
//             'Camera permission was denied. Please allow camera access to scan QR codes.';
//       });
//     }
//   }

//   Future<String> _requestWebCameraWithFacingMode() async {
//     try {
//       final facingMode = _currentCameraFacing == CameraFacing.front ? 'user' : 'environment';

//       // Create constraints for web
//       final constraints = web.MediaStreamConstraints();
//       final videoConstraints = web.MediaTrackConstraints();
//       videoConstraints.facingMode = facingMode.toJS;
//       constraints.video = videoConstraints.toJS;

//       final stream = await web.window.navigator.mediaDevices
//           .getUserMedia(constraints)
//           .toDart;

//       final tracks = stream.getVideoTracks().toDart;
//       for (final track in tracks) {
//         track.stop();
//       }
//       return 'granted';
//     } catch (e) {
//       final error = e.toString();
//       if (error.contains('NotAllowedError') || error.contains('PermissionDeniedError')) {
//         return 'denied_permanently';
//       }
//       if (error.contains('OverconstrainedError')) {
//         // Fallback to default camera
//         try {
//           final constraints = web.MediaStreamConstraints();
//           constraints.video = true.toJS;
//           final stream = await web.window.navigator.mediaDevices
//               .getUserMedia(constraints)
//               .toDart;
//           final tracks = stream.getVideoTracks().toDart;
//           for (final track in tracks) {
//             track.stop();
//           }
//           return 'granted';
//         } catch (_) {
//           return 'denied';
//         }
//       }
//       return 'denied';
//     }
//   }

//   Future<void> _requestMobileCameraPermission() async {
//     final status = await Permission.camera.status;

//     if (status.isGranted) {
//       _scannerController = MobileScannerController(
//         facing: _currentCameraFacing,
//       );
//       setState(() => _hasPermission = true);
//       return;
//     }

//     if (status.isPermanentlyDenied) {
//       setState(() {
//         _hasPermission = false;
//         _isPermanentlyDenied = true;
//         _permissionError =
//             'Camera permission is permanently denied. Please enable it from app settings.';
//       });
//       return;
//     }

//     final result = await Permission.camera.request();

//     if (result.isGranted) {
//       _scannerController = MobileScannerController(
//         facing: _currentCameraFacing,
//       );
//       setState(() => _hasPermission = true);
//     } else if (result.isPermanentlyDenied) {
//       setState(() {
//         _hasPermission = false;
//         _isPermanentlyDenied = true;
//         _permissionError =
//             'Camera permission is permanently denied. Please enable it from app settings.';
//       });
//     } else {
//       setState(() {
//         _hasPermission = false;
//         _isPermanentlyDenied = false;
//         _permissionError =
//             'Camera permission was denied. Tap "Grant Permission" to try again.';
//       });
//     }
//   }

//   /// Handles camera switching for both Web and Mobile
//   Future<void> _switchCamera() async {
//     if (_isSwitchingCamera) return;

//     setState(() {
//       _isSwitchingCamera = true;
//     });

//     try {
//       // Toggle camera facing
//       final newFacing = _currentCameraFacing == CameraFacing.back
//           ? CameraFacing.front
//           : CameraFacing.back;

//       if (kIsWeb) {
//         // For Web: Reinitialize the controller with new facing mode
//         final oldController = _scannerController;
//         final result = await _requestWebCameraWithFacingModeForSwitch(newFacing);

//         if (result == 'granted') {
//           _currentCameraFacing = newFacing;
//           // Dispose old controller safely
//           if (oldController != null) {
//             await oldController.dispose();
//           }
//           _scannerController = MobileScannerController(
//             facing: _currentCameraFacing,
//           );
//           setState(() {});
//         } else {
//           _showErrorDialog('Camera Switch Failed',
//               'Could not switch to ${newFacing == CameraFacing.front ? 'front' : 'back'} camera. Please check your camera permissions.');
//         }
//       } else {
//         // For Mobile: Use built-in switchCamera
//         await _scannerController?.switchCamera();
//         _currentCameraFacing = newFacing;
//       }
//     } catch (e) {
//       _showErrorDialog('Camera Switch Failed',
//           'Unable to switch camera. Error: ${e.toString()}');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isSwitchingCamera = false;
//         });
//       }
//     }
//   }

//   Future<String> _requestWebCameraWithFacingModeForSwitch(CameraFacing facing) async {
//     try {
//       final facingMode = facing == CameraFacing.front ? 'user' : 'environment';

//       // Create constraints for web
//       final constraints = web.MediaStreamConstraints();
//       final videoConstraints = web.MediaTrackConstraints();
//       videoConstraints.facingMode = facingMode.toJS;
//       constraints.video = videoConstraints.toJS;

//       final stream = await web.window.navigator.mediaDevices
//           .getUserMedia(constraints)
//           .toDart;

//       final tracks = stream.getVideoTracks().toDart;
//       for (final track in tracks) {
//         track.stop();
//       }
//       return 'granted';
//     } catch (e) {
//       return 'denied';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Scan QR Code'),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         actions: [
//           if (_hasPermission) ...[
//             // Flashlight button (not available on Web for front camera)
//             if (!kIsWeb || _currentCameraFacing == CameraFacing.back)
//               IconButton(
//                 icon: const Icon(Icons.flash_on),
//                 onPressed: () => _scannerController?.toggleTorch(),
//               ),
//             // Camera switch button
//             IconButton(
//               icon: _isSwitchingCamera
//                   ? const SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: Colors.white,
//                       ),
//                     )
//                   : const Icon(Icons.switch_camera),
//               onPressed: _isSwitchingCamera ? null : _switchCamera,
//             ),
//           ],
//         ],
//       ),
//       body: _buildBody(),
//     );
//   }

//   Widget _buildBody() {
//     if (_isCheckingPermission) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Colors.white),
//             SizedBox(height: 16),
//             Text(
//               'Requesting camera permission...',
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       );
//     }

//     if (!_hasPermission) {
//       return _buildPermissionDeniedUI();
//     }

//     return _buildScannerUI();
//   }

//   Widget _buildPermissionDeniedUI() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.no_photography_outlined,
//                 size: 80, color: Colors.white54),
//             const SizedBox(height: 24),
//             const Text(
//               'Camera Permission Required',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               _permissionError ?? 'Camera access is needed to scan QR codes.',
//               style: const TextStyle(fontSize: 14, color: Colors.white60),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             if (_isPermanentlyDenied && !kIsWeb)
//               ElevatedButton.icon(
//                 onPressed: () => openAppSettings(),
//                 icon: const Icon(Icons.settings),
//                 label: const Text('Open App Settings'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               )
//             else if (kIsWeb && _isPermanentlyDenied)
//               ElevatedButton.icon(
//                 onPressed: () {
//                   _showWebPermissionInstructions();
//                 },
//                 icon: const Icon(Icons.help_outline),
//                 label: const Text('How to Allow Camera'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               )
//             else
//               ElevatedButton.icon(
//                 onPressed: _requestCameraPermission,
//                 icon: const Icon(Icons.camera_alt),
//                 label: const Text('Grant Permission'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showWebPermissionInstructions() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.grey[900],
//         title: const Text('Allow Camera Access',
//             style: TextStyle(color: Colors.white)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'To scan QR codes, you need to allow camera access:',
//               style: TextStyle(color: Colors.white70),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 const Icon(Icons.lock_clock, color: Colors.white70),
//                 const SizedBox(width: 12),
//                 const Expanded(
//                   child: Text(
//                     'Click the camera icon in your browser\'s address bar',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const Icon(Icons.settings, color: Colors.white70),
//                 const SizedBox(width: 12),
//                 const Expanded(
//                   child: Text(
//                     'Select "Allow" from the permission dropdown',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const Icon(Icons.refresh, color: Colors.white70),
//                 const SizedBox(width: 12),
//                 const Expanded(
//                   child: Text(
//                     'Click "Retry" below after enabling',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _requestCameraPermission();
//             },
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildScannerUI() {
//     if (_scannerController == null) return const SizedBox.shrink();

//     return Stack(
//       children: [
//         MobileScanner(
//           controller: _scannerController!,
//           onDetect: (capture) {
//             if (_isProcessing) return;
//             for (final barcode in capture.barcodes) {
//               if (barcode.rawValue != null) {
//                 _processQRCode(barcode.rawValue!);
//                 break;
//               }
//             }
//           },
//           errorBuilder: (context, error, child) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Camera Error',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   Text(
//                     error.errorCode.toString(),
//                     style: const TextStyle(color: Colors.white70),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => _requestCameraPermission(),
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         // Dark overlay with transparent cutout
//         IgnorePointer(
//           child: CustomPaint(
//             painter: _OverlayPainter(),
//             child: const SizedBox.expand(),
//           ),
//         ),
//         // Corner brackets
//         Center(
//           child: SizedBox(
//             width: 280,
//             height: 280,
//             child: Stack(
//               children: [
//                 Positioned(
//                     top: 0, left: 0, child: _cornerBracket(topLeft: true)),
//                 Positioned(
//                     top: 0, right: 0, child: _cornerBracket(topRight: true)),
//                 Positioned(
//                     bottom: 0,
//                     left: 0,
//                     child: _cornerBracket(bottomLeft: true)),
//                 Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: _cornerBracket(bottomRight: true)),
//               ],
//             ),
//           ),
//         ),
//         // Camera facing indicator
//         Positioned(
//           top: 60,
//           right: 16,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.black54,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   _currentCameraFacing == CameraFacing.front
//                       ? Icons.camera_front
//                       : Icons.camera_rear,
//                   size: 16,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   _currentCameraFacing == CameraFacing.front ? 'Front' : 'Back',
//                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const Align(
//           alignment: Alignment(0, 0.65),
//           child: Text(
//             'Align QR code within the frame',
//             style: TextStyle(color: Colors.white70, fontSize: 14),
//           ),
//         ),
//         if (_isProcessing)
//           Container(
//             color: Colors.black.withOpacity(0.85),
//             child: const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(color: Colors.white),
//                   SizedBox(height: 20),
//                   Text('Processing QR Code...',
//                       style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _cornerBracket({
//     bool topLeft = false,
//     bool topRight = false,
//     bool bottomLeft = false,
//     bool bottomRight = false,
//   }) {
//     const len = 30.0;
//     const thickness = 4.0;
//     const color = Colors.greenAccent;

//     return SizedBox(
//       width: len,
//       height: len,
//       child: CustomPaint(
//         painter: _BracketPainter(
//           color: color,
//           thickness: thickness,
//           topLeft: topLeft,
//           topRight: topRight,
//           bottomLeft: bottomLeft,
//           bottomRight: bottomRight,
//         ),
//       ),
//     );
//   }

//   Future<void> _processQRCode(String qrData) async {
//     setState(() => _isProcessing = true);
//     await _scannerController?.stop();

//     try {
//       final Map<String, dynamic> data = jsonDecode(qrData);

//       if (data['type'] == 'visitor_checkin') {
//         final int visitorId = data['visitor_id'];
//         final token = await ApiService.getAccessToken();

//         if (token != null) {
//           if (mounted) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => VisitorViewPage(
//                   visitorId: visitorId,
//                   fetchData: true,
//                 ),
//               ),
//             );
//           }
//         } else {
//           await ApiService.savePendingVisitorId(visitorId);
//           if (mounted) Navigator.pushReplacementNamed(context, '/login');
//         }
//       } else {
//         _showErrorDialog('Invalid QR Code',
//             'This QR code is not a valid visitor check-in code.');
//       }
//     } catch (e) {
//       _showErrorDialog(
//           'Invalid QR Code', 'Could not parse QR code. Please try again.');
//     } finally {
//       if (mounted) {
//         setState(() => _isProcessing = false);
//         _scannerController?.start();
//       }
//     }
//   }

//   void _showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.grey[900],
//         title: Text(title, style: const TextStyle(color: Colors.white)),
//         content: Text(message, style: const TextStyle(color: Colors.white70)),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               if (mounted) {
//                 setState(() => _isProcessing = false);
//                 _scannerController?.start();
//               }
//             },
//             child: const Text('Scan Again', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Painters ────────────────────────────────────────────────────────────────

// class _OverlayPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.black.withOpacity(0.6);
//     const cutoutSize = 280.0;
//     final cx = size.width / 2;
//     final cy = size.height / 2;
//     final rect = Rect.fromCenter(
//         center: Offset(cx, cy), width: cutoutSize, height: cutoutSize);
//     final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

//     final path = Path()
//       ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
//       ..addRRect(rrect)
//       ..fillType = PathFillType.evenOdd;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(_OverlayPainter old) => false;
// }

// class _BracketPainter extends CustomPainter {
//   final Color color;
//   final double thickness;
//   final bool topLeft, topRight, bottomLeft, bottomRight;

//   const _BracketPainter({
//     required this.color,
//     required this.thickness,
//     this.topLeft = false,
//     this.topRight = false,
//     this.bottomLeft = false,
//     this.bottomRight = false,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = thickness
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final w = size.width;
//     final h = size.height;

//     if (topLeft) {
//       canvas.drawLine(const Offset(0, 0), Offset(w, 0), paint);
//       canvas.drawLine(const Offset(0, 0), Offset(0, h), paint);
//     }
//     if (topRight) {
//       canvas.drawLine(Offset(0, 0), Offset(w, 0), paint);
//       canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
//     }
//     if (bottomLeft) {
//       canvas.drawLine(Offset(0, h), Offset(w, h), paint);
//       canvas.drawLine(const Offset(0, 0), Offset(0, h), paint);
//     }
//     if (bottomRight) {
//       canvas.drawLine(Offset(0, h), Offset(w, h), paint);
//       canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(_BracketPainter old) => false;
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modernlogintute/pages/visitor_view.dart';
import 'package:modernlogintute/services/api_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional import: web_helper on web, stub on mobile/desktop
import 'camera_permission_stub.dart'
    if (dart.library.html) 'camera_permission_web.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController? _scannerController;
  bool _isProcessing = false;
  bool _hasPermission = false;
  bool _isCheckingPermission = true;
  String? _permissionError;
  bool _isPermanentlyDenied = false;

  CameraFacing _currentCameraFacing = CameraFacing.back;
  bool _isSwitchingCamera = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  // ─── Permission ─────────────────────────────────────────────────────────────

  Future<void> _requestCameraPermission() async {
    setState(() {
      _isCheckingPermission = true;
      _permissionError = null;
      _isPermanentlyDenied = false;
    });

    if (kIsWeb) {
      await _handleWebPermission();
    } else {
      await _handleMobilePermission();
    }

    setState(() => _isCheckingPermission = false);
  }

  Future<void> _handleWebPermission() async {
    // requestWebCamera() comes from the conditional import
    final result =
        await requestWebCamera(_currentCameraFacing == CameraFacing.front);

    switch (result) {
      case 'granted':
        _scannerController = MobileScannerController(
          facing: _currentCameraFacing,
          torchEnabled: false,
        );
        setState(() => _hasPermission = true);
        break;
      case 'denied_permanently':
        setState(() {
          _hasPermission = false;
          _isPermanentlyDenied = true;
          _permissionError =
              'Camera access is blocked. Click the camera icon in your browser\'s address bar to allow access, then retry.';
        });
        break;
      default:
        setState(() {
          _hasPermission = false;
          _isPermanentlyDenied = false;
          _permissionError =
              'Camera permission was denied. Please allow camera access to scan QR codes.';
        });
    }
  }

  Future<void> _handleMobilePermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isPermanentlyDenied) {
      setState(() {
        _hasPermission = false;
        _isPermanentlyDenied = true;
        _permissionError =
            'Camera permission is permanently denied. Please enable it from app settings.';
      });
      return;
    }

    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      _scannerController =
          MobileScannerController(facing: _currentCameraFacing);
      setState(() => _hasPermission = true);
    } else if (status.isPermanentlyDenied) {
      setState(() {
        _hasPermission = false;
        _isPermanentlyDenied = true;
        _permissionError =
            'Camera permission is permanently denied. Please enable it from app settings.';
      });
    } else {
      setState(() {
        _hasPermission = false;
        _isPermanentlyDenied = false;
        _permissionError =
            'Camera permission was denied. Tap "Grant Permission" to try again.';
      });
    }
  }

  // ─── Camera Switch ───────────────────────────────────────────────────────────

  Future<void> _switchCamera() async {
    if (_isSwitchingCamera) return;
    setState(() => _isSwitchingCamera = true);

    try {
      final newFacing = _currentCameraFacing == CameraFacing.back
          ? CameraFacing.front
          : CameraFacing.back;

      if (kIsWeb) {
        final result = await requestWebCamera(newFacing == CameraFacing.front);
        if (result == 'granted') {
          final old = _scannerController;
          _currentCameraFacing = newFacing;
          old?.dispose();
          _scannerController =
              MobileScannerController(facing: _currentCameraFacing);
          if (mounted) setState(() {});
        } else {
          _showErrorDialog('Camera Switch Failed',
              'Could not switch to ${newFacing == CameraFacing.front ? 'front' : 'back'} camera.');
        }
      } else {
        await _scannerController?.switchCamera();
        _currentCameraFacing = newFacing;
        if (mounted) setState(() {});
      }
    } catch (e) {
      _showErrorDialog('Camera Switch Failed', 'Unable to switch camera: $e');
    } finally {
      if (mounted) setState(() => _isSwitchingCamera = false);
    }
  }

  // ─── QR Processing ───────────────────────────────────────────────────────────

  Future<void> _processQRCode(String qrData) async {
    setState(() => _isProcessing = true);
    await _scannerController?.stop();

    print('🔍 Scanned QR Data: $qrData');

    int? visitorId;

    try {
      // 1. Try to parse as JSON first (original format)
      try {
        final Map<String, dynamic> data = jsonDecode(qrData);
        if (data['type'] == 'visitor_checkin' || data['type'] == 'visitor') {
          visitorId = data['visitor_id'] ?? data['id'];
        }
      } catch (_) {
        // Not JSON or missing required fields, continue to URL parsing
      }

      // 2. Try to parse as URL if JSON failed
      if (visitorId == null) {
        try {
          // Handle potential URLs like https://vms.com/#/visitor/123 or https://vms.com/visitor?id=123
          final uri = Uri.parse(qrData);

          // Check both path and fragment (for hash routing)
          String fullPath = uri.path;
          if (uri.fragment.isNotEmpty) {
            fullPath = uri.fragment;
          }

          // Case: /visitor/123
          if (fullPath.contains('/visitor/')) {
            final parts = fullPath.split('/visitor/');
            if (parts.length > 1) {
              final idPart = parts[1].split('/')[0].split('?')[0];
              visitorId = int.tryParse(idPart);
            }
          }

          // Case: ?id=123
          if (visitorId == null) {
            visitorId = int.tryParse(uri.queryParameters['id'] ?? '');
          }

          // Case: fragment with query parameter (e.g. #/visitor?id=123)
          if (visitorId == null && uri.fragment.contains('id=')) {
            final fragmentParts = uri.fragment.split('?');
            if (fragmentParts.length > 1) {
              final queryStr = fragmentParts[1];
              final queryParams = Uri.splitQueryString(queryStr);
              visitorId = int.tryParse(queryParams['id'] ?? '');
            }
          }
        } catch (_) {
          // Not a valid URL, continue to raw ID check
        }
      }

      // 3. Try to parse as raw integer ID
      if (visitorId == null) {
        visitorId = int.tryParse(qrData.trim());
      }

      if (visitorId != null) {
        print('✅ Detected Visitor ID: $visitorId');
        final token = await ApiService.getAccessToken();

        if (!mounted) return;

        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context, ) =>
                  VisitorViewPage(visitorId: visitorId!, fetchData: true),
            ),
          );
        } else {
          await ApiService.savePendingVisitorId(visitorId!);
          if (mounted) Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        _showErrorDialog('Invalid QR Code',
            'This QR code is not recognized as a valid visitor code.\n\nContent: $qrData');
      }
    } catch (e) {
      print('❌ QR Processing Error: $e');
      _showErrorDialog('Processing Error',
          'An error occurred while processing the QR code: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
        // Only restart if we didn't navigate away
        _scannerController?.start();
      }
    }
  }

  // ─── Dialogs ─────────────────────────────────────────────────────────────────

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (mounted) {
                setState(() => _isProcessing = false);
                _scannerController?.start();
              }
            },
            child:
                const Text('Scan Again', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showWebPermissionInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Allow Camera Access',
            style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To scan QR codes, allow camera access:',
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            _instructionRow(Icons.lock_clock,
                'Click the camera/lock icon in your browser\'s address bar'),
            const SizedBox(height: 12),
            _instructionRow(
                Icons.settings, 'Select "Allow" from the permission dropdown'),
            const SizedBox(height: 12),
            _instructionRow(Icons.refresh, 'Tap "Retry" below after enabling'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _requestCameraPermission();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _instructionRow(IconData icon, String text) => Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text, style: const TextStyle(color: Colors.white70))),
        ],
      );

  // ─── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          if (_hasPermission) ...[
            if (!kIsWeb)
              IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () => _scannerController?.toggleTorch(),
              ),
            IconButton(
              icon: _isSwitchingCamera
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.switch_camera),
              onPressed: _isSwitchingCamera ? null : _switchCamera,
            ),
          ],
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isCheckingPermission) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text('Requesting camera permission...',
                style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }

    if (!_hasPermission) return _buildPermissionDeniedUI();
    return _buildScannerUI();
  }

  Widget _buildPermissionDeniedUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.no_photography_outlined,
                size: 80, color: Colors.white54),
            const SizedBox(height: 24),
            const Text(
              'Camera Permission Required',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _permissionError ?? 'Camera access is needed to scan QR codes.',
              style: const TextStyle(fontSize: 14, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Mobile permanently denied → open settings
            if (_isPermanentlyDenied && !kIsWeb)
              ElevatedButton.icon(
                onPressed: () => openAppSettings(),
                icon: const Icon(Icons.settings),
                label: const Text('Open App Settings'),
                style: _buttonStyle(),
              )
            // Web permanently denied → show instructions
            else if (_isPermanentlyDenied && kIsWeb)
              ElevatedButton.icon(
                onPressed: _showWebPermissionInstructions,
                icon: const Icon(Icons.help_outline),
                label: const Text('How to Allow Camera'),
                style: _buttonStyle(),
              )
            // Soft denial → retry
            else
              ElevatedButton.icon(
                onPressed: _requestCameraPermission,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Grant Permission'),
                style: _buttonStyle(),
              ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      );

  // Widget _buildScannerUI() {
  //   if (_scannerController == null) return const SizedBox.shrink();

  //   return Stack(
  //     children: [
  //       MobileScanner(
  //         controller: _scannerController!,
  //         onDetect: (capture) {
  //           if (_isProcessing) return;
  //           for (final barcode in capture.barcodes) {
  //             if (barcode.rawValue != null) {
  //               _processQRCode(barcode.rawValue!);
  //               break;
  //             }
  //           }
  //         },
  //         errorBuilder: (context, error, child) => Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Icon(Icons.error_outline, size: 48, color: Colors.red),
  //               const SizedBox(height: 16),
  //               const Text('Camera Error',
  //                   style: TextStyle(color: Colors.white, fontSize: 18)),
  //               Text(error.errorCode.toString(),
  //                   style: const TextStyle(color: Colors.white70)),
  //               const SizedBox(height: 16),
  //               ElevatedButton(
  //                 onPressed: _requestCameraPermission,
  //                 child: const Text('Retry'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       // Dark overlay with cutout
  //       IgnorePointer(
  //         child: CustomPaint(
  //           painter: _OverlayPainter(),
  //           child: const SizedBox.expand(),
  //         ),
  //       ),
  //       // Corner brackets
  //       Center(
  //         child: SizedBox(
  //           width: 280,
  //           height: 280,
  //           child: Stack(
  //             children: [
  //               Positioned(
  //                   top: 0, left: 0, child: _cornerBracket(topLeft: true)),
  //               Positioned(
  //                   top: 0, right: 0, child: _cornerBracket(topRight: true)),
  //               Positioned(
  //                   bottom: 0,
  //                   left: 0,
  //                   child: _cornerBracket(bottomLeft: true)),
  //               Positioned(
  //                   bottom: 0,
  //                   right: 0,
  //                   child: _cornerBracket(bottomRight: true)),
  //             ],
  //           ),
  //         ),
  //       ),
  //       // Camera label
  //       Positioned(
  //         top: 12,
  //         right: 12,
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           decoration: BoxDecoration(
  //             color: Colors.black54,
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(
  //                 _currentCameraFacing == CameraFacing.front
  //                     ? Icons.camera_front
  //                     : Icons.camera_rear,
  //                 size: 14,
  //                 color: Colors.white,
  //               ),
  //               const SizedBox(width: 4),
  //               Text(
  //                 _currentCameraFacing == CameraFacing.front ? 'Front' : 'Back',
  //                 style: const TextStyle(color: Colors.white, fontSize: 12),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       const Align(
  //         alignment: Alignment(0, 0.7),
  //         child: Text(
  //           'Align QR code within the frame',
  //           style: TextStyle(color: Colors.white70, fontSize: 14),
  //         ),
  //       ),
  //       if (_isProcessing)
  //         Container(
  //           color: Colors.black.withOpacity(0.85),
  //           child: const Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 CircularProgressIndicator(color: Colors.white),
  //                 SizedBox(height: 20),
  //                 Text('Processing QR Code...',
  //                     style: TextStyle(color: Colors.white)),
  //               ],
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildScannerUI() {
    if (_scannerController == null) return const SizedBox.shrink();

    return Stack(
      children: [
        MobileScanner(
          controller: _scannerController!,
          onDetect: (capture) {
            if (_isProcessing) return;
            for (final barcode in capture.barcodes) {
              if (barcode.rawValue != null) {
                _processQRCode(barcode.rawValue!);
                break;
              }
            }
          },
          errorBuilder: (context, error, child) {
            // Provide more helpful error message for web
            String errorMessage = error.errorCode.toString();
            if (kIsWeb && errorMessage.contains('genericError')) {
              errorMessage =
                  'Camera initialization failed. Please ensure you have granted camera permission and try again.';
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Camera Error',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(errorMessage,
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _scannerController?.dispose();
                        _scannerController = null;
                        _hasPermission = false;
                      });
                      _requestCameraPermission();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        ),
        // ... rest of your UI widgets
      ],
    );
  }

  Widget _cornerBracket({
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CustomPaint(
        painter: _BracketPainter(
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
        ),
      ),
    );
  }
}

// ─── Painters ─────────────────────────────────────────────────────────────────

class _OverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 280,
      height: 280,
    );
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(20)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_OverlayPainter old) => false;
}

class _BracketPainter extends CustomPainter {
  final bool topLeft, topRight, bottomLeft, bottomRight;

  const _BracketPainter({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    if (topLeft) {
      canvas.drawLine(Offset.zero, Offset(w, 0), paint);
      canvas.drawLine(Offset.zero, Offset(0, h), paint);
    }
    if (topRight) {
      canvas.drawLine(Offset.zero, Offset(w, 0), paint);
      canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
    }
    if (bottomLeft) {
      canvas.drawLine(Offset(0, h), Offset(w, h), paint);
      canvas.drawLine(Offset.zero, Offset(0, h), paint);
    }
    if (bottomRight) {
      canvas.drawLine(Offset(0, h), Offset(w, h), paint);
      canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
    }
  }

  @override
  bool shouldRepaint(_BracketPainter old) => false;
}

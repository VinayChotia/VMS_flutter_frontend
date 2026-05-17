// // // import 'dart:js_interop';
// // // import 'package:web/web.dart' as web;

// // // Future<String> requestWebCamera(bool preferFront) async {
// // //   // First attempt: with facing mode constraint
// // //   try {
// // //     final facingMode = preferFront ? 'user' : 'environment';
// // //     final stream = await web.window.navigator.mediaDevices
// // //         .getUserMedia(web.MediaStreamConstraints(
// // //           video: {'facingMode': facingMode}.jsify()! as JSAny,
// // //         ))
// // //         .toDart;
// // //     _stopAllTracks(stream);
// // //     return 'granted';
// // //   } catch (e) {
// // //     final msg = e.toString();
// // //     if (msg.contains('NotAllowedError') || msg.contains('PermissionDeniedError')) {
// // //       return 'denied_permanently';
// // //     }
// // //     // OverconstrainedError or other — fallback to any camera
// // //   }

// // //   // Second attempt: any camera (no facing constraint)
// // //   try {
// // //     final stream = await web.window.navigator.mediaDevices
// // //         .getUserMedia(web.MediaStreamConstraints(video: true.toJS))
// // //         .toDart;
// // //     _stopAllTracks(stream);
// // //     return 'granted';
// // //   } catch (e) {
// // //     final msg = e.toString();
// // //     if (msg.contains('NotAllowedError') || msg.contains('PermissionDeniedError')) {
// // //       return 'denied_permanently';
// // //     }
// // //     return 'denied';
// // //   }
// // // }

// // // void _stopAllTracks(web.MediaStream stream) {
// // //   final tracks = stream.getVideoTracks().toDart;
// // //   for (final track in tracks) {
// // //     track.stop();
// // //   }
// // // }

// // import 'dart:js_interop';
// // import 'package:web/web.dart' as web;

// // Future<String> requestWebCamera(bool preferFront) async {
// //   // First attempt: with facing mode constraint
// //   try {
// //     final facingMode = preferFront ? 'user' : 'environment';

// //     // 1. facingMode needs .toJS because it expects a JSString (ConstrainDOMString)
// //     // 2. MediaTrackConstraints needs 'as JSAny' because the video parameter
// //     //    is a union type (JSAny)
// //     final constraints = web.MediaStreamConstraints(
// //       video: web.MediaTrackConstraints(
// //         facingMode: facingMode.toJS,
// //       ) as JSAny,
// //     );

// //     final stream = await web.window.navigator.mediaDevices
// //         .getUserMedia(constraints)
// //         .toDart;

// //     _stopAllTracks(stream);
// //     return 'granted';
// //   } catch (e) {
// //     final msg = e.toString();
// //     if (msg.contains('NotAllowedError') ||
// //         msg.contains('PermissionDeniedError')) {
// //       return 'denied_permanently';
// //     }
// //     // Fallback to second attempt if facingMode is not supported (OverconstrainedError)
// //   }

// //   // Second attempt: any camera (no facing constraint)
// //   try {
// //     // For a simple boolean, .toJS converts Dart bool to JSBoolean
// //     final constraints = web.MediaStreamConstraints(video: true.toJS);

// //     final stream = await web.window.navigator.mediaDevices
// //         .getUserMedia(constraints)
// //         .toDart;

// //     _stopAllTracks(stream);
// //     return 'granted';
// //   } catch (e) {
// //     final msg = e.toString();
// //     if (msg.contains('NotAllowedError') ||
// //         msg.contains('PermissionDeniedError')) {
// //       return 'denied_permanently';
// //     }
// //     return 'denied';
// //   }
// // }

// // void _stopAllTracks(web.MediaStream stream) {
// //   // Convert JSArray to Dart List
// //   final tracks = stream.getVideoTracks().toDart;
// //   for (var i = 0; i < tracks.length; i++) {
// //     // Cast the element to MediaStreamTrack to access .stop()
// //     final track = tracks[i] as web.MediaStreamTrack;
// //     track.stop();
// //   }
// // }

// // camera_permission_web.dart
// import 'dart:js_interop';
// import 'package:web/web.dart' as web;

// Future<String> requestWebCamera(bool preferFront) async {
//   // First, check if mediaDevices is supported
//   if (web.window.navigator.mediaDevices == null) {
//     return 'denied';
//   }

//   try {
//     final facingMode = preferFront ? 'user' : 'environment';

//     final constraints = web.MediaStreamConstraints(
//       video: web.MediaTrackConstraints(
//         facingMode: facingMode.toJS,
//       ) as JSAny,
//     );

//     final stream = await web.window.navigator.mediaDevices!
//         .getUserMedia(constraints)
//         .toDart;

//     _stopAllTracks(stream);
//     return 'granted';
//   } catch (e) {
//     final msg = e.toString().toLowerCase();
//     if (msg.contains('notallowederror') ||
//         msg.contains('permissiondeniederror')) {
//       return 'denied_permanently';
//     }

//     // Fallback to any camera
//     try {
//       final constraints = web.MediaStreamConstraints(video: true.toJS);
//       final stream = await web.window.navigator.mediaDevices!
//           .getUserMedia(constraints)
//           .toDart;
//       _stopAllTracks(stream);
//       return 'granted';
//     } catch (e) {
//       final fallbackMsg = e.toString().toLowerCase();
//       if (fallbackMsg.contains('notallowederror') ||
//           fallbackMsg.contains('permissiondeniederror')) {
//         return 'denied_permanently';
//       }
//       return 'denied';
//     }
//   }
// }

// void _stopAllTracks(web.MediaStream stream) {
//   final tracks = stream.getVideoTracks().toDart;
//   for (var i = 0; i < tracks.length; i++) {
//     final track = tracks[i] as web.MediaStreamTrack;
//     track.stop();
//   }
// }

// camera_permission_web.dart
import 'dart:js_interop';
import 'package:web/web.dart' as web;

Future<String> requestWebCamera(bool preferFront) async {
  // Check if mediaDevices is available
  if (web.window.navigator.mediaDevices == null) {
    print('❌ MediaDevices API not available');
    return 'denied';
  }

  try {
    // Simple constraints first - no facing mode to avoid errors
    final simpleConstraints = web.MediaStreamConstraints(video: true.toJS);

    print('📷 Requesting camera access...');
    final stream = await web.window.navigator.mediaDevices!
        .getUserMedia(simpleConstraints)
        .toDart;

    // Success! Stop the tracks and return
    _stopAllTracks(stream);
    print('✅ Camera access granted');
    return 'granted';
  } catch (e) {
    print('❌ Camera error: $e');
    final msg = e.toString().toLowerCase();

    if (msg.contains('notallowederror') ||
        msg.contains('permissiondeniederror')) {
      return 'denied_permanently';
    }

    return 'denied';
  }
}

void _stopAllTracks(web.MediaStream stream) {
  final tracks = stream.getVideoTracks().toDart;
  for (var i = 0; i < tracks.length; i++) {
    final track = tracks[i] as web.MediaStreamTrack;
    track.stop();
  }
}

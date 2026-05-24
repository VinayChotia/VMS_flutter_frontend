// import 'package:flutter/material.dart';
// import 'package:modernlogintute/components/my_button.dart';
// import 'package:modernlogintute/components/my_textfield.dart';
// import 'package:modernlogintute/components/square_tile.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:modernlogintute/components/token_services.dart';
// import 'package:modernlogintute/pages/home_page.dart';
// import 'package:modernlogintute/pages/pending_approvals_page.dart';
// import 'package:modernlogintute/pages/register_page.dart';

// const String baseUrl_login =
//     'https://vms-backend-drf-avdygnb6afcchbhg.centralindia-01.azurewebsites.net/account';

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});

//   // text editing controllers
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   // sign user in method
//   // void signUserIn() async {
//   //   print("Button clicked");
//   //   final username = usernameController.text.trim();
//   //   final password = passwordController.text.trim();

//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse('http://localhost:8000/api/login/'), // change if needed
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //       },
//   //       body: jsonEncode({
//   //         'email': username,
//   //         'password': password,
//   //       }),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);

//   //       final accessToken = data['access']; // JWT access
//   //       final refreshToken = data['refresh']; // optional

//   //       print("Access Token: $accessToken");

//   //       // TODO: store token (shared preferences / secure storage)
//   //     } else {
//   //       print("Login failed: ${response.body}");
//   //     }
//   //   } catch (e) {
//   //     print("Error: $e");
//   //   }
//   // }

//   void signUserIn(BuildContext context) async {
//     print("Button clicked");

//     final username = usernameController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/api/login/'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'email': username,
//           'password': password,
//         }),
//       );
//       final data = jsonDecode(response.body);
//       print("Status: ${response.statusCode}");
//       print("Response: ${response.body}");

//       if (response.statusCode == 200) {
//         //Navigate to Signup Page
//         await TokenService.saveTokens(
//           data['access'], // Your access token field name
//           data['refresh'], // Your refresh token field name
//         );

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomePage(),
//           ),
//         );
//       } else {
//         //Show error message
//         String errorMessage = "Login failed";

//         try {
//           final data = jsonDecode(response.body);
//           errorMessage = data.toString();
//         } catch (_) {}

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       print("Error: $e");

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Something went wrong. Please try again."),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),

//                 // logo
//                 const Icon(
//                   Icons.lock,
//                   size: 100,
//                 ),

//                 const SizedBox(height: 50),

//                 // welcome back, you've been missed!
//                 Text(
//                   'Welcome back you\'ve been missed!',
//                   style: TextStyle(
//                     color: Colors.grey[700],
//                     fontSize: 16,
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 // username textfield
//                 MyTextField(
//                   controller: usernameController,
//                   hintText: 'Username',
//                   obscureText: false,
//                 ),

//                 const SizedBox(height: 10),

//                 // password textfield
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                 ),

//                 const SizedBox(height: 10),

//                 // forgot password?
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 // sign in button
//                 MyButton(
//                   buttonText: "Sign In",
//                   onTap: () => signUserIn(context),
//                 ),

//                 const SizedBox(height: 50),

//                 // or continue with
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text(
//                           'Or continue with',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 50),

//                 // google + apple sign in buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     // google button
//                     SquareTile(imagePath: 'lib/images/google.png'),

//                     SizedBox(width: 25),

//                     // apple button
//                     SquareTile(imagePath: 'lib/images/apple.png')
//                   ],
//                 ),

//                 const SizedBox(height: 50),

//                 // not a member? register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Not a member?',
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                     const SizedBox(width: 4),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SignupPage(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         'Register now',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/components/square_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modernlogintute/components/token_services.dart';
import 'package:modernlogintute/pages/home_page.dart';
import 'package:modernlogintute/pages/pending_approvals_page.dart';
import 'package:modernlogintute/pages/register_page.dart';
import 'package:modernlogintute/pages/visitor_view.dart';
import 'package:modernlogintute/services/api_services.dart';

const String baseUrl_login =
    'https://vms-backend-drf-new.azurewebsites.net/account';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Store pending visitor ID from QR code scan
  int? _pendingVisitorId;

  // Loading state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkForPendingVisitor();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Check if there's a pending visitor ID from QR code scan
  Future<void> _checkForPendingVisitor() async {
    final pendingVisitorId = await ApiService.getAndClearPendingVisitorId();
    if (pendingVisitorId != null && mounted) {
      setState(() {
        _pendingVisitorId = pendingVisitorId;
      });
      print('✅ Found pending visitor ID: $pendingVisitorId');
    }
  }

  // Sign user in method
  void signUserIn(BuildContext context) async {
    print("Button clicked");

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validate input
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both email and password"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$baseUrl_login/auth/login/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': username,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        // Save tokens
        await TokenService.saveTokens(
          data['access'],
          data['refresh'],
        );

        // Also save tokens in ApiService for consistency
        await ApiService.storeTokens(data['access'], data['refresh']);

        // Check if we have a pending visitor to redirect to
        if (_pendingVisitorId != null) {
          print('✅ Redirecting to pending visitor: $_pendingVisitorId');
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VisitorViewPage(
                  visitorId: _pendingVisitorId,
                  fetchData: true,
                ),
              ),
            );
          }
        } else {
          // Normal navigation to home
          print('✅ No pending visitor, navigating to home');
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        }
      } else {
        // Show error message
        String errorMessage = "Login failed";

        try {
          if (data.containsKey('error')) {
            errorMessage = data['error'];
          } else if (data.containsKey('message')) {
            errorMessage = data['message'];
          } else if (data.containsKey('detail')) {
            errorMessage = data['detail'];
          } else {
            errorMessage = data.toString();
          }
        } catch (_) {}

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // Show pending visitor info if any
                if (_pendingVisitorId != null)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.qr_code_scanner,
                            color: Colors.blue.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'QR Code Detected!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'You will be redirected to visitor #$_pendingVisitorId after login',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement forgot password
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Forgot Password feature coming soon!"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  buttonText: _isLoading ? "Signing In..." : "Sign In",
                  onTap: _isLoading ? null : () => signUserIn(context),
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

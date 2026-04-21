// // import 'package:flutter/material.dart';
// // import 'package:modernlogintute/components/my_button.dart';
// // import 'package:modernlogintute/components/my_textfield.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class SignupPage extends StatefulWidget {
// //   const SignupPage({super.key});

// //   @override
// //   State<SignupPage> createState() => _SignupPageState();
// // }

// // class _SignupPageState extends State<SignupPage> {
// //   // controllers
// //   final emailController = TextEditingController();
// //   final fullNameController = TextEditingController();
// //   final departmentController = TextEditingController();
// //   final designationController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final confirmPasswordController = TextEditingController();

// //   bool isLoading = false;

// //   // signup function
// //   void signUserUp() async {
// //     setState(() => isLoading = true);

// //     try {
// //       final response = await http.post(
// //         Uri.parse('http://localhost:8000/api/auth/register/'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //         },
// //         body: jsonEncode({
// //           "email": emailController.text.trim(),
// //           "full_name": fullNameController.text.trim(),
// //           "department": departmentController.text.trim(),
// //           "designation": designationController.text.trim(),
// //           "password": passwordController.text.trim(),
// //           "confirm_password": confirmPasswordController.text.trim(),
// //         }),
// //       );

// //       print("Status: ${response.statusCode}");
// //       print("Response: ${response.body}");

// //       if (response.statusCode == 201 || response.statusCode == 200) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Signup Successful")),
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(response.body)),
// //         );
// //       }
// //     } catch (e) {
// //       print("Error: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Something went wrong")),
// //       );
// //     }

// //     setState(() => isLoading = false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[300],
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           // 👈 fixes overflow
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const SizedBox(height: 40),

// //               const Icon(Icons.person_add, size: 80),

// //               const SizedBox(height: 20),

// //               Text(
// //                 'Employee Registration',
// //                 style: TextStyle(
// //                   color: Colors.grey[700],
// //                   fontSize: 16,
// //                 ),
// //               ),

// //               const SizedBox(height: 25),

// //               MyTextField(
// //                 controller: emailController,
// //                 hintText: 'Email',
// //                 obscureText: false,
// //               ),

// //               const SizedBox(height: 10),

// //               MyTextField(
// //                 controller: fullNameController,
// //                 hintText: 'Full Name',
// //                 obscureText: false,
// //               ),

// //               const SizedBox(height: 10),

// //               MyTextField(
// //                 controller: departmentController,
// //                 hintText: 'Department',
// //                 obscureText: false,
// //               ),

// //               const SizedBox(height: 10),

// //               MyTextField(
// //                 controller: designationController,
// //                 hintText: 'Designation',
// //                 obscureText: false,
// //               ),

// //               const SizedBox(height: 10),

// //               MyTextField(
// //                 controller: passwordController,
// //                 hintText: 'Password',
// //                 obscureText: true,
// //               ),

// //               const SizedBox(height: 10),

// //               MyTextField(
// //                 controller: confirmPasswordController,
// //                 hintText: 'Confirm Password',
// //                 obscureText: true,
// //               ),

// //               const SizedBox(height: 25),

// //               // signup button
// //               MyButton(
// //                 buttonText: "Register",
// //                 onTap: isLoading ? null : signUserUp,
// //               ),

// //               if (isLoading)
// //                 const Padding(
// //                   padding: EdgeInsets.all(10),
// //                   child: CircularProgressIndicator(),
// //                 ),

// //               const SizedBox(height: 20),

// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     'Already have an account?',
// //                     style: TextStyle(color: Colors.grey[700]),
// //                   ),
// //                   const SizedBox(width: 4),
// //                   const Text(
// //                     'Login',
// //                     style: TextStyle(
// //                       color: Colors.blue,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 40),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:modernlogintute/components/my_button.dart';
// import 'package:modernlogintute/components/my_textfield.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   // controllers
//   final emailController = TextEditingController();
//   final fullNameController = TextEditingController();
//   final departmentController = TextEditingController();
//   final designationController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   bool isLoading = false;

//   // signup function
//   void signUserUp() async {
//     // ✅ Password validation
//     if (passwordController.text.trim() !=
//         confirmPasswordController.text.trim()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Passwords do not match"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:8000/account/auth/register/'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           "email": emailController.text.trim(),
//           "full_name": fullNameController.text.trim(),
//           "department": departmentController.text.trim(),
//           "designation": designationController.text.trim(),
//           "password": passwordController.text.trim(),
//           "confirm_password": confirmPasswordController.text.trim(),
//         }),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Signup Successful"),
//             backgroundColor: Colors.green,
//           ),
//         );

//         // 🔁 Optional: Navigate back to login
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(data.toString()),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Something went wrong: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }

//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],

//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),

//               const Icon(Icons.person_add, size: 80),

//               const SizedBox(height: 20),

//               Text(
//                 'Register Employee',
//                 style: TextStyle(
//                   color: Colors.grey[700],
//                   fontSize: 16,
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // Email
//               MyTextField(
//                 controller: emailController,
//                 hintText: 'Email',
//                 obscureText: false,
//               ),

//               const SizedBox(height: 10),

//               // Full Name
//               MyTextField(
//                 controller: fullNameController,
//                 hintText: 'Full Name',
//                 obscureText: false,
//               ),

//               const SizedBox(height: 10),

//               // Department
//               MyTextField(
//                 controller: departmentController,
//                 hintText: 'Department',
//                 obscureText: false,
//               ),

//               const SizedBox(height: 10),

//               // Designation
//               MyTextField(
//                 controller: designationController,
//                 hintText: 'Designation',
//                 obscureText: false,
//               ),

//               const SizedBox(height: 10),

//               // Password
//               MyTextField(
//                 controller: passwordController,
//                 hintText: 'Password',
//                 obscureText: true,
//               ),

//               const SizedBox(height: 10),

//               // Confirm Password
//               MyTextField(
//                 controller: confirmPasswordController,
//                 hintText: 'Confirm Password',
//                 obscureText: true,
//               ),

//               const SizedBox(height: 25),

//               // Register Button
//               MyButton(
//                 buttonText: "Register",
//                 onTap: isLoading ? null : signUserUp,
//               ),

//               // Loader
//               if (isLoading)
//                 const Padding(
//                   padding: EdgeInsets.all(10),
//                   child: CircularProgressIndicator(),
//                 ),

//               const SizedBox(height: 20),

//               // Back to login
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Already have an account?',
//                     style: TextStyle(color: Colors.grey[700]),
//                   ),
//                   const SizedBox(width: 4),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final departmentController = TextEditingController();
  final designationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signUserUp() async {
    // Password validation
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/account/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "full_name": fullNameController.text.trim(),
          "department": departmentController.text.trim(),
          "designation": designationController.text.trim(),
          "password": passwordController.text.trim(),
          "confirm_password": confirmPasswordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Signup Successful"),
            backgroundColor: Colors.green,
          ),
        );

        // Go back to login page
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      // AppBar with Back Button
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              const Icon(Icons.person_add, size: 80),

              const SizedBox(height: 20),

              Text(
                'Register Employee',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: fullNameController,
                hintText: 'Full Name',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: departmentController,
                hintText: 'Department',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: designationController,
                hintText: 'Designation',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                buttonText: "Register",
                onTap: isLoading ? null : signUserUp,
              ),

              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(),
                ),

              const SizedBox(height: 20),

              // ✅ Bottom Login navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

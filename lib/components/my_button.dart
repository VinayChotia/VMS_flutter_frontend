import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const MyButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Material(
        color: Colors.black, // 👈 background color
        borderRadius: BorderRadius.circular(8),

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),

          splashColor: Colors.white.withOpacity(0.2), // 👈 splash
          highlightColor: Colors.white.withOpacity(0.1), // 👈 press effect

          child: Container(
            padding: const EdgeInsets.all(25),
            alignment: Alignment.center,
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

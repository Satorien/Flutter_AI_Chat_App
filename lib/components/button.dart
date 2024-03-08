import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme.dart';

class MyButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: myTheme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: myTheme.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ),
    );
  }
}
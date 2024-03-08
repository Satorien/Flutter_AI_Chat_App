import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final void Function() submit;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText, 
    required this.submit,
  });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onFieldSubmitted: (value) => submit(),
    );
  }
}
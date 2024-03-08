import "package:flutter/material.dart";
import "package:flutter_application_1/theme.dart";

class ChatBubble extends StatelessWidget{
  final String message;
  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: myTheme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message, style: TextStyle(color: myTheme.colorScheme.onSecondary)),
    );
  }
}
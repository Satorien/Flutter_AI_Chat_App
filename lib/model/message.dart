import 'package:cloud_firestore/cloud_firestore.dart';  

class Message{
  final String message;
  final String senderUserID;
  final String senderEmail;
  final String receiverUserID;
  final Timestamp timestamp;
  
  Message({required this.senderEmail, required this.message, required this.senderUserID, required this.receiverUserID, required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'message': message,
      'senderUserID': senderUserID,
      'senderEmail': senderEmail,
      'receiverUserID': receiverUserID,
      'timestamp': timestamp,
    };
  }
}

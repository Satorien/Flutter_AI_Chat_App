import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //send message
  Future<void> sendMessage(String message, String receiverUserID, ChatSession chat) async{
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      message: message,
      senderUserID: currentUserID,
      senderEmail: currentUserEmail,
      receiverUserID: receiverUserID,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserID, receiverUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    //add new message to chat room
    await _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').add(newMessage.toMap());
    //send message to AI
    if (newMessage.message.contains("@AI") || _firebaseAuth.currentUser!.uid==receiverUserID) {
      var response = await chat.sendMessage(
        Content.text(message),
      );
      var text = response.text;
      if (text == null) {
        return;
      } else {
        Message aiMessage = Message(
          message: text,
          senderUserID: "AI",
          senderEmail: "AI",
          receiverUserID: currentUserID,
          timestamp: timestamp,
        );
        await _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').add(aiMessage.toMap());
      }
    }
  }
  //get messages
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID){
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp', descending:false).snapshots();
  }
}

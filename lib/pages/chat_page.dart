import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/components/chat_bubble.dart";
import "package:flutter_application_1/components/text_field.dart";
import "package:flutter_application_1/services/chat/chat_service.dart";
import "package:google_generative_ai/google_generative_ai.dart";
import "package:flutter_application_1/theme.dart";

class ChatPage extends StatefulWidget{
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  final ScrollController _scrollController = ScrollController();
  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;
  late final ChatSession _chat;
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _loading = false;
  static const _apiKey = String.fromEnvironment('API_KEY');

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
    );
    _visionModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  void sendMessage() async{
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(_messageController.text, widget.receiverUserID, _chat);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: widget.receiverUserID==_firebaseAuth.currentUser!.uid ? const Text('AI'):Text('${widget.receiverUserEmail} と AI'),
        backgroundColor: myTheme.appBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot){
        if (snapshot.hasError){
          return const Text("エラーが発生しました");
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("ロード中");
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),);
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;  

    var alignment = (data['senderUserID'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: (data['senderUserID'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderUserID'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "メッセージを入力してください",
              obscureText: false,
              submit: sendMessage, 
            ),
          ),
          IconButton(
            icon: (! _loading) ? const Icon(Icons.send):const CircularProgressIndicator(),
            onPressed: (! _loading) ? sendMessage:null,
          ),
        ],
      ),
    );
  }
}


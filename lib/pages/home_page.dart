import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/pages/add_task_page.dart";
import "package:flutter_application_1/pages/chat_page.dart";
import "package:flutter_application_1/services/auth/auth_service.dart";
import "package:flutter_application_1/theme.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム", style: TextStyle(color: myTheme.colorScheme.onSecondary, fontSize: 30)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: myTheme.colorScheme.onSecondary),
            onPressed: signOut,
          ),
        ],
        backgroundColor: myTheme.colorScheme.primary,
        shape: Border(bottom: BorderSide(color: Colors.yellow, width: 2)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: myTheme.colorScheme.secondary,
            width: double.infinity,
            child: Text("チャット", style: TextStyle(color: myTheme.colorScheme.onSecondary, fontSize: 20)),
          ),
          Expanded(child: _buildUserList(),),
          Container(
            padding: const EdgeInsets.all(10),
            color: myTheme.colorScheme.secondary,
            width: double.infinity,
            child: Text("スケジュール", style: TextStyle(color: myTheme.colorScheme.onSecondary, fontSize: 20)),
          ),
          // Expanded(child: _buildTaskList(),),
        ],
      ),
      backgroundColor: myTheme.colorScheme.background,
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("エラーが発生しました");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('ロード中');
        }
        return ListView(
            children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      }
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black)),
        ),
        child: ListTile(
          title: Text(_auth.currentUser!.email != data['email'] ? data["email"]+" と AI": "AI"),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(receiverUserEmail: data['email'], receiverUserID: data['uid'],))
              );
          },
        ),
      );
  }

//   Widget _buildTaskList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection("tasks").snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text("エラーが発生しました");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('ロード中');
//         }
//         return Column(children: [
//           ListView(
//             children: snapshot.data!.docs.map<Widget>((doc) => _buildTaskListItem(doc)).toList(),
//            ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskPage()),);
//             },
//             child: const Text("タスクを追加"),
//           ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTaskListItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//       return Container(
//         decoration: const BoxDecoration(
//           border: Border(bottom: BorderSide(color: Colors.black)),
//         ),
//         child: ListTile(
//           title: Text(data["title"]),
//           subtitle: Text(data["description"]),
//         ),
      // );
  // }
}
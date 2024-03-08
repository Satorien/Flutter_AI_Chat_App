import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskService extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

//タスクの追加画面の作成途中で一旦終了。残りはFirebaseへのデータの追加と、データの取得を実装する。

  final List<String> tasks = [];

  void addTask(String task) {
    tasks.add(task);
    notifyListeners();
  }
}

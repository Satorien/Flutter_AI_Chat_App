import "package:flutter/material.dart";
import "package:flutter_application_1/components/button.dart";
import "package:flutter_application_1/components/text_field.dart";
import "package:flutter_application_1/theme.dart";

class AddTaskPage extends StatelessWidget{
  final taskDueController = TextEditingController();
  final taskController = TextEditingController();

  AddTaskPage({super.key});

  void addTask(){
    
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: myTheme.colorScheme.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
            controller: taskDueController,
            hintText: 'タスクの期限',
            obscureText: false,
            submit: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
            controller: taskController,
            hintText: 'タスクの内容',
            obscureText: false,
            submit: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButton(onTap: addTask, text: 'ログイン'),
          ),
      ],)
    );
  }
}

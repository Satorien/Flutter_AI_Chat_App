import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/components/text_field.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
        backgroundColor: myTheme.colorScheme.primary,
      ),
      body: Center(
        child: ListView(
          children: [
          //logo
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Image(image: AssetImage('lib/assets/logo.jpg'), height: 200, width: 200,),
          ),
          //Message
          const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('アカウントをお持ちの方はログインをしてください'),
            ),
          ),
          //Email Password ConfirmPassword
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
            controller: emailController,
            hintText: 'Eメールアドレス',
            obscureText: false,
            submit: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
            controller: passwordController,
            hintText: 'パスワード',
            obscureText: true,
            submit: login,
            ),
          ),
          //Login button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButton(onTap: login, text: 'ログイン'),
          ),
          //Register
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('アカウントをお持ちでない方はこちら'),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'アカウント登録',
                    style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
  }
}

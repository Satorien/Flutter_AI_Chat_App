import "package:flutter/material.dart";
import "package:flutter_application_1/components/button.dart";
import "package:flutter_application_1/components/text_field.dart";
import "package:flutter_application_1/services/auth/auth_service.dart";
import "package:flutter_application_1/theme.dart";
import "package:provider/provider.dart";

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController(); 
  final confirmPasswordController = TextEditingController();  

  void signUp() async{
    if (passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('パスワードが一致していません'),
        ),
      );
    return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await authService.createUserWithEmailAndPassword(emailController.text, passwordController.text);
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
        title: const Text('アカウント登録'),
        backgroundColor: myTheme.colorScheme.primary,
      ),
      body: Center(
        child: ListView(
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:  Image(image: AssetImage('lib/assets/logo.jpg'), height: 200, width: 200,),
            ),
            //Message
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('アカウントをお持ちでない方は登録をしてください'),
              ),
            ),
            //Email Password ConfirmPassword
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: emailController,
                hintText: 'Eメールアドレス',
                obscureText: false,
                submit: signUp,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: passwordController,
                hintText: 'パスワード',
                obscureText: true,
                submit: signUp,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: confirmPasswordController,
                hintText: 'パスワード（確認）',
                obscureText: true,
                submit: signUp,
              ),
            ),
            //Login button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(onTap: signUp, text: 'アカウント登録'),
            ),
            //Register
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('アカウントをお持ちの方はこちら'),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'ログイン',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],),
            )
          ],
        ),
      ),
    );
  }
}
import "package:flutter/material.dart";
import "package:flutter_application_1/pages/login_page.dart";
import "package:flutter_application_1/pages/register_page.dart";

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister>{
  bool showLogin = true;

  void toggle(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context){
    if (showLogin){
      return LoginPage(
        onTap: toggle,
      );
    } else {
      return RegisterPage(
        onTap: toggle,
      );
    }
  }
}

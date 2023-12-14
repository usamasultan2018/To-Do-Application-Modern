import 'package:flutter/material.dart';
import 'package:todo_application/screens/login_screen.dart';
import 'package:todo_application/screens/register_screen.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage  = true;
  void togglePages(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
   if(showLoginPage){
    return LoginScreen(onTap: togglePages,);
   }
   else{
     return RegisterScreen(onTap: togglePages,);
   }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/screens/home_screen.dart';
import 'package:todo_application/screens/login_screen.dart';

class RememberLogin extends StatefulWidget {
  const RememberLogin({super.key});

  @override
  State<RememberLogin> createState() => _RememberLoginState();
}

class _RememberLoginState extends State<RememberLogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const HomeScreen();
          }
          else{
           return const LoginScreen();
          }
        });
  }
}

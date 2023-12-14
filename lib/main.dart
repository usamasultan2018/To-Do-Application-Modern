import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_application/firebase_options.dart';
import 'package:todo_application/screens/remember_login.dart';
import 'package:todo_application/screens/welcome_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var _auth = FirebaseAuth.instance;
    User? user =_auth.currentUser;
    return MaterialApp(
      title: 'Todo-Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home:user == null?const WelcomeScreen():RememberLogin(),
      builder: EasyLoading.init(),
    );
  }
}

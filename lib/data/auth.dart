import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_application/models/user_model.dart';
import 'package:todo_application/screens/login_or_register.dart';
import 'package:todo_application/screens/login_screen.dart';

import '../screens/home_screen.dart';

class Auth{
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> registerMethod({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        UserModel userModel = UserModel(
          id: userCredential.user!.uid.toString(),
          fullName: fullName,
          email: email,
          password: password,
        );
        _firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
        EasyLoading.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
        EasyLoading.showSuccess("Register Successfully");
        return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.code.toString());
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> loginMethod({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Login Successfully");

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.code.toString());
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> signOut({required BuildContext context})async{
    EasyLoading.show();
   await _auth.signOut();
   Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx){
     return LoginOrRegister();
   }));
   EasyLoading.dismiss();
  }
}

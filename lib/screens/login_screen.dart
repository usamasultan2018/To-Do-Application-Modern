import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application/constant/app_constant.dart';
import 'package:todo_application/screens/home_screen.dart';
import 'package:todo_application/widgets/my_button.dart';
import 'package:todo_application/widgets/my_textfield.dart';

import '../data/auth.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;

  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: Image.asset(
                    AppConstant.logo,
                    width: width / 1.3,
                    height: height / 3.5,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Welcome back\nto",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "OUR REMINDER",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        hintText: "Enter your email",
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      MyTextField(
                        hintText: "Enter your password",
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        txtHidden: isHidden,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: Icon(
                            isHidden ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xffD8605B),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forgot password",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.12,
                      ),
                      MyButton(btnText: "Login", onPressed: () {
                        Auth auth = Auth();
                        if(_formKey.currentState!.validate()){
                          auth.loginMethod(
                            context: context,
                            email: emailController.text.trim(),
                            password:passwordController.text.trim(),
                          );
                        }
                        else{
                          EasyLoading.showInfo("Please filled all field correctly!!");
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                InkWell(
                  onTap: widget.onTap,
                  child: RichText(
                    text: TextSpan(
                      text: "Don`t have an account",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Register",
                          style: GoogleFonts.poppins(
                            color: const Color(0xffD8605B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application/data/auth.dart';

import '../constant/app_constant.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;

  const RegisterScreen({super.key, this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isHidden = false;
  bool confirmIsHidden = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  height: height * 0.015,
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
                  height: height * 0.01,
                ),
                Text(
                  "Get’s things done\nwith TODO",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                  ),
                ),
                Text(
                  "Let’s help you meet up your tasks",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        hintText: "Enter your full name",
                        controller: nameController,
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      MyTextField(
                        hintText: "Enter your email",
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
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
                        hintText: "Enter password",
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
                            color: const Color(0xffD8605B),
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
                        height: height * 0.02,
                      ),
                      MyTextField(
                        hintText: "Confirm password",
                        controller: confirmPasswordController,
                        textInputType: TextInputType.visiblePassword,
                        txtHidden: confirmIsHidden,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              confirmIsHidden = !confirmIsHidden;
                            });
                          },
                          icon: Icon(
                            confirmIsHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xffD8605B),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      MyButton(
                          btnText: "Register",
                          onPressed: () {
                            Auth auth = Auth();
                           if(_formKey.currentState!.validate()){
                             auth.registerMethod(
                               context: context,
                               fullName: nameController.text.trim(),
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
                  height: height * 0.012,
                ),
                InkWell(
                  onTap: widget.onTap,
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application/constant/app_constant.dart';
import 'package:todo_application/screens/login_or_register.dart';
import 'package:todo_application/widgets/my_button.dart';
import 'package:todo_application/widgets/my_textfield.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Image.asset(
                AppConstant.logo,
                height: height / 3,
                width: width / 1,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Welcome to",
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
                height: height * 0.02,
              ),
              Text(
                AppConstant.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyButton(
                  btnText: "Get Started ->",
                  onPressed: () {
                    print("prese");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (ctx) {
                        return LoginOrRegister();
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

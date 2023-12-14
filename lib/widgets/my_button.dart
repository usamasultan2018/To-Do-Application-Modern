import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MyButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  const MyButton({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 17),
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black,width: 1),
          gradient: LinearGradient(
              colors: [
                Color(0xffD8605B),
                Color(0xffF4C27F),
              ],
            begin:Alignment.centerRight,
            end: Alignment.centerLeft,

          )
        ),
        child:Text(btnText,style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 0.6,
          color: Colors.white
        ),) ,
      ),
    );
  }
}

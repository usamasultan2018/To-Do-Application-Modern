import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final DateTime time;

  ClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    // Draw clock face with inner color F5EFEF
    Paint facePaint = Paint()
      ..color = Color(0xFFF4C27F)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius, facePaint);

    // Draw clock border with box shadow
    Paint borderPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(Offset(centerX, centerY), radius, borderPaint);

    // Draw box shadow with blur radius and custom color
    Paint shadowPaint = Paint()
      ..color =  Color(0xFFF5EFEF)// F4C27F
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawCircle(Offset(centerX, centerY), radius, shadowPaint);

    // Draw clock digits with custom color and padding
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    drawDigit(canvas, textPainter, centerX, centerY - radius * 0.85, "12", Color(0xFFF4C27F));
    drawDigit(canvas, textPainter, centerX + radius * 0.85, centerY, "3", Color(0xFFF4C27F));
    drawDigit(canvas, textPainter, centerX, centerY + radius * 0.85, "6", Color(0xFFF4C27F));
    drawDigit(canvas, textPainter, centerX - radius * 0.85, centerY, "9", Color(0xFFF4C27F));

    // Draw clock hands
    drawHand(canvas, centerX, centerY, radius * 0.6, time.hour % 12 / 12 * 2 * pi, 3.0,const Color(0xffD8605B));
    drawHand(canvas, centerX, centerY, radius * 0.8, time.minute / 60 * 2 * pi, 2.0, Color(0xffF4C27F));
    drawHand(canvas, centerX, centerY, radius * 0.9, time.second / 60 * 2 * pi, 1.0,Color(0xffC1C0C0));
  }

  void drawDigit(Canvas canvas, TextPainter textPainter, double x, double y, String text, Color color) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  void drawHand(Canvas canvas, double centerX, double centerY, double length, double angle, double strokeWidth, Color color) {
    Paint handPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(
        centerX + length * sin(angle),
        centerY - length * cos(angle),
      ),
      handPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFFF57224);
  static const Color secondary = Color(0xFFFF8C00);
  static const Color background = Color(0xFFF4F4F4);

  // UI Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // --- GRADIENTS ---
  static const List<Color> primaryGradientColors = [
    Color(0xFFF57224),
    Color(0xFFFF8C00),
  ];

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: primaryGradientColors,
  );
}
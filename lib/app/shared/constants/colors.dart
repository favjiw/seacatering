import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  // Primary Colors
  static final primary = HexColor('#85B1B4'); // hijau
  static final primaryDark = HexColor('#747688');
  static final primaryLight = HexColor('#C8E6C9');

  static final text = HexColor('#120D26');

  // Secondary Colors
  static final secondary = HexColor('#FF9800'); // oranye
  static final secondaryDark = HexColor('#F57C00');
  static final secondaryLight = HexColor('#FFE0B2');

  // Neutral Colors
  static final white = Colors.white;
  static final black = Colors.black;
  static final gray = HexColor('#9E9E9E');
  static final lightGray = HexColor('#F5F5F5');
  static final darkGray = HexColor('#616161');

  // Danger / Warning / Success
  static final error = HexColor('#F44336'); // merah
  static final warning = HexColor('#FFC107'); // kuning
  static final success = HexColor('#4CAF50'); // hijau

  // Background
  static final background = HexColor('#FAFAFA');
  static final scaffoldBackground = HexColor('#F0F2F5');
}

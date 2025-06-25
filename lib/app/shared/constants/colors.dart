import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  // Primary Colors
  static final primary = HexColor('#85B1B4'); // hijau
  static final primaryDark = HexColor('#747688');
  static final primaryLight = HexColor('#C8E6C9');

  static final text = HexColor('#120D26');
  static final pageBackground = HexColor('#F2F6FE');
  static final containerHomeActive = HexColor('#E0B3FF');
  static final containerHomeInactive = HexColor('#EEEEEE');

  // Secondary Colors
  static final secondary = HexColor('#FF9800'); // oranye
  static final secondaryDark = HexColor('#F57C00');
  static final secondaryLight = HexColor('#FFE0B2');

  static final yellowTitle = HexColor('#F6EF97');

  // Neutral Colors
  static final white = Colors.white;
  static final black = Colors.black;
  static final gray = HexColor('#9E9E9E');
  static final lightGray = HexColor('#C1C1C1');
  static final darkGray = HexColor('#616161');

  // Danger / Warning / Success
  static final error = HexColor('#F44336');
  static final warning = HexColor('#FFC107');
  static final success = HexColor('#4CAF50');

  // Background
  static final background = HexColor('#FAFAFA');
  static final scaffoldBackground = HexColor('#F0F2F5');
}

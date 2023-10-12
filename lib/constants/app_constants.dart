// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:wire_viewer/common_widget/message_dialog.dart';

class AppConstants {
  static ThemeConstants themeConstants = ThemeConstants();
  static showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessageDialog(title: title, message: message);
      },
    );
  }
}

class ThemeConstants {
  ThemeConstants();

  //colors
  Color whiteColor = const Color(0XFFFFFFFF);
  Color defaultButtonColor = const Color.fromRGBO(3, 166, 120, 1.0);
  Color pressedButtonColor = const Color.fromRGBO(25, 113, 89, 1.0);

  double buttonBorderRadius = 25;
}

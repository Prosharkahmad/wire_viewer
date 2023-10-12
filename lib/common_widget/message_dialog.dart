import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/app_constants.dart';

class MessageDialog extends StatelessWidget {
  final Color? color;
  final String title;
  final String message;
  MessageDialog(
      {Key? key, this.color, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      actionsPadding:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      title: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      content: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      ),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
            minWidth: 100,
            height: 36,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    AppConstants.themeConstants.buttonBorderRadius)),
            color: AppConstants.themeConstants.defaultButtonColor,
            highlightColor: AppConstants.themeConstants.pressedButtonColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(
                color: AppConstants.themeConstants.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ])
      ],
    );
  }
}

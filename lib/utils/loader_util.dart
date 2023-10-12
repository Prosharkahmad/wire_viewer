import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wire_viewer/common_widget/loading_dialog.dart';

const tokenBox = "token";

showLoadingDialog(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => LoadingDialog(
      color: Get.theme.primaryColor,
    ),
  );
}

closeLoadingDialog(context) {
  Navigator.of(context, rootNavigator: true).pop("dialog");
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  final Color? color;
  const LoadingDialog({Key? key, this.color}) : super(key: key);
  Future<bool> _willPopCallback() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      //onWillPop: _willPopCallback,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Get.width * .727),
          child: Material(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            type: MaterialType.card,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.055, vertical: Get.height * 0.022),
              child: Image.asset(
                "assets/images/loading.gif",
                width: 200,
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

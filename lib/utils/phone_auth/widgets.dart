import 'package:flutter/material.dart';


class PhoneAuthWidgets {
  static Widget getLogo({String logoPath, double height}) => Material(
        type: MaterialType.transparency,
        elevation: 10.0,
        child: Image.asset(logoPath, height: height),
      );

  static Widget phoneNumberField(
          TextEditingController controller, String prefix) =>
      Card(
        child: TextFormField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.phone,
          key: Key('EnterPhone-TextFormField'),
          decoration: InputDecoration(
            border: InputBorder.none,
            errorMaxLines: 1,
            prefix: Text("  " + prefix + "  "),
          ),
        ),
      );
  static Widget subTitle(String text) => Align(
      alignment: Alignment.centerLeft,
      child: Text(' $text',
          style: TextStyle(color: Colors.white, fontSize: 14.0)));
}

import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      // print('HEXCOLOR: ${hexColor}');
    }
    return int.parse(hexColor, radix: 16);
    //
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


class Validators {
  // Check email
  bool isValidEmail(String email) {
    return email != '' && email.contains('@') && email.contains('.');
  }

  //check password
  bool isPassword(String password) {
    return password != null &&
        password != '' &&
        password.length >= 6 &&
        password.length <= 15;
  }

  //check phone number
  bool isPhoneNumber(String phone) {
    return phone != null && phone != '' && phone.length <= 11;
  }
}

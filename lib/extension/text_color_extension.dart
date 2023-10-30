import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:license/common/app_colors.dart';

extension FontWeightExtension on TextStyle? {
  TextStyle blackColor() {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color:  Colors.black,
        overflow: this?.overflow
    );
  }

  TextStyle whiteColor() {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color: Colors.white,
        overflow: this?.overflow
    );
  }

  TextStyle errorColor() {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color:  Colors.red,
        overflow: this?.overflow
    );
  }

  TextStyle greenColor() {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color:  Colors.green,
        overflow: this?.overflow
    );
  }

  TextStyle mainColor() {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color:  AppColors.mainColor,
        overflow: this?.overflow
    );
  }

  TextStyle greyColor() {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color:  Colors.grey,
        overflow: this?.overflow
    );
  }
  TextStyle customColor(Color? color) {
    return TextStyle(
        fontWeight: this?.fontWeight,
        fontSize: this?.fontSize,
        color:  color,
        overflow: this?.overflow
    );
  }
}

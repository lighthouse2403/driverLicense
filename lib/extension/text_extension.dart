import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:license/extension/font_size_extension.dart';
import 'package:license/extension/font_weight_extension.dart';
import 'package:license/extension/text_color_extension.dart';

extension TextExtension on Text? {
  /// Setup color for text
  Text white() {
    return Text(this?.data ?? '', style: this?.style.whiteColor());
  }

  Text error() {
    return Text(this?.data ?? '', style: this?.style.errorColor());
  }

  Text greenSuccess() {
    return Text(this?.data ?? '', style: this?.style?.greenColor());
  }

  Text customColor(Color? color) {
    return Text(this?.data ?? '', style: this?.style.customColor(color));
  }

  /// Setup font weight for text
  Text w400() {
    return Text(this?.data ?? '', style: this?.style?.textW400());
  }

  Text w500() {
    return Text(this?.data ?? '', style: this?.style.textW500());
  }

  Text w600() {
    return Text(this?.data ?? '', style: this?.style.textW600());
  }

  Text w700() {
    return Text(this?.data ?? '', style: this?.style.textW700());
  }

  Text w800() {
    return Text(this?.data ?? '', style: this?.style.textW800());
  }

  Text customWeight(FontWeight? weight) {
    return Text(this?.data ?? '', style: this?.style?.customWeight(weight));
  }

  /// Setup font size for text

  Text text8() {
    return Text(this?.data ?? '', style: this?.style.text8());
  }

  Text text10() {
    return Text(this?.data ?? '', style: this?.style.text10());
  }

  Text text12() {
    return Text(this?.data ?? '', style: this?.style.text12());
  }

  Text text13() {
    return Text(this?.data ?? '', style: this?.style.text13());
  }

  Text text14() {
    return Text(this?.data ?? '', style: this?.style.text14());
  }

  Text text15() {
    return Text(this?.data ?? '', style: this?.style.text15());
  }

  Text text16() {
    return Text(this?.data ?? '', style: this?.style.text16());
  }

  Text text17() {
    return Text(this?.data ?? '', style: this?.style.text17());
  }

  Text text18() {
    return Text(this?.data ?? '', style: this?.style.text18());
  }

  Text text20() {
    return Text(this?.data ?? '', style: this?.style.text20());
  }

  Text customSize(double size) {
    return Text(this?.data ?? '', style: this?.style?.customSize(size));
  }

  /// Setup textEllipsis
  Text ellipsis() {
    return Text(this?.data ?? '', style: this?.style.textEllipsis());
  }

  Text clip() {
    return Text(this?.data ?? '', style: this?.style.textEllipsis());
  }

  Text customHeight(double height) {
    return Text(this?.data ?? '', style: this?.style?.customHeight(height));
  }

  /// Setup allignment
  Text center() {
    return Text(this?.data ?? '', style: this?.style, textAlign: TextAlign.center);
  }
}
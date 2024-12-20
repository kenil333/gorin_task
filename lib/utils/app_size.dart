import 'package:flutter/material.dart';

class AppSize {
  static const double mobileWidth = 430;

  static Size size = const Size(0, 0);
  static double bottomPadding = 0;
  static double topPadding = 0;
  static double useWidth = 0;

  static void setupData(MediaQueryData queryData) {
    size = queryData.size;
    bottomPadding = queryData.padding.bottom;
    topPadding = queryData.padding.top;
    useWidth = mobileWidth;
  }

  static double getSize(double pxSize) {
    return size.width * pxSize / useWidth;
  }

  // static double _size14 = 0;
  // static double get size14 => _size14 != 0 ? _size14 : setup14();
  // static double setup14() {
  //   _size14 = getSize(14);
  //   return _size14;
  // }

  static double _size16 = 0;
  static double get size16 => _size16 != 0 ? _size16 : setup16();
  static double setup16() {
    _size16 = getSize(16);
    return _size16;
  }

  static double _size20 = 0;
  static double get size20 => _size20 != 0 ? _size20 : setup20();
  static double setup20() {
    _size20 = getSize(20);
    return _size20;
  }

  static double _size22 = 0;
  static double get size22 => _size22 != 0 ? _size22 : setup22();
  static double setup22() {
    _size22 = getSize(22);
    return _size22;
  }

  static double _size24 = 0;
  static double get size24 => _size24 != 0 ? _size24 : setup24();
  static double setup24() {
    _size24 = getSize(24);
    return _size24;
  }

  static double _size28 = 0;
  static double get size28 => _size28 != 0 ? _size28 : setup28();
  static double setup28() {
    _size28 = getSize(28);
    return _size28;
  }

  static double _size48 = 0;
  static double get size48 => _size48 != 0 ? _size48 : setup48();
  static double setup48() {
    _size48 = getSize(48);
    return _size48;
  }
}

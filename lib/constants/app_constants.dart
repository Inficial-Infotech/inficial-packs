import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum UserAuthStatus {
  notSignedIn,
  pending,
  signedIn,
}

// TODO: .. this cant be the way to properly handle icons
const PXIcons = <String, IconData>{
  'star': CupertinoIcons.star,
  'clock': CupertinoIcons.clock,
  'hands-wash': CupertinoIcons.hand_draw,
  'island-tropical': CupertinoIcons.airplane,
};

class PXColor {
  static const transparent = Color(0x00000000);
  static const black = Color(0xFF000000);
  static const darkText = Color(0xFF333333);
  static const textLight = Color(0xFF666666);
  static const grey = Color(0xFF707070);
  static const lightGrey = Color(0xFFD8D8D8);
  static const athensGrey = Color(0xFFF0F2F5);
  static const white = Color(0xFFFFFFFF);
  static const mysticGreen = Color(0xFFC6D6DD);
  static const lightGreen = Color(0xFFE5F4D7);
  static const neonGreen = Color(0xFF76DB3E);
  static const primary = Color(0xFF005F78);
  static const pink = Color(0xFFFF0358);
  static const red = Color(0xFFB42525);
  static const orange = Color(0xFFEB6D00);
  static const yellow = Color(0xFFFFC703);
}

class PXFontSize {
  static const double sizeXXL = 26;
  static const double sizeXL = 22;
  static const double headline = 17;
  static const double body = 15;
  static const double sizeS = 12;
  static const double sizeXS = 10;
}

class PXLineHeight {
  static const double heightL = 1.6;
  static const double heightM = 1.4;
  static const double heightS = 1;
}

class PXTextStyle {
  // Cases
  static const TextStyle pageTitle = TextStyle(
    fontSize: PXFontSize.sizeXXL,
    height: PXLineHeight.heightS,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle captionLight = TextStyle(
    fontSize: PXFontSize.sizeS,
    height: PXLineHeight.heightM,
    color: PXColor.textLight,
  );

  // Mark: - XS
  static const TextStyle styleXSRegular = TextStyle(
    fontSize: PXFontSize.sizeXS,
    height: PXLineHeight.heightM,
    color: PXColor.textLight,
  );

  static const TextStyle styleXSBold = TextStyle(
    fontSize: PXFontSize.sizeXS,
    height: PXLineHeight.heightM,
    color: PXColor.textLight,
  );

  // Mark: - S
  static const TextStyle styleSRegular = TextStyle(
    fontSize: PXFontSize.body,
    height: PXLineHeight.heightM,
  );

  // Mark: - M
  static const TextStyle styleMRegular = TextStyle(
    fontSize: PXFontSize.body,
    height: PXLineHeight.heightM,
  );
  static const TextStyle styleMBold = TextStyle(
    fontSize: PXFontSize.body,
    height: PXLineHeight.heightM,
    fontWeight: FontWeight.bold,
  );

  // Mark: - L
  static const TextStyle styleLRegular = TextStyle(
    fontSize: PXFontSize.headline,
  );
  static const TextStyle styleLBold = TextStyle(
    fontSize: PXFontSize.headline,
    fontWeight: FontWeight.bold,
  );

  // Mark: - XL
  static const TextStyle styleXLRegular = TextStyle(
    fontSize: PXFontSize.sizeXL,
  );
  static const TextStyle styleXLBold = TextStyle(
    fontSize: PXFontSize.sizeXL,
    fontWeight: FontWeight.bold,
  );
}

// default spacings
class PXSpacing {
  static const double spacingXXL = 48;
  static const double spacingXL = 32;
  static const double spacingL = 24;
  static const double spacingM = 16;
  static const double spacingS = 8;
  static const double spacingXS = 4;
  static const double spacingXXS = 2;
}

// default border radius
class PXBorderRadius {
  static const double radiusXXL = 48;
  static const double radiusXL = 32;
  static const double radiusL = 24;
  static const double radiusM = 16;
  static const double radiusS = 8;
}
import 'package:flutter/material.dart';

class AppThemeTokens {
  // Border Radius
  static const double radiusXSmall = 2;
  static const double radiusSmall = 8;
  static const double radiusMedium = 10;
  static const double radiusLarge = 12;
  static const double radiusXLarge = 16;
  static const double radiusXXLarge = 20;

  // Icon Sizes
  static const double iconSizeSmall = 30;
  static const double iconSizeMedium = 32;

  // Elevation
  static const double elevationNone = 0;
  static const double elevationSmall = 2;
  static const double elevationMedium = 4;
  static const double elevationLarge = 6;
  static const double elevationXLarge = 8;

  // Container Sizes
  static const double cupertinoHandleWidth = 40;
  static const double cupertinoHandleHeight = 3;

  // Paddings and Margins
  static const EdgeInsets paddingXSmall = EdgeInsets.all(4);
  static const EdgeInsets paddingSmall = EdgeInsets.all(8);
  static const EdgeInsets paddingMedium = EdgeInsets.all(12);
  static const EdgeInsets paddingLarge = EdgeInsets.all(20);
  static const EdgeInsets paddingXLarge = EdgeInsets.all(24);

  static const EdgeInsets paddingSymmetricHorizontalSmall =
      EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets paddingSymmetricButtonHorizontal =
      EdgeInsets.symmetric(horizontal: 32, vertical: 16);

  static const EdgeInsets marginBottomSmall = EdgeInsets.only(bottom: 8);
  static const EdgeInsets marginBottomMedium = EdgeInsets.only(bottom: 12);
  static const EdgeInsets marginBottomLarge = EdgeInsets.only(bottom: 24);
  static const EdgeInsets marginTopLarge = EdgeInsets.only(top: 100);

  // Transparency
  static const double alphaLight = 0.1;
  static const double alphaMedium = 0.2;
  static const double alphaHigh = 0.3;
  static const double alphaVeryHigh = 0.4;
  static const double alphaDarker = 0.5;
  static const double alphaNearlySolid = 0.8;
  static const double alphaSolid = 0.9;
  static const double alphaFull = 0.95;
}

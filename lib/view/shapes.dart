import 'package:flutter/cupertino.dart';

class AppShapes {
  static double radius = 16.0;
  static double smallRadius = 10.0;
  static BorderRadius borderRadius = BorderRadius.circular(radius);
  static BorderRadius smallBorderRadius = BorderRadius.circular(smallRadius);

  static RoundedRectangleBorder roundedRectangleShape = RoundedRectangleBorder(
      borderRadius: borderRadius
  );

  static RoundedRectangleBorder smallRoundedRectangleShape = RoundedRectangleBorder(
      borderRadius: smallBorderRadius
  );

  static RoundedRectangleBorder circleShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1000)
  );
}
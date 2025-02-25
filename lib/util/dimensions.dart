import 'package:get/get.dart';

class Dimension {
  static double get screenHeight {
    return Get.context?.height ?? 0.0; 
  }

  static double get screenWidth {
    return Get.context?.width ?? 0.0;
  }

  // PageView dimensions
  static double get pageView => screenHeight / 3.04;
  static double get pageViewContainers => screenHeight / 4.14;
  static double get pageViewTextContainers => screenHeight / 7.26;

  // Heights
  static double get height3 => screenHeight / 324.44;
  static double get height5 => screenHeight / 194.66;
  static double get height7 => screenHeight / 116.19;
  static double get height8 => screenHeight / 101.67;
  static double get height10 => screenHeight / 97.33;
  static double get height15 => screenHeight / 64.889;
  static double get height16 => screenHeight / 60.75;
  static double get height20 => screenHeight / 48.67;
  static double get height30 => screenHeight / 34.76;
  static double get height40 => screenHeight / 24.33;
  static double get height45 => screenHeight / 29.629;
  static double get height100 => screenHeight / 9.733;

  // Widths
  static double get width4 => screenHeight / 243.33;
  static double get width8 => screenHeight / 101.67;
  static double get width10 => screenHeight / 97.33;
  static double get width15 => screenHeight / 64.889;
  static double get width20 => screenHeight / 48.67;
  static double get width30 => screenHeight / 32.44;

  // Font sizes
  static double get font15 => screenHeight / 64.88;
  static double get font18 => screenHeight / 54.07;
  static double get font17 => screenHeight / 57.25;
  static double get font20 => screenHeight / 48.67;
  static double get font26 => screenHeight / 37.44;

  // Radius
  static double get radius9 => screenHeight / 90.33;
  static double get radius10 => screenHeight / 97.33;
  static double get radius15 => screenHeight / 64.88;
  static double get radius20 => screenHeight / 48.67;
  static double get radius30 => screenHeight / 32.44;
  static double get radius40 => screenHeight / 24.33;

  // Icon sizes
  static double get iconsize16 => screenHeight / 60.83;
  static double get iconsize24 => screenHeight / 40.55;

  // Additional methods to handle different screen sizes
  static double getProportionalHeight(double height) {
    return (height / 812.0) * screenHeight; // 812 is the height of iPhone 13
  }

  static double getProportionalWidth(double width) {
    return (width / 375.0) * screenWidth; // 375 is the width of iPhone 13
  }
}
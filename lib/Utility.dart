import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:velocity_x/velocity_x.dart';

class Utility {
  static BoxDecoration decoration(int index) {
    switch (index) {
      case 0:
        return BoxDecoration(
          border: Border(
            right: border(),
            bottom: border(),
          ),
        );
        break;
      case 1:
        return BoxDecoration(
          border: Border(
            right: border(),
            left: border(),
            bottom: border(),
          ),
        );
        break;
      case 2:
        return BoxDecoration(
          border: Border(
            left: border(),
            bottom: border(),
          ),
        );
        break;
      case 3:
        return BoxDecoration(
          border: Border(
            right: border(),
            top: border(),
            bottom: border(),
          ),
        );
        break;
      case 4:
        return BoxDecoration(
          border: Border(
            right: border(),
            left: border(),
            top: border(),
            bottom: border(),
          ),
        );
        break;
      case 5:
        return BoxDecoration(
          border: Border(
            left: border(),
            bottom: border(),
            top: border(),
          ),
        );
        break;
      case 6:
        return BoxDecoration(
          border: Border(
            right: border(),
            top: border(),
          ),
        );
        break;
      case 7:
        return BoxDecoration(
          border: Border(
            right: border(),
            left: border(),
            top: border(),
          ),
        );
        break;
      case 8:
        return BoxDecoration(
          border: Border(
            left: border(),
            top: border(),
          ),
        );
        break;
      default:
        return BoxDecoration();
    }
  }

  static BorderRadiusGeometry getBorderRadius(int index, double radius) {
    switch (index) {
      case 0:
        return BorderRadius.only(
          bottomRight: Radius.circular(radius),
        );
        break;
      case 1:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
        break;
      case 2:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
        );
        break;
      case 3:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
        break;
      case 4:
        return BorderRadius.all(
          Radius.circular(radius),
        );
        break;
      case 5:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
        break;
      case 6:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
        );
        break;
      case 7:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        );
        break;
      case 8:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
        );
        break;
      default:
        return BorderRadius.all(Radius.zero);
    }
  }

  static BorderSide border() {
    return BorderSide(
      color: Colors.black,
      width: 2,
    );
  }

  static getNeumorphicStyle({
    NeumorphicShape shape = NeumorphicShape.flat,
    NeumorphicBoxShape boxShape,
  }) {
    return NeumorphicStyle(
      intensity: 0.8,
      surfaceIntensity: 0.5,
      depth: 7,
      lightSource: LightSource.topLeft,
      shadowLightColor: Colors.grey,
      shadowDarkColor: Colors.grey,
      color: Colors.black,
      shape: shape,
      boxShape: boxShape,
    );
  }

  static getNeumorphicStyle2({
    NeumorphicShape shape = NeumorphicShape.flat,
    NeumorphicBoxShape boxShape,
  }) {
    return NeumorphicStyle(
      intensity: 0.8,
      surfaceIntensity: 0.5,
      depth: 7,
      lightSource: LightSource.topLeft,
      shadowLightColor: Colors.grey,
      shadowDarkColor: Colors.grey,
      color: Colors.white,
      shape: shape,
      boxShape: boxShape,
    );
  }

  static Widget getTextView(String text, double fontSize,
      {FontWeight fontWeight = FontWeight.bold}) {
    return NeumorphicText(
      text,
      textStyle: NeumorphicTextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      style: getNeumorphicStyle(),
    );
  }

  static Widget getTextView2(String text, double fontSize,
      {FontWeight fontWeight = FontWeight.bold}) {
    return NeumorphicText(
      text,
      textStyle: NeumorphicTextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      style: getNeumorphicStyle2(),
    );
  }

  static bool isNotMobileAndLandscape(BuildContext context) {
    return !context.isMobile &&
        context.isLandscape &&
        context.isMobileTypeTablet;
  }
}

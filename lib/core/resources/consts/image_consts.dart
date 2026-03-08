import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/core/resources/media/media_resources.dart';

class ImageConsts {
  const ImageConsts._();

  static SvgPicture robotImage({Color? color}) => SvgPicture.asset(
    MediaResources.robotSvg,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      color ?? ColorPalette.primaryColor,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture controlImage({Color? color}) => SvgPicture.asset(
    MediaResources.controlSvg,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      color ?? ColorPalette.primaryColor,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture cameraImage({Color? color}) => SvgPicture.asset(
    MediaResources.cameraSvg,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      color ?? ColorPalette.primaryColor,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture settingsImage({Color? color}) => SvgPicture.asset(
    MediaResources.settingsSvg,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      color ?? ColorPalette.primaryColor,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture batteryImage({Color? color}) => SvgPicture.asset(
    MediaResources.batterySvg,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      color ?? ColorPalette.primaryColor,
      BlendMode.srcIn,
    ),
  );
}

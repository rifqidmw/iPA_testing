import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {super.key,
      required this.title,
      required this.buttonStatusConfig,
      required this.buttonSizeConfig,
      this.enabled = true,
      this.loading = false});

  final String title;
  final ButtonStatusConfig buttonStatusConfig;
  final ButtonSizeConfig buttonSizeConfig;
  final bool enabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonSizeConfig.height,
      child: ElevatedButton(
          onPressed: enabled ? () {} : null,
          style: ButtonStyle(
            shadowColor:
                WidgetStateProperty.all<Color>(ColorManager.transparent),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return buttonStatusConfig.disabled.backgroundColor;
                }
                if (states.contains(WidgetState.pressed)) {
                  return buttonStatusConfig.hover.backgroundColor;
                }
                return buttonStatusConfig.active.backgroundColor;
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return buttonStatusConfig.disabled.textColor;
                }
                if (states.contains(WidgetState.pressed)) {
                  return buttonStatusConfig.hover.textColor;
                }
                return buttonStatusConfig.active.textColor;
              },
            ),
            shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: buttonStatusConfig.disabled.borderSide,
                );
              }
              if (states.contains(WidgetState.pressed)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: buttonStatusConfig.hover.borderSide,
                );
              }
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: buttonStatusConfig.active.borderSide,
              );
            }),
          ),
          child: loading
              ? Lottie.asset(AnimAssets.loadingDotsWhite,
                  width: 32, height: 18, fit: BoxFit.cover)
              : Text(
                  title,
                  style: getBoldStyle(
                      color: buttonStatusConfig.active.textColor,
                      fontSize: buttonSizeConfig.textSize),
                )),
    );
  }
}

enum ButtonStatusConfig {
  primary(
      active: buttonPrimaryActive,
      hover: buttonPrimaryHover,
      disabled: buttonPrimaryDisabled),
  secondary(
      active: buttonSecondaryActive,
      hover: buttonSecondaryHover,
      disabled: buttonSecondaryDisabled),
  tertiary(
      active: buttonTertiaryActive,
      hover: buttonTertiaryHover,
      disabled: buttonTertiaryDisabled),
  ghost(
      active: buttonGhostActive,
      hover: buttonGhostHover,
      disabled: buttonGhostDisabled);

  final ButtonStatus active;
  final ButtonStatus hover;
  final ButtonStatus disabled;

  const ButtonStatusConfig(
      {required this.active, required this.hover, required this.disabled});
}

enum ButtonSizeConfig {
  large(width: 115, height: 52, textSize: 16),
  medium(width: 99, height: 44, textSize: 16),
  small(width: 70, height: 32, textSize: 12),
  extrasmall(width: 70, height: 28, textSize: 12);

  final double width;
  final double height;
  final double textSize;

  const ButtonSizeConfig(
      {required this.width, required this.height, required this.textSize});
}

const ButtonStatus buttonPrimaryActive = ButtonStatus(
    textColor: ColorManager.neutral1,
    backgroundColor: ColorManager.blue8,
    borderSide: BorderSide(width: 1, color: ColorManager.blue8));
const ButtonStatus buttonPrimaryHover = ButtonStatus(
    textColor: ColorManager.neutral1,
    backgroundColor: ColorManager.blue9,
    borderSide: BorderSide(width: 1, color: ColorManager.blue9));
const ButtonStatus buttonPrimaryDisabled = ButtonStatus(
    textColor: ColorManager.secondary5,
    backgroundColor: ColorManager.secondary1,
    borderSide: BorderSide(width: 1, color: ColorManager.secondary1));

const ButtonStatus buttonSecondaryActive = ButtonStatus(
    textColor: ColorManager.neutral1,
    backgroundColor: ColorManager.blue5,
    borderSide: BorderSide(width: 1, color: ColorManager.blue5));
const ButtonStatus buttonSecondaryHover = ButtonStatus(
    textColor: ColorManager.neutral1,
    backgroundColor: ColorManager.blue6,
    borderSide: BorderSide(width: 1, color: ColorManager.blue6));
const ButtonStatus buttonSecondaryDisabled = ButtonStatus(
    textColor: ColorManager.secondary5,
    backgroundColor: ColorManager.secondary1,
    borderSide: BorderSide(width: 1, color: ColorManager.secondary1));

const ButtonStatus buttonTertiaryActive = ButtonStatus(
    textColor: ColorManager.neutral8,
    backgroundColor: ColorManager.neutral1,
    borderSide: BorderSide(width: 1, color: ColorManager.neutral6));
const ButtonStatus buttonTertiaryHover = ButtonStatus(
    textColor: ColorManager.neutral9,
    backgroundColor: ColorManager.secondary1,
    borderSide: BorderSide(width: 1, color: ColorManager.neutral6));
const ButtonStatus buttonTertiaryDisabled = ButtonStatus(
    textColor: ColorManager.neutral6,
    backgroundColor: ColorManager.neutral3,
    borderSide: BorderSide(width: 1, color: ColorManager.neutral6));

const ButtonStatus buttonGhostActive = ButtonStatus(
    textColor: ColorManager.neutral8,
    backgroundColor: ColorManager.transparent,
    borderSide: BorderSide(width: 1, color: ColorManager.transparent));
const ButtonStatus buttonGhostHover = ButtonStatus(
    textColor: ColorManager.neutral9,
    backgroundColor: ColorManager.transparent,
    borderSide: BorderSide(width: 1, color: ColorManager.transparent));
const ButtonStatus buttonGhostDisabled = ButtonStatus(
    textColor: ColorManager.neutral10,
    backgroundColor: ColorManager.transparent,
    borderSide: BorderSide(width: 1, color: ColorManager.transparent));

class ButtonStatus {
  final Color textColor;
  final Color backgroundColor;
  final BorderSide borderSide;

  const ButtonStatus({
    required this.textColor,
    required this.backgroundColor,
    required this.borderSide,
  });
}

import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class ButtonSampleComponent extends StatefulWidget {
  ButtonSampleComponent(
      {super.key,
      required this.title,
      this.titleColor = ColorManager.white1,
      this.backgroundColor = ColorManager.sampleBlue1,
      this.borderColor = ColorManager.transparent,
      this.isFullWidth = true,
      this.isTransparent = false,
      this.isLoading = false,
      this.height = 60,
      this.titleSize = 22,
      required this.onPressed});

  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool isFullWidth;
  final bool isTransparent;
  final bool isLoading;
  final double height;
  final double titleSize;
  final VoidCallback? onPressed;

  @override
  State<ButtonSampleComponent> createState() => _ButtonSampleComponentState();
}

class _ButtonSampleComponentState extends State<ButtonSampleComponent> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MaterialButton(
        height: widget.height,
        minWidth: widget.isFullWidth ? double.infinity : null,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: widget.borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        color: widget.isTransparent
            ? ColorManager.transparent
            : widget.backgroundColor,
        elevation: widget.isTransparent ? 0 : 2,
        highlightElevation: widget.isTransparent ? 0 : 2,
        splashColor:
            widget.isTransparent ? ColorManager.transparent : theme.splashColor,
        onPressed: widget.onPressed,
        child: widget.isLoading
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Text(
                widget.title,
                textAlign: TextAlign.center,
                style: getLightStyle(
                    color: widget.isTransparent
                        ? ColorManager.black
                        : widget.titleColor,
                    fontSize: widget.titleSize,
                    fontFamily: FontFamily.nunitoSans),
              ));
  }
}

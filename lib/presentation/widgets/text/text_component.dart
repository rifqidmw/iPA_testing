import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TextComponent({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? getRegularStyle(color: ColorManager.black),
    );
  }
}

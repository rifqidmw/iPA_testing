import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabelTagComponent extends StatelessWidget {
  const LabelTagComponent(
      {super.key, required this.title, this.trailingIcon = ''});

  final String title;
  final String trailingIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding:
              EdgeInsets.fromLTRB(8, 4, trailingIcon.isNotEmpty ? 4 : 8, 4),
          backgroundColor: ColorManager.neutral3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: ColorManager.neutral6),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: getRegularStyle(color: ColorManager.black),
              ),

              if (trailingIcon.isNotEmpty) ...[
                const SizedBox(width: 2,),
                const Icon(Icons.close),
              ]
            ],
          ),
        ));
  }
}

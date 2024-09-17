// ignore_for_file: must_be_immutable

import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum TextFieldPrefixType { COUNTRY_OPTION }

class TextFieldComponent extends StatefulWidget {
  TextFieldComponent(
      {super.key,
      required this.hintText,
      this.errorText,
      required this.inputType,
      this.inputAction = TextInputAction.next,
      this.prefixType,
      required this.onChanged,
      required this.controller});

  String hintText;
  String? errorText;
  TextInputType inputType;
  TextInputAction inputAction;
  TextFieldPrefixType? prefixType;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        widget.onChanged?.call(value);
      },
      obscureText: widget.inputType == TextInputType.visiblePassword
          ? _obscureText
          : false,
      keyboardType: widget.inputType,
      textInputAction: widget.inputAction,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: widget.hintText,
        errorText: widget.errorText,
        hintStyle: getMediumStyle(
            color: ColorManager.grey3,
            fontSize: FontSize.s14,
            fontFamily: FontFamily.poppins),
        prefixIcon: widget.prefixType == TextFieldPrefixType.COUNTRY_OPTION
            ? _countryOptionPrefix()
            : null,
        suffixIcon: widget.inputType == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle password visibility
                  });
                },
              )
            : null,
        fillColor: ColorManager.grey4,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          borderSide: BorderSide(width: 1, color: ColorManager.grey4),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          borderSide: BorderSide(width: 1, color: ColorManager.grey4),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          borderSide: BorderSide(width: 1, color: ColorManager.grey4),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            borderSide: BorderSide(width: 1, color: ColorManager.grey4)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            borderSide: BorderSide(width: 1, color: ColorManager.grey4)),
      ),
    );
  }

  Widget _countryOptionPrefix() {
    return InkWell(
      onTap: () {},
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.sampleFlag,
                width: 30,
                height: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                ImageAssets.icArrowDown,
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                child: const VerticalDivider(
                  color: ColorManager.black,
                  thickness: 1,
                  width: 1,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

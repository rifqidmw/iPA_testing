import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class OTPTextFieldComponent extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final TextStyle? textStyle;
  final bool obscureText;
  final TextInputType textInputType;

  OTPTextFieldComponent({
    Key? key,
    this.length = 6,
    this.onCompleted,
    this.obscureText = false,
    this.textStyle,
    this.textInputType = TextInputType.number,
  }) : super(key: key);

  @override
  _OTPTextFieldComponentState createState() => _OTPTextFieldComponentState();
}

class _OTPTextFieldComponentState extends State<OTPTextFieldComponent> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      String otp = _controllers.map((controller) => controller.text).join();
      widget.onCompleted?.call(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.length, (index) {
        return _buildOTPTextField(index);
      }),
    );
  }

  Widget _buildOTPTextField(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 40,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: widget.textInputType,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: widget.textStyle ??
            getSemiBoldStyle(
                color: ColorManager.black,
                fontSize: 18,
                fontFamily: FontFamily.poppins),
        decoration: const InputDecoration(
          counterText: '',
          fillColor: ColorManager.grey4,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: ColorManager.grey4),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: ColorManager.grey4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: ColorManager.grey4),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: ColorManager.grey4)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: ColorManager.grey4)),
          contentPadding: EdgeInsets.all(8),
        ),
        obscureText: widget.obscureText,
        onChanged: (value) => _onChanged(value, index),
      ),
    );
  }
}

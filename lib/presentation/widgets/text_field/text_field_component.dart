import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldComponent extends StatefulWidget {
  const TextFieldComponent(
      {super.key,
      this.enabled = true,
      this.mandatory = false,
      this.counter = false,
      this.readOnly = false,
      this.hintText = '',
      this.errorText = '',
      this.helperText = '',
      this.maxLength = TextField.noMaxLength,
      this.maxLines = 1,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.suffixIcon,
      this.focusNode,
      required this.captionText,
      required this.controller});

  final bool enabled;
  final bool mandatory;
  final bool counter;
  final bool readOnly;
  final String captionText;
  final String hintText;
  final String errorText;
  final String helperText;
  final int maxLength;
  final int maxLines;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  late bool _enabled;
  late bool _mandatory;
  late bool _counter;
  late bool _readOnly;
  late String _captionText;
  late String _hintText;
  late String _errorText;
  late String _helperText;
  late int _maxLength;
  late int _maxLines;
  late TextInputType _inputType;
  late TextInputAction _inputAction;
  late TextEditingController _controller;
  late Widget? _suffixIcon;
  late FocusNode _focusNode;

  bool _isHovered = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _enabled = widget.enabled;
    _mandatory = widget.mandatory;
    _counter = widget.counter;
    _readOnly = widget.readOnly;
    _captionText = widget.captionText;
    _hintText = widget.hintText;
    _errorText = widget.errorText;
    _helperText = widget.helperText;
    if (widget.maxLines > 1) {
      _maxLength = 250;
    } else {
      _maxLength = widget.maxLength;
    }
    _maxLines = widget.maxLines;
    _inputType = widget.inputType;
    _inputAction = widget.inputAction;
    _controller = widget.controller;
    _suffixIcon = widget.suffixIcon;
    _focusNode = widget.focusNode ?? FocusNode();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _captionText,
                style:
                    getBoldStyle(color: ColorManager.neutral11, fontSize: 14),
              ),
              if (_mandatory)
                Text(
                  '*',
                  style: getBoldStyle(color: ColorManager.error5),
                )
            ],
          ),
          const SizedBox(height: 8), // Spacing between title and text field
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: TextFormField(
              controller: _controller,
              enabled: _enabled,
              keyboardType: _inputType,
              textInputAction: _inputAction,
              obscureText: _inputType == TextInputType.visiblePassword
                  ? _obscureText
                  : false,
              maxLength: _maxLength,
              maxLines: _maxLines,
              readOnly: _readOnly,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: _hintText,
                filled: true,
                fillColor: _getFillColor(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_errorText.isNotEmpty)
                      UnconstrainedBox(
                        child: SvgPicture.asset(ImageAssets.icErrorOutline,
                            width: 20, height: 20),
                      ),
                    if (_inputType == TextInputType.visiblePassword)
                      IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    if (_counter && _maxLines == 1)
                      Text(
                        '${_controller.text.length}/$_maxLength',
                        style: getRegularStyle(
                            color: ColorManager.neutral11, fontSize: 16),
                      ),
                    _suffixIcon ?? const SizedBox.shrink(),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                errorText: _errorText.isNotEmpty ? _errorText : null,
                counterText: _maxLines == 1
                    ? ''
                    : '${_controller.text.length}/$_maxLength',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6), // Rounded corners
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isHovered
                          ? ColorManager.blue6
                          : ColorManager.neutral5,
                      width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: ColorManager.neutral8, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: ColorManager.error5, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: ColorManager.neutral6, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          if (_helperText.isNotEmpty) ...[
            const SizedBox(
              height: 4,
            ),
            Text(
              _helperText,
              textAlign: TextAlign.start,
              style:
                  getRegularStyle(color: ColorManager.neutral7, fontSize: 12),
            )
          ]
        ],
      ),
    );
  }

  Color _getFillColor() {
    if (!widget.enabled) {
      return ColorManager.neutral4; // Disabled state
    }
    if (_isHovered) {
      return ColorManager.neutral1; // Hovered state
    }
    if (FocusScope.of(context).hasFocus) {
      return ColorManager.neutral1; // Focused state
    }
    return ColorManager.neutral1; // Default state
  }
}

import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:base_flutter/presentation/widgets/text_field/text_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DropdownTextFieldComponent extends StatefulWidget {
  const DropdownTextFieldComponent(
      {super.key,
      this.enabled = true,
      this.mandatory = false,
      required this.controller,
      required this.captionText,
      this.hintText = '',
      this.errorText = '',
      this.helperText = '',
      required this.options});

  final bool enabled;
  final bool mandatory;
  final TextEditingController controller;
  final String captionText;
  final String hintText;
  final String errorText;
final String helperText;
  final List<String> options;

  @override
  _DropdownTextFieldComponentState createState() =>
      _DropdownTextFieldComponentState();
}

class _DropdownTextFieldComponentState
    extends State<DropdownTextFieldComponent> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  late bool _enabled;
  late bool _mandatory;
  late String _captionText;
  late String _hintText;
  late String _errorText;
  late String _helperText;
  late List<String> _options;
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();

    _enabled = widget.enabled;
    _mandatory = widget.mandatory;
    _controller = widget.controller;
    _captionText = widget.captionText;
    _hintText = widget.hintText;
    _errorText = widget.errorText;
    _helperText = widget.helperText;
    _options = widget.options;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showDropdown();
      } else {
        _removeDropdown();
      }
    });
  }

  void _removeDropdown() {
    setState(() {
      _isDropdownOpen = false;
    });

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldComponent(
      enabled: _enabled,
      mandatory: _mandatory,
      captionText: _captionText,
      hintText: _hintText,
      errorText: _errorText,
      helperText: _helperText,
      controller: _controller,
      focusNode: _focusNode,
      suffixIcon: SvgPicture.asset(_isDropdownOpen ? ImageAssets.icExpandLess : ImageAssets.icExpandMore),
      readOnly: true,
    );
  }

  void _showDropdown() {
    setState(() {
      _isDropdownOpen = true;
    });

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height - 12,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 118,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    hoverColor: ColorManager.blue1,
                    highlightColor: ColorManager.blue1,
                    splashColor: ColorManager.blue1,
                    onTap: () {
                      _controller.text = _options[index];
                      _focusNode.unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _options[index],
                              style: getRegularStyle(
                                  color: _controller.text == _options[index] ? ColorManager.blue8 : ColorManager.neutral11, fontSize: 14),
                            ),
                          ),
                          _controller.text == _options[index] ? SvgPicture.asset(ImageAssets.icCheck) : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }
}

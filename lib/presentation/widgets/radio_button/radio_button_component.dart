import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RadioButtonComponent extends StatefulWidget {
  final List<RadioButtonConfig> options;
  final ValueChanged<RadioButtonConfig?> onChanged;
  final Axis direction; 
  final RadioButtonConfig? initialValue; 

  const RadioButtonComponent({
    super.key,
    required this.options,
    required this.onChanged,
    this.direction = Axis.vertical, 
    this.initialValue,
  });

  @override
  _RadioButtonComponentState createState() => _RadioButtonComponentState();
}

class _RadioButtonComponentState extends State<RadioButtonComponent> {
  RadioButtonConfig? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue;
  }

  void _onRadioChanged(RadioButtonConfig? value) {
    setState(() {
      _selectedOption = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return widget.direction == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRadioList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildRadioList(),
          );
  }

  List<Widget> _buildRadioList() {
    return widget.options.map((option) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: option.label,
            groupValue: _selectedOption?.label,
            onChanged: (value) {
              _onRadioChanged(option);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option.label, style: getRegularStyle(color: ColorManager.neutral9, fontSize: 16),),
              if (option.description != null) Text(option.description!, style: getRegularStyle(color: ColorManager.neutral8, fontSize: 14),)
            ],
          )
        ],
      );
    }).toList();
  }
}

class RadioButtonConfig {
  final String label;
  final String? description;

  RadioButtonConfig({required this.label, this.description});
}
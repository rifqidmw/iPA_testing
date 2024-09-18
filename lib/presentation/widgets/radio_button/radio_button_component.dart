import 'package:flutter/material.dart';

class RadioButtonComponent extends StatefulWidget {
  final List<String> options;
  final Function(String) onChanged;

  const RadioButtonComponent({
    super.key,
    required this.options,
    required this.onChanged,
  });

  @override
  _RadioButtonComponentState createState() => _RadioButtonComponentState();
}

class _RadioButtonComponentState extends State<RadioButtonComponent> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              widget.onChanged(value!);
            });
          },
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

class CheckBoxComponent extends StatefulWidget {
  final String label;
  final Function(bool) onChanged;

  const CheckBoxComponent({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  _CheckBoxComponentState createState() => _CheckBoxComponentState();
}

class _CheckBoxComponentState extends State<CheckBoxComponent> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.label),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
          widget.onChanged(isChecked);
        });
      },
    );
  }
}

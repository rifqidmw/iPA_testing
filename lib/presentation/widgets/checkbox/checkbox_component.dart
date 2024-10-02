import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class CheckboxComponent extends StatefulWidget {
  final List<String> options;
  final ValueChanged<List<String>> onSelectionChanged;
  final Axis direction; 
  final bool isGrid; 
  final int gridCount; 

  const CheckboxComponent({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    this.direction = Axis.vertical, 
    this.isGrid = false, 
    this.gridCount = 2, 
  });

  @override
  _CheckboxComponentState createState() => _CheckboxComponentState();
}

class _CheckboxComponentState extends State<CheckboxComponent> {
  List<String> _selectedOptions = [];

  void _onCheckboxChanged(bool? value, String option) {
    setState(() {
      if (value == true) {
        _selectedOptions.add(option);
      } else {
        _selectedOptions.remove(option);
      }
      widget.onSelectionChanged(_selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGrid) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), 
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.gridCount,
          childAspectRatio: 3, 
        ),
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          return _buildCheckboxItem(option);
        },
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: widget.direction,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          return _buildCheckboxItem(option);
        },
      );
    }
  }

  Widget _buildCheckboxItem(String option) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _selectedOptions.contains(option),
          activeColor: ColorManager.blue8,
          onChanged: (value) {
            _onCheckboxChanged(value, option);
          },
        ),
        Text(option, style: getRegularStyle(color: ColorManager.neutral10, fontSize: 16),),
      ],
    );
  }
}

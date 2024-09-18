import 'package:flutter/material.dart';

class DatePickerDialogComponent {
  static void showDatePickerDialog(BuildContext context, Function(DateTime) onDateSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _DatePickerDialogContent(onDateSelected: onDateSelected);
      },
    );
  }
}

class _DatePickerDialogContent extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const _DatePickerDialogContent({
    super.key,
    required this.onDateSelected,
  });

  @override
  _DatePickerDialogContentState createState() => _DatePickerDialogContentState();
}

class _DatePickerDialogContentState extends State<_DatePickerDialogContent> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked); // Call the callback with the selected date
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a Date'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Selected Date: ${selectedDate.toLocal()}".split(' ')[0]),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select Date'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DateTimePickerComponent {
  static Future<void> showDatePickerModal(BuildContext context, Function(DateTime) onDateSelected) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      onDateSelected(selectedDate);
    }
  }

  static Future<void> showTimePickerModal(BuildContext context, Function (String) onTimeSelected) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat('hh:mm a').format(
        DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute),
      );

      onTimeSelected(formattedTime);
    }
  }
}

/*
How to Use

Date Picker Modal
ElevatedButton(
              onPressed: () {
                DatePickerComponent.showDatePickerModal(context, (date) {
                  print("Date selected : $date");
                },);
              },
              child: const Text('Show Date Picker Modal'),
            ),

Time Picker Modal
ElevatedButton(onPressed: () {
                  DateTimePickerComponent.showTimePickerModal(context, (time) {
                    print("Time selected: $time");
                  });
                }, child: const Text('Show Time Picker Modal'))
*/

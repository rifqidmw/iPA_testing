import 'package:flutter/material.dart';

class ButtonWithLoader extends StatelessWidget {
  const ButtonWithLoader(
      {super.key,
      required this.title,
      required this.onPress,
      required this.loading});

  final String title;
  final VoidCallback onPress;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            textStyle: const TextStyle(fontSize: 10),
            backgroundColor: Colors.green,
          ),
          onPressed: onPress,
          child: loading == true
              ? Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                )),
    );
  }
}

import 'package:flutter/material.dart';

class BottomSheetComponent {
  static void show(BuildContext context, {required Widget content}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to take full height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.8,
          minChildSize: 0.2,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: content, // Dynamic content passed here
              ),
            );
          },
        );
      },
    );
  }
}


/*
//HOW TO USE
ElevatedButton(
            onPressed: () {
              BottomSheetComponent.show(
                context,
                content: Column(
                  children: [
                    const Text(
                      'Dynamic Content',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.label),
                          title: Text('Item $index'),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            child: const Text('Show BottomSheet'),
          ),
*/
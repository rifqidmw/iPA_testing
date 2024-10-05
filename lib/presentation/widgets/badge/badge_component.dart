import 'package:flutter/material.dart';

class BadgeComponent extends StatelessWidget {
  final Widget child; // The main widget on which badge will be shown (e.g., an Icon or Image).
  final String value; // The value to display inside the badge.
  final Color badgeColor; // The background color of the badge.
  final Color textColor; // The color of the text in the badge.
  final double top; // Positioning of the badge from the top.
  final double right; // Positioning of the badge from the right.

  const BadgeComponent({
    super.key,
    required this.child,
    required this.value,
    this.badgeColor = Colors.red,
    this.textColor = Colors.white,
    this.top = 0,
    this.right = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child, // The main widget.
        Positioned(
          top: top,
          right: right,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
HOW TO USE
BadgeComponent(
              child: Icon(Icons.shopping_cart, size: 48),
              value: '32', // Example badge value
              right: -8, // Adjust the badge position
              top: -8, // Adjust the badge position
            ),
*/
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  final String imagePath; 
  final double size; 
  final double elevation; 
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const AvatarCard({
    Key? key,
    required this.imagePath,
    this.size = 90.0, // Default size of the avatar
    this.elevation = 5.0, // Default elevation of the card
    this.borderColor = Colors.white, // Default border color
    this.borderWidth = 4.0, 
    this.onTap, // Default border width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(100), // Circular avatar
      ),
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          imagePath,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

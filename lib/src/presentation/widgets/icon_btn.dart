import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final dynamic color;
  final dynamic onPressed;
  const IconBtn({
    Key? key,
    required this.icon,
    required this.size,
    this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
      splashRadius: 24,
    );
  }
}

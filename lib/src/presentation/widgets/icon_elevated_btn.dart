import 'package:flutter/material.dart';

class IconElevatedlBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final dynamic onPressed;
  const IconElevatedlBtn({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  final String label;
  final dynamic onPressed;
  const ElevatedBtn({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

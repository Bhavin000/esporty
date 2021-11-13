import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String text;
  final dynamic onPressed;
  const TextBtn({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}

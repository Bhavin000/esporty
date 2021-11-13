import 'package:flutter/material.dart';

class Dlg extends StatelessWidget {
  final double height;
  final Widget child;
  const Dlg({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 14),
        child: child,
      ),
    );
  }
}

import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:flutter/material.dart';

void bnr(context, String label) {
  ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: Text(label),
      actions: [
        TextBtn(
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          },
          text: 'dismiss',
        ),
      ],
    ),
  );
}

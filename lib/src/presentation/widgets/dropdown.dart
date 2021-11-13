import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Dropdown extends StatelessWidget {
  final String label;
  final List<String> data;
  final dynamic onChanged;
  const Dropdown({
    Key? key,
    required this.label,
    required this.data,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: label,
      allowClear: false,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      items: data
          .map((val) => DropdownMenuItem(
                child: Text(val),
                value: data.indexOf(val),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}

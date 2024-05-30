import 'package:flutter/material.dart';

import 'custom_radio_button.dart';

class HourInput extends StatelessWidget {
  final int value;
  final String text;
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  HourInput({
    super.key,
    required this.value,
    required this.text,
    this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromRGBO(223, 223, 223, 0.5), width: 0.5)),
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto-Regular',
          ),
        ),
        trailing: CustomRadioButton(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        onTap: () => onChanged(value),
      ),
    );
  }
}

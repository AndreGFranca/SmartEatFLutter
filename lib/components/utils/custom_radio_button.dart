import 'package:flutter/material.dart';
import 'package:smart_eats/components/utils/default_colors.dart';

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  CustomRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: isSelected
            ? Icon(
          Icons.check_circle,
          color: DefaultColors.primaryColor,
        )
            : Icon(
          Icons.radio_button_unchecked,
          color: Colors.grey,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final TextStyle? styleLabel;

  const ConfirmButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.styleLabel});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.bold,
    );

    final mergedStyle = defaultStyle.merge(styleLabel);

    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            label,
            style: mergedStyle,
          ),
        ),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.all(0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          Color.fromRGBO(254, 61, 18, 1),
        ),
        overlayColor:
            MaterialStatePropertyAll<Color>(Color.fromRGBO(223, 223, 223, 200)),
        shadowColor: MaterialStateProperty.all<Color>(
          Colors.grey.withOpacity(0.9), // Cor do boxShadow
        ),
        elevation: MaterialStateProperty.all<double>(
          10,
        ), // Altura da sombra
      ),
    );
  }
}

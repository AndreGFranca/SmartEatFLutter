import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? alignment;

  const TextLabel({
    Key? key,
    this.style,
    required this.text, this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Estilo padrão
    final defaultStyle = TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Color.fromRGBO(254, 61, 18, 1),
    );

    // Mescla o estilo padrão com o estilo personalizado (se fornecido)
    final mergedStyle = defaultStyle.merge(style);

    return Text(
      text,
      style: mergedStyle,
      textAlign: alignment,
    );
  }
}

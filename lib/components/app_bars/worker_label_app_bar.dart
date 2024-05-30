import 'package:flutter/material.dart';

import '../utils/default_colors.dart';

class WorkerLabelAppBar extends StatelessWidget {
  final String? nomeFuncionario;
  final String? nomeFuncao;

  const WorkerLabelAppBar({super.key, this.nomeFuncionario, this.nomeFuncao});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            alignment: AlignmentDirectional.center,
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: DefaultColors.primaryColor,
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              color: DefaultColors.primaryColor,
              size: 42,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $nomeFuncionario',
              style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            Text(
              '$nomeFuncao',
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.normal,
                // backgroundColor: Colors.red,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

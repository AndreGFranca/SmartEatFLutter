import 'package:flutter/material.dart';

import '../utils/default_colors.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleAppBar;

  const GenericAppBar({super.key, required this.titleAppBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back, // Ícone de seta
          color: DefaultColors.primaryColor, // Cor do ícone
          size: 50.0, // Tamanho do ícone
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        titleAppBar,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto-Regular',
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
      shape: const Border(
        bottom: BorderSide(
          color: Color.fromRGBO(223, 223, 223, 1),
          width: 2,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

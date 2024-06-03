import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/worker_label_app_bar.dart';
import 'package:smart_eats/components/screens/menu_options.dart';

import '../utils/default_colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({super.key, required this.onChange});
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const WorkerLabelAppBar(),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuOptions(),
                  ),
                ).then((value)async{await onChange();});
              },
              icon: const Icon(
                Icons.menu,
                size: 45,
                color: DefaultColors.primaryColor,
              )),
        ],
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

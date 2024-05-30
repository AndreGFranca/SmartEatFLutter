import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/confirms.dart';
import 'package:smart_eats/components/screens/menu/create_menu.dart';
import 'package:smart_eats/components/screens/usuario/perfil_edit.dart';
import 'package:smart_eats/components/screens/usuario/workers_list.dart';
import '../../models/user/user_model.dart';
import '../utils/default_colors.dart';
import '../utils/menu_item.dart';
import 'justify.dart';

class MenuOptions extends StatelessWidget {
  const MenuOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        titleAppBar: 'Menu',
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MenuItem(
                text: 'Editar Perfil',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilEdit(
                        usuarioModel: UserModel(
                          Nome: 'a',
                          Cpf: '123',
                          Email: 'Teste',
                        ),
                      ),
                    ),
                  );
                },
                icon: Icons.edit_outlined),
            MenuItem(
                text: 'Justificar',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Justify(),
                    ),
                  );
                },
                icon: Icons.description_outlined),
            MenuItem(text: 'QrCode', onClick: () {}, icon: Icons.qr_code),
            MenuItem(
                text: 'Colaboradores',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkersList(),
                    ),
                  );
                },
                icon: Icons.groups_outlined),
            MenuItem(
                text: 'Cadastrar Cardápio',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateMenu(),
                    ),
                  );
                },
                icon: Icons.draw_outlined),
            MenuItem(
                text: 'Confirmações',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirms(),
                    ),
                  );
                },
                icon: Icons.check_box_outlined),
          ],
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}

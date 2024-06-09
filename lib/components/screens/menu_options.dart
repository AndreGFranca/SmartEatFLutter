import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/forms/login_form.dart';
import 'package:smart_eats/components/screens/confirms.dart';
import 'package:smart_eats/components/screens/justify/justifies_list.dart';
import 'package:smart_eats/components/screens/menu/create_menu.dart';
import 'package:smart_eats/components/screens/qr_code/qr_code_generator.dart';
import 'package:smart_eats/components/screens/qr_code/qr_code_scan.dart';
import 'package:smart_eats/components/screens/usuario/perfil_edit.dart';
import 'package:smart_eats/components/screens/usuario/workers_list.dart';
import 'package:smart_eats/services/user/user_service.dart';
import '../../contexts/user_context.dart';
import '../../models/user/user_model.dart';
import '../../services/storage_service.dart';
import '../utils/default_colors.dart';
import '../utils/menu_item.dart';
import 'justify/justify.dart';

class MenuOptions extends StatefulWidget {
  MenuOptions({super.key});
  bool loading = false;
  UserService _usuarioService = UserService();
  SecureStorage _secureStorage = SecureStorage();

  @override
  State<MenuOptions> createState() => _MenuOptionsState();
}

class _MenuOptionsState extends State<MenuOptions> {




  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);
    //  static Map<int, String> ProfileValues = {
    //     0: 'Administrador',
    //     1: 'Empresa',
    //     2: 'RH',
    //     3: 'Colaborador',
    //     4: 'Cozinha',
    //   };
    return Scaffold(
      appBar: GenericAppBar(
        titleAppBar: 'Menu',
      ),
      body: SafeArea(
        child:
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(!widget.loading)
              Column(
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
                                Id: userContext.Id!,
                                Nome: userContext.Nome!,
                                Cpf: userContext.Cpf!,
                                Email: userContext.UserName!,
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
                            builder: (context) => Justify(idFuncionario: userContext.Id!,),
                          ),
                        );
                      },
                      icon: Icons.description_outlined),
                  if(userContext.typeUser == "1" || userContext.typeUser == "2")
                  MenuItem(
                      text: 'Justificativas',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JustifiesList(),
                          ),
                        );
                      },
                      icon: Icons.library_books_sharp),
                  MenuItem(text: 'QrCode', onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrCodeGenerator(userId: userContext.Id!),
                      ),
                    );
                  }, icon: Icons.qr_code),
                  if(userContext.typeUser == "1" || userContext.typeUser == "4")
                  MenuItem(text: 'QrCode Scan', onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrCodeScan(),
                      ),
                    );
                  }, icon: Icons.qr_code_scanner_outlined),
                  if(userContext.typeUser == "1" || userContext.typeUser == "2")
                  MenuItem(
                      text: 'Colaboradores',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkersList(companyId: int.parse(userContext.CompanyId!),),
                          ),
                        );
                      },
                      icon: Icons.groups_outlined),
                  if(userContext.typeUser == "1" || userContext.typeUser == "4")
                  MenuItem(
                      text: 'Cadastrar Cardápio',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateMenu(companyId: int.parse(userContext.CompanyId!),),
                          ),
                        );
                      },
                      icon: Icons.draw_outlined),
                  if(userContext.typeUser == "1" || userContext.typeUser == "4")
                  MenuItem(
                      text: 'Confirmações',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Confirms(companyId: int.parse(userContext.CompanyId!)),
                          ),
                        );
                      },
                      icon: Icons.check_box_outlined),
                ],
              )
              else
                Center(child: CircularProgressIndicator()),
              MenuItem(
                  text: 'Sair',
                  onClick: ()async {
                    widget._usuarioService.Logout().then((value)async{
                      setState(() {
                        widget.loading = true;
                      });
                      await widget._secureStorage.deleteToken();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()), // A nova tela que você deseja empilhar
                            (Route<dynamic> route) => false, // Essa condição remove todas as rotas anteriores
                      );
                    });


                  },
                  icon: Icons.exit_to_app),
            ],
          ),
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}

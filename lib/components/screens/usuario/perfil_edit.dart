import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/usuario/password_edit.dart';
import 'package:smart_eats/validators/utils_validators.dart';

import '../../../contexts/user_context.dart';
import '../../../models/user/user_model.dart';
import '../../../services/http_service.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class PerfilEdit extends StatefulWidget {
  late UserModel? usuarioModel;
  late HttpService _httpService = HttpService();
  late bool loading = false;

  PerfilEdit({this.usuarioModel = null, super.key});

  @override
  State<PerfilEdit> createState() => _PerfilEditState();
}

class _PerfilEditState extends State<PerfilEdit> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dsNomeController = TextEditingController();
  TextEditingController dsCpfController = TextEditingController();
  TextEditingController dsEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.usuarioModel != null) {
      dsNomeController.text = widget.usuarioModel!.Nome;
      dsCpfController.text = widget.usuarioModel!.Cpf;
      dsEmailController.text = widget.usuarioModel!.Email;
    }
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Editar Perfil',
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (String? value) {
                  if (DefaultValidators.textValidator(value)) {
                    return 'Insira um Nome';
                  }
                  return null;
                },
                controller: dsNomeController,
                decoration: const InputDecoration(
                  // hintText: 'Qual é o seu nome?',
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 0.5),
                      width: 1,
                    ),
                  ),
                ),
              ),
              TextFormField(
                validator: (String? value) {
                  if (DefaultValidators.textValidator(value)) {
                    return 'Insira um CPF';
                  }
                  return null;
                },
                controller: dsCpfController,
                decoration: const InputDecoration(
                  // hintText: 'Qual é o seu nome?',

                  labelText: 'CPF',
                  labelStyle: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 0.5),
                      width: 1,
                    ),
                  ),
                ),
              ),
              TextFormField(
                validator: (String? value) {
                  if (DefaultValidators.textValidator(value)) {
                    return 'Insira um email';
                  }
                  return null;
                },
                controller: dsEmailController,
                decoration: const InputDecoration(
                  // hintText: 'Qual é o seu nome?',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 0.5),
                      width: 1,
                    ),
                  ),
                  labelText: 'E-Mail',
                  labelStyle: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Senha',
                  style: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: TextButton(
                  child: Text(
                    'ALTERAR',
                    style: TextStyle(
                      color: DefaultColors.primaryColor,
                      fontFamily: 'Roboto-Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: TextDecoration.underline,
                      decorationColor: DefaultColors.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordEdit(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Uma senha forte protege a sua conta',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontFamily: 'Roboto-Regular',
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  children: [
                    if(!widget.loading)
                    ConfirmButton(
                        label: 'Salvar Alterações',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              widget.loading = true;
                            });

                            try {
                              widget.usuarioModel = UserModel(
                                Id: widget.usuarioModel!.Id,
                                Nome: dsNomeController.text,
                                Cpf: dsCpfController.text,
                                Email: dsEmailController.text,
                              );

                              var retorno = await widget._httpService
                                  .put(
                                '/usuarios/atualizar/${widget.usuarioModel!.Id}',
                                widget.usuarioModel!.toJson(),
                              ).then((value) async {
                                userContext.PreencheVariaveis(
                                  widget.usuarioModel!.toJson(),
                                );
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => ResponseModal(
                                      texto: value,
                                    ),
                                  ),
                                );
                              });

                              print('teste2');
                            } catch (e) {
                              var erro = e.toString();
                              print(erro);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(erro),
                                ),
                              );
                            }
                            setState(() {
                              widget.loading = false;
                            });
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: DefaultColors.backgroudColor,
      ),
    );
  }
}

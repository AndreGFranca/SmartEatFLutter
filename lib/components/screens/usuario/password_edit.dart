import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/models/user/password_model.dart';
import 'package:smart_eats/validators/utils_validators.dart';

import '../../../contexts/user_context.dart';
import '../../../models/user/user_model.dart';
import '../../../services/http_service.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class PasswordEdit extends StatefulWidget {
  PasswordModel? passwordModel;
  late HttpService _httpService = HttpService();
  late bool loading = false;
  PasswordEdit({super.key});

  @override
  State<PasswordEdit> createState() => _PasswordEditState();
}

class _PasswordEditState extends State<PasswordEdit> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dsSenhaAtualController = TextEditingController();
  TextEditingController dsSenhaNovaController = TextEditingController();
  TextEditingController dsSenhaRepeteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Alterar Senha',
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  obscureText: true,
                  validator: (String? value) {
                    if (DefaultValidators.textValidator(value)) {
                      return 'Insira a senha atual';
                    }
                    return null;
                  },
                  controller: dsSenhaAtualController,
                  decoration: const InputDecoration(
                    // hintText: 'Qual é o seu nome?',
                    labelText: 'Senha Atual',
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
                  obscureText: true,
                  validator: (String? value) {
                    if (DefaultValidators.textValidator(value)) {
                      return 'Insira uma nova senha';
                    }
                    return null;
                  },
                  controller: dsSenhaNovaController,
                  decoration: const InputDecoration(
                    // hintText: 'Qual é o seu nome?',
          
                    labelText: 'Nova Senha',
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
                  obscureText: true,
                  validator: (String? value) {
                    if (DefaultValidators.textValidator(value)) {
                      return 'Repita a senha';
                    }
                    if(dsSenhaNovaController.text != dsSenhaRepeteController.text){
                      return 'Senhas diferentes';
                    }
                    return null;
                  },
                  controller: dsSenhaRepeteController,
                  decoration: const InputDecoration(
                    // hintText: 'Qual é o seu nome?',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(223, 223, 223, 0.5),
                        width: 1,
                      ),
                    ),
                    labelText: 'Repita a nova senha',
                    labelStyle: TextStyle(
                      color: DefaultColors.primaryColor,
                      fontFamily: 'Roboto-Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
                          onPressed: ()async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                widget.loading = true;
                              });
                              try{
                                widget.passwordModel = PasswordModel(
                                  SenhaAtual: dsSenhaAtualController.text,
                                  SenhaNova: dsSenhaNovaController.text,
                                  SenhaRepetida: dsSenhaRepeteController.text,
                                );
          
                                await widget._httpService
                                    .put(
                                  '/usuarios/atualizar-senha/${userContext.Id}',
                                  widget.passwordModel!.toJson(),
                                ).then((value) async {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => ResponseModal(
                                        texto: value,
                                      ),
                                    ),
                                  );
                                });
                              }catch (e) {
                                var erro = e.toString();
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
        ),
        backgroundColor: DefaultColors.backgroudColor,
      ),
    );
  }
}

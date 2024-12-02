import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/response_modal.dart';
import 'package:smart_eats/models/confirm/confirm_item_count_table.dart';
import 'package:smart_eats/models/reset_password/email_model.dart';
import 'package:smart_eats/models/reset_password/update_password_model.dart';
import 'package:smart_eats/models/reset_password/validate_code_model.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import 'package:smart_eats/services/http_service.dart';
import 'package:smart_eats/services/reset_password/reset_password_service.dart';
import 'package:smart_eats/validators/utils_validators.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePasswordModel? updatePasswordModel;
  final String email;
  final String code;
  late ResetPasswordService _resetPasswordService = ResetPasswordService();
  late bool loading = false;
  UpdatePassword({super.key, required this.email, required this.code});
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dsSenhaNovaController = TextEditingController();
  TextEditingController dsSenhaRepeteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Esqueci minha Senha',
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
                            label: 'Enviar',
                            onPressed: ()async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  widget.loading = true;
                                });
                                try{
                                  widget.updatePasswordModel = UpdatePasswordModel(
                                      Email: widget.email,
                                      Code: widget.code,
                                      SenhaNova: dsSenhaNovaController.text,
                                      SenhaRepetida: dsSenhaRepeteController.text
                                  );

                                  await widget._resetPasswordService
                                      .Update(widget.updatePasswordModel!)
                                      .then((value) async {
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) => ResponseModal(
                                          texto: value,
                                        ),
                                      ),
                                    ).then((value){
                                      Navigator.pop(context);
                                    });
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
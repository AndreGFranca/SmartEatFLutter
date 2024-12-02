import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/reset_password/validate_code.dart';
import 'package:smart_eats/models/confirm/confirm_item_count_table.dart';
import 'package:smart_eats/models/reset_password/email_model.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import 'package:smart_eats/services/http_service.dart';
import 'package:smart_eats/services/reset_password/reset_password_service.dart';
import 'package:smart_eats/validators/utils_validators.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class ForgetPassWord extends StatefulWidget {
  EmailModel? emailModel;
  late ResetPasswordService _resetPasswordService = ResetPasswordService();
  late bool loading = false;
  @override
  State<ForgetPassWord> createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dsEmail = TextEditingController();

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
                  obscureText: false,
                  validator: (String? value) {
                    if (DefaultValidators.textValidator(value)) {
                      return 'Insira o email';
                    }
                    return null;
                  },
                  controller: dsEmail,
                  decoration: const InputDecoration(
                    // hintText: 'Qual é o seu nome?',
                    labelText: 'Email:',
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
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Enviaremos um email com um código para redefinição de senha.',
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
                            label: 'Enviar por email',
                            onPressed: ()async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  widget.loading = true;
                                });
                                try{
                                  widget.emailModel = EmailModel(
                                    Email: dsEmail.text,
                                  );

                                  await widget._resetPasswordService
                                      .SendCode(widget.emailModel!)
                                      .then((value) async {
                                          Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context) => ValidateCode(
                                                email: widget.emailModel!.Email,
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
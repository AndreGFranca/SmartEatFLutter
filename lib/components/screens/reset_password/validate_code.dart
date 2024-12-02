import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/reset_password/update_password.dart';
import 'package:smart_eats/models/confirm/confirm_item_count_table.dart';
import 'package:smart_eats/models/reset_password/email_model.dart';
import 'package:smart_eats/models/reset_password/validate_code_model.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import 'package:smart_eats/services/http_service.dart';
import 'package:smart_eats/services/reset_password/reset_password_service.dart';
import 'package:smart_eats/validators/utils_validators.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class ValidateCode extends StatefulWidget {
  ValidateCodeModel? validateCodeModel;
  final String email;
  late ResetPasswordService _resetPasswordService = ResetPasswordService();
  late bool loading = false;
  ValidateCode({super.key, required this.email});
  @override
  State<ValidateCode> createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dsCode = TextEditingController();

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
                      return 'Digite o código de validação';
                    }
                    return null;
                  },
                  controller: dsCode,
                  decoration: const InputDecoration(
                    // hintText: 'Qual é o seu nome?',
                    labelText: 'Digite o código enviado por email:',
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
                                  widget.validateCodeModel = ValidateCodeModel(
                                    Email: widget.email,
                                    Code: dsCode.text
                                  );

                                  await widget._resetPasswordService
                                      .ValidateCode(widget.validateCodeModel!)
                                      .then((value) async {
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdatePassword(
                                          email: widget.validateCodeModel!.Email,
                                          code: widget.validateCodeModel!.Code,
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
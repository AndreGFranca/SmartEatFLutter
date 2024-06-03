import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/contexts/user_context.dart';

import '../../models/user/login_model.dart';
import '../../services/http_service.dart';
import '../screens/menu/menu.dart';
import '../utils/confirm_button.dart';
import '../utils/label_input.dart';
import 'login/loginField.dart';

class LoginForm extends StatefulWidget {

  LoginForm({super.key});
  late bool loading = false;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late HttpService _httpService = HttpService();

  final _storage = FlutterSecureStorage();

  TextEditingController dsEmailController = TextEditingController();

  TextEditingController dsSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);
    return Scaffold(
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(1, -0.5),
                end: Alignment(1, 1),
                // stops: <double>[0.2,1],
                colors: <Color>[
                  Color.fromRGBO(255, 247, 244, 1),
                  Color.fromRGBO(254, 214, 202, 1),
                ]),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      color: Colors.orange,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  LoginField(text: 'Usuário', controller: dsEmailController),
                  LoginField(
                    text: 'Senha',
                    controller: dsSenhaController,
                    isPassword: true,
                  ),
                  if(!widget.loading)
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 15),
                    child: ConfirmButton(
                      label: 'Entrar',
                      onPressed: () async {
                        setState(() {
                          widget.loading = true;
                        });

                        try{
                          await _httpService
                              .post(
                              '/usuarios/login',
                              LoginModel(
                                  email: dsEmailController.text,
                                  password: dsSenhaController.text)
                                  .toJson())
                              .then((value) async {
                            await _storage.write(key: 'auth_token', value: value);
                            Map<String, dynamic> decodedToken =
                            JwtDecoder.decode(value);
                            userContext.PreencheVariaveis(decodedToken);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Menu(
                                  companyId: int.parse(userContext.CompanyId!),
                                  idFuncionario: userContext.Id!,
                                ),
                              ),
                            );
                          });
                        }catch(e){
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
                      },
                    ),
                  )
                  else
                    CircularProgressIndicator(),
                  TextButton(
                    onPressed: () {},
                    child: TextLabel(
                      text: 'Esqueci Minha Senha',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

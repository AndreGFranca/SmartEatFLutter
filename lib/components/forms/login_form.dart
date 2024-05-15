import 'package:flutter/material.dart';
import 'package:smart_eats/components/screens/menu.dart';

import '../utils/confirm_button.dart';
import '../utils/label_input.dart';
import 'login/loginField.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Form(
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
                  LoginField(text: 'Usuário'),
                  LoginField(text: 'Senha'),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 15),
                    child: ConfirmButton(
                      label: 'Entrar',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Menu(),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                    },
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

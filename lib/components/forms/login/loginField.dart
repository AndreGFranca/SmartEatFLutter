import 'package:flutter/material.dart';

import '../../utils/label_input.dart';

class LoginField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  late bool isPassword;
  LoginField({super.key, required this.text, required this.controller, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextLabel(
              text: text,
              alignment: TextAlign.left,
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 1))),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/usuario/password_edit.dart';
import 'package:smart_eats/validators/utils_validators.dart';

import '../../../models/user/user_model.dart';
import '../utils/confirm_button.dart';
import '../utils/default_colors.dart';

class Justify extends StatefulWidget {

  Justify({super.key});

  @override
  State<Justify> createState() => _JustifyState();
}

class _JustifyState extends State<Justify> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDay;
  final _justificativaController = TextEditingController();
  TextEditingController dsJustifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Justificativa',
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selecione os dias para justificar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: DefaultColors.primaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                  color: DefaultColors.primaryColor.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('06/06'),
                      value: '06/06',
                      groupValue: _selectedDay,
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('07/06'),
                      value: '07/06',
                      groupValue: _selectedDay,
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: DefaultColors.primaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                  color: DefaultColors.primaryColor.withOpacity(0.1),
                ),
                child: TextFormField(
                  controller: _justificativaController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escreva aqui sua justificativa',
                    hintStyle: TextStyle(color: DefaultColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  // Lógica para anexar documento
                },
                icon: Icon(Icons.attach_file, color: DefaultColors.primaryColor),
                label: Text('Anexar documento', style: TextStyle(color: DefaultColors.primaryColor)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: DefaultColors.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  children: [
                    ConfirmButton(
                        label: 'Enviar Justificativa',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

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

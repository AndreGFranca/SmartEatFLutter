import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/usuario/create_worker.dart';
import 'package:smart_eats/components/screens/usuario/password_edit.dart';
import 'package:smart_eats/validators/utils_validators.dart';

import '../../../models/user/user_model.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class WorkersList extends StatefulWidget {
  WorkersList({super.key});

  @override
  State<WorkersList> createState() => _PerfilEditState();
}

class _PerfilEditState extends State<WorkersList> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> colaboradores = [
    {"nome": "Airfryer de Souza", "perfil": "Rh", "ativo": "true"},
    {"nome": "Frigideira Alves de ...", "perfil": "Clb", "ativo": "true"},
    {"nome": "Panela Lopes", "perfil": "Czn", "ativo": "true"},
    {"nome": "Fogão da Silva", "perfil": "Clb", "ativo": "true"},
  ];
  TextEditingController dsJustifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Colaboradores',
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar Colaborador',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: DefaultColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: DefaultColors.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Nome')),
                      DataColumn(label: Text('Perfil')),
                      DataColumn(label: Text('Ativo')),
                      DataColumn(label: Text('Ações')),
                    ],
                    rows: colaboradores.map((colaborador) {
                      return DataRow(cells: [
                        DataCell(
                          SizedBox(
                            child: Text(
                              colaborador['nome']!,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ),
                        DataCell(Text(colaborador['perfil']!)),
                        DataCell(Icon(
                          Icons.check_circle,
                          color: DefaultColors.primaryColor,
                        )),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: DefaultColors.primaryColor),
                              onPressed: () {},
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: DefaultColors.primaryColor),
                    onPressed: () {},
                  ),
                  for (int i = 1; i <= 3; i++)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '$i',
                        style: TextStyle(color: DefaultColors.primaryColor),
                      ),
                    ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: DefaultColors.primaryColor),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  children: [
                    ConfirmButton(
                        label: 'Cadastrar',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateWorker(),
                            ),
                          );
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

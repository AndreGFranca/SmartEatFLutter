import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import '../utils/default_colors.dart';

class Confirms extends StatefulWidget {
  Confirms({super.key});

  @override
  State<Confirms> createState() => _ConfirmsState();
}

class _ConfirmsState extends State<Confirms> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> horarios = [
    {"horario": "11", "qtdPessoas": "20"},
    {"horario": "12", "qtdPessoas": "30"},
    {"horario": "13", "qtdPessoas": "5"},
    {"horario": "14", "qtdPessoas": "15"},
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
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                            'Horário',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto-Regular',
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Qtd. Pessoas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto-Regular',
                            ),
                          )),
                        ],
                        rows: horarios.map((colaborador) {
                          return DataRow(cells: [
                            DataCell(
                              Center(
                                child: Text(
                                  colaborador['horario']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto-Regular',
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Center(
                              child: Text(
                                colaborador['qtdPessoas']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Regular',
                                ),
                              ),
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        backgroundColor: DefaultColors.backgroudColor,
      ),
    );
  }
}

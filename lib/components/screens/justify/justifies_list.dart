import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/justify/justify_confirm.dart';
import 'package:smart_eats/components/screens/usuario/create_worker.dart';
import 'package:smart_eats/enums/type_user.dart';
import 'package:smart_eats/models/justify/justify_read.dart';
import 'package:smart_eats/services/justify/justify_service.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class JustifiesList extends StatefulWidget {
  late List<JustifyRead> justifies = [];
  late JustifyService _justifyService = JustifyService();

  late bool loading = false;

  JustifiesList({super.key,});

  @override
  State<JustifiesList> createState() => _JustifiesListState();
}

class _JustifiesListState extends State<JustifiesList> {

  Future _fetchData() async {
    setState(() {
      widget.loading = true;
    });
    try {
      await widget._justifyService.ListJustifies().then((value) {
        widget.justifies = [];
        value.forEach((element) {
          widget.justifies.add(JustifyRead.fromJson(element));
        });
        setState(() {
          widget.loading = false;
        });
      });
    } catch (e) {
      var erro = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro),
        ),
      );
      setState(() {
        widget.loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        titleAppBar: 'Justificativas',
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.loading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (widget.justifies.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Data')),
                          DataColumn(label: Text('Ações')),
                        ],
                        rows: widget.justifies.map((justificativa) {
                          return DataRow(cells: [
                            DataCell(
                              SizedBox(
                                child: Text(
                                  justificativa.Funcionario.Nome,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                            if (justificativa.Aprovado == true)
                              DataCell(Icon(
                                Icons.check_circle,
                                color: DefaultColors.primaryColor,
                              ))
                            else if(justificativa.Aprovado == false)
                              DataCell(Icon(
                                Icons.cancel_rounded,
                                color: DefaultColors.primaryColor,
                              ))
                            else
                              DataCell(Icon(
                              Icons.circle_outlined,
                              color: DefaultColors.primaryColor,
                            )),
                            DataCell(
                              SizedBox(
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(justificativa.Confirmacao.DataDeConfirmacao),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: DefaultColors.primaryColor),
                                  onPressed: () async{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JustifyConfirm(
                                          justificativa: justificativa,
                                        ),
                                      ),
                                    ).then((value)async{
                                      await _fetchData();
                                    });
                                  },
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  )
              else
                Center(child: Text("Sem resultados")),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: DefaultColors.primaryColor),
                    onPressed: () {},
                  ),
                  for (int i = 1; i <= 1; i++)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '$i',
                        style: TextStyle(color: DefaultColors.primaryColor),
                      ),
                    ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        color: DefaultColors.primaryColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}

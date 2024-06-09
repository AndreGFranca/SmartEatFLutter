import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/models/confirm/confirm_item_count_table.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import '../utils/default_colors.dart';

class Confirms extends StatefulWidget {
  late bool loading = false;
  final int companyId;
  Confirms({super.key, required this.companyId});
  ConfirmService _confirmService = ConfirmService();
  @override
  State<Confirms> createState() => _ConfirmsState();
}

class _ConfirmsState extends State<Confirms> {
  final _formKey = GlobalKey<FormState>();
  List<ConfirmItemCountTable> horarios = [
  ];
  TextEditingController dsJustifyController = TextEditingController();

  Future _fetchData()async{
    setState(() {
      widget.loading = true;
    });
    horarios = await widget._confirmService.GetCountConfirmsDate(widget.companyId);
    setState(() {
      widget.loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
      _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        titleAppBar: 'Confirmações',
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!widget.loading)
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
                        rows: horarios.map((confirms) {
                          return DataRow(cells: [
                            DataCell(
                              Center(
                                child: Text(
                                  confirms.HorarioAlmoco,
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
                                confirms.QtdPessoas.toString(),
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
                )
                else
                  Center(child: CircularProgressIndicator(),)
              ]),
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/models/justify/justify_create.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';
import 'package:smart_eats/services/justify/justify_service.dart';
import '../../../models/confirm/confirm_model.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class Justify extends StatefulWidget {
  Justify({super.key, required this.idFuncionario});

  bool loading = false;
  ConfirmService _confirmService = ConfirmService();
  JustifyService _justifyService = JustifyService();
  List<ConfirmModel> listaDiasNaoComparecidos = [];
  final String idFuncionario;

  @override
  State<Justify> createState() => _JustifyState();
}

class _JustifyState extends State<Justify> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedId;
  final _justificativaController = TextEditingController();
  TextEditingController dsJustifyController = TextEditingController();

  Future _feetchData() async {
    setState(() {
      widget.loading = true;
    });
    widget.listaDiasNaoComparecidos.clear();
    widget.listaDiasNaoComparecidos = await widget._confirmService
        .GetNotPresenceDaysConfirmed(widget.idFuncionario);
    setState(() {
      widget.loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _feetchData();
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Justificativa',
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selecione o dia para justificar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (!widget.loading &&
                    widget.listaDiasNaoComparecidos.isNotEmpty)
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: DefaultColors.primaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                        color: DefaultColors.primaryColor.withOpacity(0.1),
                      ),
                      child: ListView.builder(
                        itemCount: widget.listaDiasNaoComparecidos.length,
                        itemBuilder: (e, index) => RadioListTile(
                            title: Text(
                              DateFormat("dd/MM/yyyy").format(widget
                                  .listaDiasNaoComparecidos[index]
                                  .DataDeConfirmacao),
                            ),
                            value: index,
                            groupValue: _selectedId,
                            onChanged: (value) {
                              setState(() {
                                _selectedId = value;
                              });
                            }),
                      ),
                    ),
                  )
                else if (widget.loading)
                  Center(child: CircularProgressIndicator())
                else if (widget.listaDiasNaoComparecidos.isEmpty)
                  Center(child: Text("Sem dias para justificar!")),
                SizedBox(height: 20),
                if (widget.listaDiasNaoComparecidos.isNotEmpty)
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
                // OutlinedButton.icon(
                //   onPressed: () {
                //     // Lógica para anexar documento
                //   },
                //   icon: Icon(Icons.attach_file,
                //       color: DefaultColors.primaryColor),
                //   label: Text('Anexar documento',
                //       style: TextStyle(color: DefaultColors.primaryColor)),
                //   style: OutlinedButton.styleFrom(
                //     side: BorderSide(color: DefaultColors.primaryColor),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.0)),
                //   ),
                // ),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Column(
                    children: [
                      if (!widget.loading && widget.listaDiasNaoComparecidos.isNotEmpty)
                        ConfirmButton(
                            label: 'Enviar Justificativa',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    widget.loading = true;
                                  });
                                  var create = JustifyCreate(
                                    IdEmpresa: widget
                                        .listaDiasNaoComparecidos[_selectedId!]
                                        .IdEmpresa,
                                    IdFuncionario: widget
                                        .listaDiasNaoComparecidos[_selectedId!]
                                        .IdFuncionario,
                                    IdConfirmacao: widget
                                        .listaDiasNaoComparecidos[_selectedId!]
                                        .Id!,
                                    Justificativa:
                                        _justificativaController.text,
                                  );

                                  await widget._justifyService
                                      .RegisterJustify(create)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResponseModal(
                                          texto: value,
                                        ),
                                      ),
                                    ).then((value) {
                                      Navigator.pop(context);
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

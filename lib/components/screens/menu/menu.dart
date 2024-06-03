import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smart_eats/components/app_bars/main_app_bar_menu.dart';
import 'package:smart_eats/components/screens/select_hour.dart';
import 'package:smart_eats/components/utils/confirm_button.dart';
import 'package:smart_eats/services/confirm/confirm_service.dart';

import '../../../models/Menu/menu_model.dart';
import '../../../models/confirm/confirm_model.dart';
import '../../../services/menu/menu_service.dart';
import '../../menu/cardapio_card.dart';
import '../../utils/default_colors.dart';

class Menu extends StatefulWidget {
  Menu({super.key, required this.companyId, required this.idFuncionario});

  MenuService _service = MenuService();
  ConfirmService _confirmService = ConfirmService();
  int? _selectedHour;
  List<String> listaDeHorarios = [];
  final int companyId;
  final String idFuncionario;
  List<int> listaDeConfimacoes = [];
  List<MenuModel> listMenus = [
    // MenuModel(DiaSemana: 'Segunda', Data: DateTime.now())
  ];
  late bool loading = false;

  DateTime _startOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday % 7));
  DateTime _endOfWeek =
      DateTime.now().add(Duration(days: 6 - (DateTime.now().weekday % 7)));

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late int? value;

  Future _feetchData() async {
    setState(() {
      widget.loading = true;
    });
    widget.listMenus = await widget._service.GetMenuWeek(widget.companyId);
    widget.listaDeHorarios = await widget._confirmService.GetAvailableTimes();
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
    return Scaffold(
      appBar: MainAppBar(onChange: _feetchData),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Confirmar Cardápio',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${DateFormat('dd/MM').format(widget._startOfWeek)} - ${DateFormat('dd/MM').format(widget._endOfWeek)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto-Regular',
                  ),
                ),
              ],
            ),
            if(!widget.loading)
            Expanded(
              child: ListView.builder(
                itemCount: widget.listMenus.length,
                itemBuilder: (context, index) {
                  return CardapioCard(
                    diaSemana: widget.listMenus[index].DiaSemana,
                    pratos: widget.listMenus[index].Pratos!
                        .map((e) => e.Nome)
                        .toList(),
                    onChange: (bool variavel) {
                      if (variavel) {
                        widget.listaDeConfimacoes.add(index);
                      } else {
                        widget.listaDeConfimacoes.remove(index);
                      }
                    },
                  );
                },
              ),
            )
            else
              CircularProgressIndicator(),
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectHour(widget.listaDeHorarios),
                        ),
                      ).then((value) {
                        setState(() {
                          widget._selectedHour = value;
                        });
                      });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm),
                          if (widget._selectedHour == null)
                            Text('Selecione o horário')
                          else
                            Text(
                                '${(widget.listaDeHorarios[widget._selectedHour!]).replaceFirst(RegExp('.{3}\$'), "")}h')
                        ]),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: DefaultColors.backgroudColor,
                      side: const BorderSide(color: DefaultColors.primaryColor),
                    ),
                  ),
                  SizedBox(height: 16),
                  ConfirmButton(
                      label: 'Confirmar Presença',
                      onPressed: () async {
                        if (widget.listaDeConfimacoes.isNotEmpty &&
                            widget._selectedHour != null) {
                          List<ConfirmModel> listConfirmacoes =
                              widget.listaDeConfimacoes
                                  .map((e) => ConfirmModel(
                                        DataDeConfirmacao: widget.listMenus[e].Data,
                                        HoraConfirmacao: widget.listaDeHorarios[widget._selectedHour!],
                                        IdEmpresa: widget.companyId,
                                        IdFuncionario: widget.idFuncionario
                                      ))
                                  .toList();
                          print(listConfirmacoes);
                          var result = await widget._confirmService.RegisterConfirm(listConfirmacoes);
                          if(result){
                            print("funfou");
                          }else{
                            print("falhou");
                          }

                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}

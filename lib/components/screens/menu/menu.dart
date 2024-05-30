import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_eats/components/app_bars/main_app_bar_menu.dart';
import 'package:smart_eats/components/screens/select_hour.dart';
import 'package:smart_eats/components/utils/confirm_button.dart';

import '../../menu/cardapio_card.dart';
import '../../utils/default_colors.dart';

class Menu extends StatefulWidget {
  Menu({super.key});
  int? _selectedHour;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late int? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
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
                  '12/06 - 16/06',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto-Regular',
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  CardapioCard(
                    diaSemana: 'Segunda',
                    pratos: ['Feijoadaa', 'Feijoada', 'Feijoada'],
                  ),
                  CardapioCard(
                    diaSemana: 'Segunda',
                    pratos: ['Feijoadaa', 'Feijoada', 'Feijoada'],
                  ),
                  CardapioCard(
                    diaSemana: 'Segunda',
                    pratos: ['Feijoadaa', 'Feijoada', 'Feijoada'],
                  ),
                  CardapioCard(
                    diaSemana: 'Segunda',
                    pratos: ['Feijoadaa', 'Feijoada', 'Feijoada'],
                  ),
                  CardapioCard(
                    diaSemana: 'Segunda',
                    pratos: ['Feijoadaa', 'Feijoada', 'Feijoada'],
                  ),
                ],
              ),
            ),
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
                          builder: (context) => SelectHour(),
                        ),
                      ).then((value){
                        setState(() {
                          widget._selectedHour = value;
                        });
                      });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm),
                          if(widget._selectedHour == null)
                          Text('Selecione o horário')
                          else
                            Text('${widget._selectedHour}h')
                        ]),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: DefaultColors.backgroudColor,
                      side: const BorderSide(color: DefaultColors.primaryColor),
                    ),
                  ),
                  SizedBox(height: 16),
                  ConfirmButton(label: 'Confirmar Presença', onPressed: () {})
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

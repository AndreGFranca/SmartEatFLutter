import 'package:flutter/material.dart';

import '../utils/default_colors.dart';

class CardapioCard extends StatefulWidget {
  final String diaSemana;
  final List<String> pratos;
  final Function onChange;
  final bool editable;
  late String? horario;


  // final bool isSelected;
  bool _isSelected = false;

  CardapioCard({
    super.key,
    required this.diaSemana,
    required this.pratos,
    required this.onChange,
    required this.editable,
    this.horario = null,
    // required this.isSelected,
  });

  @override
  State<CardapioCard> createState() => _CardapioCardState();
}

class _CardapioCardState extends State<CardapioCard> {
  // @override
  // void initState() {
  //   super.initState();
  //   this.widget._isSelected = this.widget.isSelected;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      color: DefaultColors.backgroudColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: DefaultColors.primaryColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.diaSemana,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w500,
                    color: DefaultColors.primaryColor,
                  ),
                ),
                if(widget.editable)
                if (widget._isSelected)
                  IconButton(
                    onPressed: () {
                      this.widget._isSelected = false;
                      widget.onChange(false);
                      setState(() {});
                    },
                    icon: Icon(Icons.check_circle,
                        color: DefaultColors.primaryColor),
                  )
                else
                  IconButton(
                    onPressed: () {

                      this.widget._isSelected = true;
                      widget.onChange(true);
                      setState(() {});
                    },
                    icon:
                        Icon(Icons.radio_button_unchecked, color: Colors.grey),
                  ),
                if(widget.horario != null)
                  Text(widget.horario!.replaceFirst(RegExp('.{3}\$'), ""))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.pratos.map(
                      (prato) => Text(
                        '• $prato',
                        style: const TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

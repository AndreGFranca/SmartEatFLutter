import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/utils/confirm_button.dart';
import 'package:smart_eats/components/utils/hour_input.dart';
import '../utils/default_colors.dart';

class SelectHour extends StatefulWidget {
  int? selectedValue;
  late List<String> listAvaliableTimes = <String>[];

  SelectHour(
    this.listAvaliableTimes, {
    super.key,
  });

  @override
  State<SelectHour> createState() => _SelectHourState();
}

class _SelectHourState extends State<SelectHour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(titleAppBar: 'Selecione um Horário'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.listAvaliableTimes.length,
                  itemBuilder:(context,index){
                    return HourInput(
                              value: index,
                              text: widget.listAvaliableTimes[index].replaceFirst(RegExp('.{3}\$'), ""),
                              groupValue: widget.selectedValue,
                              onChanged: (int? newValue) {
                                setState(() {
                                  widget.selectedValue = newValue;
                                });
                              },
                            );
                  },
                    // HourInput(
                    //   value: 1,
                    //   text: '11:00h',
                    //   groupValue: widget.selectedValue,
                    //   onChanged: (int? newValue) {
                    //     setState(() {
                    //       widget.selectedValue = newValue;
                    //     });
                    //   },
                    // ),
                    // HourInput(
                    //   value: 2,
                    //   text: '11:30h',
                    //   groupValue: widget.selectedValue,
                    //   onChanged: (int? newValue) {
                    //     setState(() {
                    //       widget.selectedValue = newValue;
                    //     });
                    //   },
                    // ),
                    // HourInput(
                    //   value: 3,
                    //   text: '12:00h',
                    //   groupValue: widget.selectedValue,
                    //   onChanged: (int? newValue) {
                    //     setState(() {
                    //       widget.selectedValue = newValue;
                    //     });
                    //   },
                    // ),
                    // HourInput(
                    //   value: 4,
                    //   text: '12:30h',
                    //   groupValue: widget.selectedValue,
                    //   onChanged: (int? newValue) {
                    //     setState(() {
                    //       widget.selectedValue = newValue;
                    //     });
                    //   },
                    // ),

                ),

              ),
              Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  children: [
                    ConfirmButton(
                        label: 'Salvar Alterações',
                        onPressed: () {
                          Navigator.pop(context, widget.selectedValue);
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: DefaultColors.backgroudColor,
    );
  }
}

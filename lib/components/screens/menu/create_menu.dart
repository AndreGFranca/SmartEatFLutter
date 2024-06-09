import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:smart_eats/models/Menu/plate_model.dart';

import '../../../contexts/user_context.dart';
import '../../../enums/week_days.dart';
import '../../../models/Menu/menu_model.dart';
import '../../../services/menu/menu_service.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class CreateMenu extends StatefulWidget {
  MenuService _service = MenuService();
  final int companyId;
  CreateMenu({super.key, required this.companyId});
  late bool loading = false;
  @override
  State<CreateMenu> createState() => _CreateMenuState();
}

class _CreateMenuState extends State<CreateMenu> {

  final _formKey = GlobalKey<FormState>();

  List<MenuModel> listMenus = [
  ];

  Future _feetchData()async{
    setState(() {
      widget.loading = true;
    });
    listMenus = await widget._service.GetMenuWeek(widget.companyId);
    setState(() {
      widget.loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
      _feetchData();
  }

  DateTime _startOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday % 7));
  DateTime _endOfWeek =
      DateTime.now().add(Duration(days: 6 - (DateTime.now().weekday % 7)));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Cadastro Cardápio',
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Semana ${DateFormat('dd/MM').format(_startOfWeek)} - ${DateFormat('dd/MM').format(_endOfWeek)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if(!widget.loading)
                Expanded(
                  child: ListView.builder(
                    itemCount: listMenus.length,
                    itemBuilder: (context, index) {
                      return _buildDayCard(index);
                    },
                  ),
                )
                else
                  Center(child: CircularProgressIndicator()),
                if(!widget.loading)
                ElevatedButton(
                  onPressed: () => _addDay(widget.companyId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.backgroudColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: DefaultColors.primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Adicionar dia'),
                ),
                if(!widget.loading)
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Column(
                    children: [
                      ConfirmButton(
                          label: 'Salvar',
                          onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                widget.loading = true;
                              });
                              try{
                                var result = await widget._service.RegisterMenu(widget.companyId, listMenus.where((a) => a.Editavel == true).toList())
                                .then((value){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResponseModal(
                                        texto: value,
                                      ),
                                    ),
                                  ).then((value){
                                    setState(() {
                                      widget.loading = true;
                                    });
                                    _feetchData();
                                    setState(() {
                                      widget.loading = false;
                                    });
                                  });
                                });

                              }catch(e){
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
                )
                else
                  Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
        backgroundColor: DefaultColors.backgroudColor,
      ),
    );
  }

  Widget _buildDayCard(int index) {
    TextEditingController _mealController = TextEditingController();
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: DefaultColors.primaryColor,),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${listMenus[index].DiaSemana} ${DateFormat('dd/MM').format(listMenus[index].Data)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: DefaultColors.primaryColor,
                  ),
                ),
                if(listMenus[index].Editavel)
                IconButton(
                  icon: Icon(Icons.delete, color: DefaultColors.primaryColor),
                  onPressed: () {
                    setState(() {
                      if (listMenus[index].Pratos!.isEmpty) {
                        listMenus.removeAt(index);
                      }
                    });
                  },
                )
              ],
            ),
            ...listMenus[index].Pratos!.map<Widget>((meal) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(meal.Nome, style: TextStyle(fontSize: 16)),
                  if(listMenus[index].Editavel)
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: DefaultColors.primaryColor),
                    onPressed: () {
                      setState(() {
                        listMenus[index].Pratos!.remove(meal);
                        if (listMenus[index].Pratos!.isEmpty) {
                          listMenus.removeAt(index);
                        }
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            if(listMenus[index].Editavel)
            TextField(
              controller: _mealController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do prato',
              ),
              onSubmitted: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    listMenus[index].Pratos!.add(PlateModel(Nome: value));
                    _mealController.clear();
                  }
                });
              },
            ),
            SizedBox(height: 8),
            if(listMenus[index].Editavel)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_mealController.text.isNotEmpty) {
                      listMenus[index].Pratos!.add(PlateModel(Nome: _mealController.text));
                      _mealController.clear();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DefaultColors.backgroudColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: DefaultColors.primaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Adicionar prato'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addDay(int idCompany) {
    setState(() {
      String newDay;
      DateTime newDate;
      DateTime dataAtual = DateTime.now();
      if (listMenus.isEmpty) {
        newDay = DayMap.weekDays.keys.toList()[dataAtual.weekday % 7];
        newDate = dataAtual;
        // newDate = _startOfWeek.add(Duration(days: 1));
      } else {
        String lastDay = listMenus.last.DiaSemana;
        int dayIndex = DayMap.weekDays.keys.toList().indexOf(lastDay);
        newDay = DayMap.weekDays.keys.toList()[dayIndex + 1];
        newDate = listMenus.last.Data.add(Duration(days: 1));
      }
      listMenus.add(MenuModel(DiaSemana: newDay, Data: newDate, CompanyId: idCompany, Pratos: []));
    });
  }
}

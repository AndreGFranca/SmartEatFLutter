import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:intl/intl.dart';

import '../../../models/user/create_user_model.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class CreateMenu extends StatefulWidget {

  CreateMenu({super.key});

  @override
  State<CreateMenu> createState() => _CreateMenuState();
}

class _CreateMenuState extends State<CreateMenu> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _days = [
    {
      'day': 'Segunda',
      'date': DateTime.now(),
      'meals': ['Feijoada', 'Farofa rica']
    },
  ];
  Map<String, String> _dayMap = {
    'Segunda': 'Monday',
    'Terça': 'Tuesday',
    'Quarta': 'Wednesday',
    'Quinta': 'Thursday',
    'Sexta': 'Friday',
  };

  DateTime _startOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday));
  DateTime _endOfWeek =
      DateTime.now().add(Duration(days: 6 - DateTime.now().weekday));

  @override
  void initState() {
    super.initState();
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  TextEditingController dsNomeController = TextEditingController();
  TextEditingController dsCpfController = TextEditingController();
  TextEditingController dsEmailController = TextEditingController();
  TextEditingController dsSenhaController = TextEditingController();
  TextEditingController dsPerfilController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Cadastro Cardápio',
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Semana ${DateFormat('dd/MM').format(_startOfWeek)} - ${DateFormat('dd/MM').format(_endOfWeek)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    return _buildDayCard(index);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _addDay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: DefaultColors.backgroudColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: DefaultColors.primaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Adicionar dia'),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  children: [
                    ConfirmButton(
                        label: 'Salvar',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
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
                  '${_days[index]['day']} ${DateFormat('dd/MM').format(_days[index]['date'])}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: DefaultColors.primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: DefaultColors.primaryColor),
                  onPressed: () {
                    setState(() {
                      if (_days[index]['meals'].isEmpty) {
                        _days.removeAt(index);
                      }
                    });
                  },
                )
              ],
            ),
            ..._days[index]['meals'].map<Widget>((meal) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(meal, style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: DefaultColors.primaryColor),
                    onPressed: () {
                      setState(() {
                        _days[index]['meals'].remove(meal);
                        if (_days[index]['meals'].isEmpty) {
                          _days.removeAt(index);
                        }
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            TextField(
              controller: _mealController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do prato',
              ),
              onSubmitted: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _days[index]['meals'].add(value);
                    _mealController.clear();
                  }
                });
              },
            ),
            SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_mealController.text.isNotEmpty) {
                      _days[index]['meals'].add(_mealController.text);
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

  void _addDay() {
    setState(() {
      String newDay;
      DateTime newDate;
      if (_days.isEmpty) {
        newDay = 'Segunda';
        newDate = _startOfWeek.add(Duration(days: 1));
      } else {
        String lastDay = _days.last['day'];
        int dayIndex = _dayMap.keys.toList().indexOf(lastDay);
        newDay = _dayMap.keys.toList()[dayIndex + 1];
        newDate = _days.last['date'].add(Duration(days: 1));
      }
      _days.add({'day': newDay, 'date': newDate, 'meals': []});
    });
  }
}

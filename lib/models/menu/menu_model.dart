import 'package:intl/intl.dart';
import 'package:smart_eats/models/Menu/plate_model.dart';

import '../../enums/week_days.dart';

class MenuModel {
  final String DiaSemana;
  final int CompanyId;
  final DateTime Data;
  late bool Editavel;
  late List<PlateModel>? Pratos;

  MenuModel({
    required this.DiaSemana,
    required this.Data,
    required this.CompanyId,
    this.Pratos = null,
    this.Editavel = true,
  });

  Map<String, dynamic> toJson() {
    return   {
      "data": DateFormat('yyyy-MM-dd').format(Data),
      "idEmpresa": CompanyId,
      "platesDay": [...Pratos!.map((e) => {
        "prato": e.Nome,
        "cardapioDate": DateFormat('yyyy-MM-dd').format(Data),
        "companyId": CompanyId,
      })]
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      DiaSemana: DayMap.weekDays.keys.toList()[DateTime.parse(json['data']).weekday % 7],
      Data: DateTime.parse(json['data']),
      CompanyId: json['idEmpresa'],
      Editavel: json['editable'],
      Pratos: (json['platesDay'] as List<dynamic>)
          .map((p) => PlateModel.fromJson(p))
          .toList(),
    );
  }
}

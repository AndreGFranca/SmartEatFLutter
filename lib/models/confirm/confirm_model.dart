import 'package:intl/intl.dart';

class ConfirmModel {
  int? Id;
  final DateTime DataDeConfirmacao;
  final String HoraConfirmacao;
  final int IdEmpresa;
  final String IdFuncionario;
  late bool? Compareceu = false;
  late bool? Confirmou;

  ConfirmModel({
    required this.DataDeConfirmacao,
    required this.HoraConfirmacao,
    required this.IdEmpresa,
    required this.IdFuncionario,
    this.Id,
    this.Compareceu,
    this.Confirmou
  });

  Map<String, dynamic> toJson() {
    return {
      "dataConfirmacao": DateFormat('yyyy-MM-dd').format(DataDeConfirmacao),
      "horaDeAlmoco": HoraConfirmacao,
      "confirmou": true,
      "idEmpresa": IdEmpresa,
      "idFuncionario": IdFuncionario
    };
  }

  factory ConfirmModel.fromJson(Map<String, dynamic> json) {
    return ConfirmModel(
      Id: json['id'],
      DataDeConfirmacao: DateTime.parse(json['dataConfirmacao']),
      HoraConfirmacao: json['horaDeAlmoco'],
      IdEmpresa: json['idEmpresa'],
      IdFuncionario: json['idFuncionario'],
      Compareceu: json['compareceu'],
      Confirmou: json['confirmou'],
    );
  }
}

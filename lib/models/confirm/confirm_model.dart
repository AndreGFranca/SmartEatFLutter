import 'package:intl/intl.dart';

class ConfirmModel {
  final DateTime DataDeConfirmacao;
  final String HoraConfirmacao;
  final int IdEmpresa;
  final String IdFuncionario;

  ConfirmModel({
    required this.DataDeConfirmacao,
    required this.HoraConfirmacao,
    required this.IdEmpresa,
    required this.IdFuncionario,
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
}

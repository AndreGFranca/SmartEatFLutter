import 'package:smart_eats/models/user/create_user_model.dart';

import '../confirm/confirm_model.dart';

class JustifyRead {
  int Id;
  String Justificativa;
  int IdConfirmacao;
  String IdFuncionario;
  int IdEmpresa;
  bool? Aprovado;
  String? MotivoRecusa;
  String? IdAprovador;
  CreateUserModel Funcionario;
  CreateUserModel? Aprovador;
  ConfirmModel Confirmacao;

  JustifyRead({
    required this.Id,
    required this.Justificativa,
    required this.IdConfirmacao,
    required this.IdFuncionario,
    this.Aprovado,
    this.MotivoRecusa,
    this.IdAprovador,
    required this.Funcionario,
    this.Aprovador,
    required this.IdEmpresa,
    required this.Confirmacao,
  });

  Map<String, dynamic> toJson() {
    return {
      "justificativa": Justificativa,
      "idConfirmacao": IdConfirmacao,
      "idFuncionario": IdFuncionario,
      "idEmpresa": IdEmpresa
    };
  }

  Map<String, dynamic> toConfirmJson() {
    return {
      "id": Id,
      "aprovado": Aprovado!,
      "motivoRecusa": MotivoRecusa,
      "idAprovador": IdAprovador,
      "idEmpresa": IdEmpresa
    };
  }

  factory JustifyRead.fromJson(Map<String, dynamic> json) {
    return JustifyRead(
      Id: json['id'],
      Justificativa: json['justificativa'],
      IdConfirmacao: json['idConfirmacao'],
      IdFuncionario: json['idFuncionario'],
      Aprovado: json['aprovado'],
      MotivoRecusa: json['motivoRecusa'],
      IdAprovador: json['idAprovador'],
      Funcionario: CreateUserModel.fromJson(json['funcionario']),
      Aprovador: json['aprovador'] != null ? CreateUserModel.fromJson(json['funcionario']): null,
      IdEmpresa: json['idEmpresa'],
      Confirmacao: ConfirmModel.fromJson(json['confirmacao']),

    );
  }

}
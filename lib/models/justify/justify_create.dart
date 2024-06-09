class JustifyCreate {
  String Justificativa;
  int IdConfirmacao;
  String IdFuncionario;
  int IdEmpresa;

  JustifyCreate({
    required this.Justificativa,
    required this.IdConfirmacao,
    required this.IdFuncionario,
    required this.IdEmpresa
  });

  Map<String, dynamic> toJson() {
    return {
      "justificativa": Justificativa,
      "idConfirmacao": IdConfirmacao,
      "idFuncionario": IdFuncionario,
      "idEmpresa": IdEmpresa
    };
  }

}

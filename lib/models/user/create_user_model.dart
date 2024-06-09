class CreateUserModel {
  final String? Id;
  final String Nome;
  final String Cpf;
  final String Email;
  final String? Senha;
  final int Perfil;
  final bool Ativo;
  final int CompanyId;

  CreateUserModel({
    this.Id,
    required this.Perfil,
    this.Senha,
    required this.Nome,
    required this.Cpf,
    required this.Email,
    this.Ativo = true,
    required this.CompanyId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": Nome,
      "cpf": Cpf,
      "userName": Email,
      "ativo": Ativo,
      "id_Company": CompanyId,
      "typeUser": Perfil,
      "password": Cpf.replaceAll(".", "").replaceAll("-", ""),
      "rePassword":  Cpf.replaceAll(".", "").replaceAll("-", ""),
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "id": Id,
      "name": Nome,
      "cpf": Cpf,
      "userName": Email,
      "ativo": Ativo,
      "id_Company": CompanyId,
      "typeUser": Perfil,
    };
  }

  factory CreateUserModel.fromJson(Map<String, dynamic> json) {
    return CreateUserModel(
      Id: json['id'],
      Nome: json['name'],
      Cpf: json['cpf'],
      Email: json['userName'],
      Perfil: json['typeUser'],
      Ativo: json['ativo'],
      CompanyId: json['id_Company'],
    );
  }
}

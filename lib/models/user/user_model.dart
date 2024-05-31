class UserModel{
  late String? Id;
  final String Nome;
  final String Cpf;
  final String Email;

  UserModel({required this.Nome, required this.Cpf, required this.Email, this.Id});

  Map<String, dynamic> toJson() {
    return {
      "name": "$Nome",
      "cpf": "$Cpf",
      "userName": "$Email",
    };
  }
}
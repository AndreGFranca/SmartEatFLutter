class CreateUserModel {
  final String Nome;
  final String Cpf;
  final String Email;
  final String Senha;
  final int Perfil;
  final bool Ativo;

  CreateUserModel({
    required this.Perfil,
    required this.Senha,
    required this.Nome,
    required this.Cpf,
    required this.Email,
    this.Ativo = true,
  });
}

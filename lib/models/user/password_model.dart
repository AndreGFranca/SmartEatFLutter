class PasswordModel {
  final String SenhaAtual;
  final String SenhaNova;
  final String SenhaRepetida;

  PasswordModel({
    required this.SenhaAtual,
    required this.SenhaNova,
    required this.SenhaRepetida,
  });

  Map<String, dynamic> toJson() {
    return {
      "currentPassword": SenhaAtual,
      "newPassword": SenhaNova,
      "rePassword": SenhaRepetida,
    };
  }
}

class UpdatePasswordModel {
  final String Email;
  final String Code;
  final String SenhaNova;
  final String SenhaRepetida;

  UpdatePasswordModel({
    required this.Email,
    required this.Code,
    required this.SenhaNova,
    required this.SenhaRepetida,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": Email,
      "code": Code,
      "newPassword": SenhaNova,
      "confirmPassword": SenhaRepetida,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "email": Email,
      "code": Code,
      "newPassword": SenhaNova,
      "confirmPassword": SenhaRepetida,
    };
  }

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordModel(
      Email: json['email'],
      Code: json['code'],
      SenhaNova: json['newPassword'],
      SenhaRepetida: json['confirmPassword'],
    );
  }
}

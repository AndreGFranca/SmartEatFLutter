class ValidateCodeModel {
  final String Email;
  final String Code;

  ValidateCodeModel({
    required this.Email,
    required this.Code,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": Email,
      "code": Code,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "email": Email,
      "code": Code,
    };
  }

  factory ValidateCodeModel.fromJson(Map<String, dynamic> json) {
    return ValidateCodeModel(
      Email: json['email'],
      Code: json['code'],
    );
  }
}

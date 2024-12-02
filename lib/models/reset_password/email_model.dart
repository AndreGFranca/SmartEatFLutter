class EmailModel {
  final String Email;

  EmailModel({
    required this.Email,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": Email,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "email": Email,
    };
  }

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      Email: json['email'],
    );
  }
}

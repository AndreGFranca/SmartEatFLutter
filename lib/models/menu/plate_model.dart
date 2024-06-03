class PlateModel{

  final String Nome;
  PlateModel({required this.Nome});

  factory PlateModel.fromJson(Map<String, dynamic> json) {
    return PlateModel(
      Nome: json['prato'],
    );
  }
}
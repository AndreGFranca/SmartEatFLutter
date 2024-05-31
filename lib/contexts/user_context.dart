import 'package:flutter/material.dart';

class UserContext with ChangeNotifier {
  String? Id;
  String? Nome;
  String? typeUser;
  String? Cpf;
  String? UserName;

  void PreencheVariaveis(Map<String,dynamic> token) {
    this.Id = token["id"] == null? this.typeUser: token["id"];
    this.Nome = token["name"] == null? this.typeUser: token["name"];
    this.typeUser = token["typeUser"] == null? this.typeUser: token["typeUser"];
    this.Cpf = token["cpf"] == null? this.typeUser: token["cpf"];
    this.UserName = token["userName"] == null? this.typeUser: token["userName"];
    notifyListeners();
  }

  void LimparVariaveis() {
    this.Id = null;
    this.Nome = null;
    this.typeUser = null;
    this.Cpf = null;
    this.UserName = null;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class UserContext with ChangeNotifier {
  String? Id;
  String? Nome;
  String? typeUser;
  String? Cpf;
  String? UserName;
  String? CompanyId;

  void PreencheVariaveis(Map<String,dynamic> token) {
    this.Id = token["id"] == null? this.Id: token["id"];
    this.Nome = token["name"] == null? this.Nome: token["name"];
    this.typeUser = token["typeUser"] == null? this.typeUser: token["typeUser"];
    this.Cpf = token["cpf"] == null? this.Cpf: token["cpf"];
    this.UserName = token["userName"] == null? this.UserName: token["userName"];
    this.CompanyId = token["companyId"] == null? this.CompanyId: token["companyId"];
    notifyListeners();
  }

  void LimparVariaveis() {
    this.Id = null;
    this.Nome = null;
    this.typeUser = null;
    this.Cpf = null;
    this.UserName = null;
    this.CompanyId = null;
    notifyListeners();
  }
}
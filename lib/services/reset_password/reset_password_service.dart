import 'package:smart_eats/models/reset_password/email_model.dart';
import 'package:smart_eats/models/reset_password/update_password_model.dart';
import 'package:smart_eats/models/reset_password/validate_code_model.dart';

import '../../models/user/create_user_model.dart';
import '../http_service.dart';

class ResetPasswordService{
  final _httpService = HttpService();
  final String _baseUserEndPoint = "/senha";

  Future<dynamic> SendCode(EmailModel emailModel) async {
    try{
      String endpoint = '/enviar-codigo';
      var result = await _httpService.post('$_baseUserEndPoint$endpoint', emailModel.toJson());
      return result;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> ValidateCode(ValidateCodeModel validateCodeModel) async {
    try{
      String endpoint = '/validar-codigo';
      var result = await _httpService.post('$_baseUserEndPoint$endpoint', validateCodeModel.toJson());
      return result;
    }catch(e){
      throw e;
    }
  }

  Future<String> Update(UpdatePasswordModel updateUser) async {
    try{
      String endpoint = '/atualizar';
      var result = await _httpService.post('$_baseUserEndPoint$endpoint', updateUser.toJson());
      return result;
    }catch(e){
      throw e;
    }
  }
}
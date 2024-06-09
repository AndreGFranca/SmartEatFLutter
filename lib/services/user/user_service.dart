import '../../models/user/create_user_model.dart';
import '../http_service.dart';

class UserService{
  final _httpService = HttpService();
  final String _baseUserEndPoint = "/usuarios";

  Future<dynamic> RegisterUser(CreateUserModel createUsuario) async {
    try{
      String endpoint = '/cadastro';
      var result = await _httpService.post('$_baseUserEndPoint$endpoint', createUsuario.toJson());
      return result;
    }catch(e){
      throw e;
    }
  }

  Future<bool> UpdateUser(CreateUserModel updateUser) async {
    try{
      String endpoint = '/atualizar-usuario/${updateUser.Id}';
      var result = await _httpService.put('$_baseUserEndPoint$endpoint',updateUser.toJsonUpdate());
      return result;
    }catch(e){
      throw e;
    }
  }


  Future<CreateUserModel> GetUser(String userId) async {
    try{
      String endpoint = '/get-user/$userId';
      var result = await _httpService.get('$_baseUserEndPoint$endpoint',);

      return CreateUserModel(
        Id: result["id"],
        Nome: result["name"],
        Cpf: result["cpf"],
        Email: result["userName"],
        Perfil: result["typeUser"],
        Ativo: result["ativo"],
        CompanyId: result["id_Company"],
          Senha: ''
      );
    }catch(e){
      throw e;
    }
  }

  Future<List<dynamic>> ListWorkers(int companyId) async {
    return await _httpService
        .get('/usuarios/lista-funcionarios-empresa/$companyId');
  }

  Future<String> Logout() async {
    return await _httpService
        .post('$_baseUserEndPoint/logout',{});
  }

}
import 'package:smart_eats/models/Menu/menu_model.dart';
import '../http_service.dart';

class MenuService {
  final _httpService = HttpService();
  final String _baseMenusEndPoint = "/cardapios";

  Future<List<MenuModel>> GetMenuWeek(int idEmpresa) async {
    String url = '$_baseMenusEndPoint/obter-todos-cardapios-empresa/$idEmpresa';

    var resultado = await _httpService.get(url) as List<dynamic>;
    return resultado
        .map(
          (e) => MenuModel.fromJson(e),
        )
        .toList();
  }

  Future<List<MenuModel>> GetMenuWeekWorker(int idEmpresa) async {
    String url = '$_baseMenusEndPoint/obter-todos-cardapios-funcionario/$idEmpresa';

    var resultado = await _httpService.get(url) as List<dynamic>;
    return resultado
        .map(
          (e) => MenuModel.fromJson(e),
    )
        .toList();
  }

  Future<dynamic> RegisterMenu(
    int idEmpresa,
    List<MenuModel> listMenuModel,
  ) async {
    try {
      String url = '$_baseMenusEndPoint/cadastrar/$idEmpresa';
      var req = [...listMenuModel.map((e) => e.toJson())];
      var result = await _httpService.post(url, req);

      return result;
    } catch (e) {
      throw e;
    }
  }
}

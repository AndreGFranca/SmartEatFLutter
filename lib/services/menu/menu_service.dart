import 'package:intl/intl.dart';
import 'package:smart_eats/models/Menu/menu_model.dart';
import 'package:smart_eats/models/Menu/plate_model.dart';

import '../http_service.dart';

class MenuService {
  final _httpService = HttpService();
  final String _baseMenusEndPoint = "/cardapios";

  Future<List<MenuModel>> GetMenuWeek(int idEmpresa) async {
    String url = '$_baseMenusEndPoint/obter-todos-cardapios-empresa/$idEmpresa';

    var resultado = await _httpService.get(url) as List<dynamic>;
    print(resultado);
    return resultado
        .map(
          (e) => MenuModel.fromJson(e),
        )
        .toList();
  }

  Future<bool> RegisterMenu(
    int idEmpresa,
    List<MenuModel> listMenuModel,
  ) async {
    String _startOfWeek = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(Duration(days: DateTime.now().weekday)),
    );
    String _endOfWeek = DateFormat('yyyy-MM-dd').format(
      DateTime.now().add(Duration(days: 6 - DateTime.now().weekday)),
    );
    try {
      String url = '$_baseMenusEndPoint/cadastrar/$idEmpresa';
      var req = [...listMenuModel.map((e) => e.toJson())];
      print(req);
      await _httpService.post(url, req);

      return true;
    } catch (e) {
      throw e;
    }
  }
}

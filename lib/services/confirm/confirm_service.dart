import 'package:smart_eats/models/confirm/confirm_model.dart';

import '../http_service.dart';

class ConfirmService {
  final _httpService = HttpService();
  final String _baseMenusEndPoint = "/confirmacoes";

  Future<List<String>> GetAvailableTimes() async {
    String url = '$_baseMenusEndPoint/obter-horarios-disponiveis/';

    var resultado = await _httpService.get(url) as List<dynamic>;
    print(resultado);
    return resultado
        .map(
          (e) => e.toString(),
        )
        .toList();
  }

  Future<bool> RegisterConfirm(List<ConfirmModel> listConfirmModel) async {
    String url = '$_baseMenusEndPoint/confirmar-presenca';
    var req = [...listConfirmModel.map((e) => e.toJson())];
    await _httpService.post(url, req);
    return true;
  }
}

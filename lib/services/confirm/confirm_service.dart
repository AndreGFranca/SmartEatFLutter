import 'package:smart_eats/models/confirm/confirm_model.dart';

import '../../models/confirm/confirm_item_count_table.dart';
import '../http_service.dart';

class ConfirmService {
  final _httpService = HttpService();
  final String _baseMenusEndPoint = "/confirmacoes";

  Future<List<String>> GetAvailableTimes() async {
    String url = '$_baseMenusEndPoint/obter-horarios-disponiveis/';

    var resultado = await _httpService.get(url) as List<dynamic>;
    return resultado
        .map(
          (e) => e.toString(),
        )
        .toList();
  }

  Future<List<ConfirmItemCountTable>> GetCountConfirmsDate(
      int companyId) async {
    String url = '$_baseMenusEndPoint/obter-contagem-horarios/$companyId';

    var result = await _httpService.get(url) as List<dynamic>;
    var countConfirms = result
        .map(
          (e) => ConfirmItemCountTable(
            HorarioAlmoco: e["horarioAlmoco"]
                .toString()
                .replaceFirst(RegExp('.{3}\$'), ""),
            QtdPessoas: e["count"],
          ),
        )
        .toList();

    return countConfirms;
  }

  Future<String> RegisterConfirm(List<ConfirmModel> listConfirmModel) async {
    String url = '$_baseMenusEndPoint/confirmar-presenca';
    var req = [...listConfirmModel.map((e) => e.toJson())];
    var result = await _httpService.post(url, req);
    return result;
  }

  Future<String> ConfirmPresence(String idFuncionario) async {
    String url = '$_baseMenusEndPoint/confirmar-comparecimento/$idFuncionario';
    var result = await _httpService.put(url, {
      "compareceu": true,
    });
    return result;
  }

  Future<List<ConfirmModel>> GetNotPresenceDaysConfirmed(
      String idFuncionario) async {
    String url =
        '$_baseMenusEndPoint/obter-dias-nao-comparecidos/$idFuncionario';
    var resultApi = await _httpService.get(url) as List<dynamic>;
    var result = resultApi.map((e) => ConfirmModel(
          IdFuncionario: e["idFuncionario"],
          DataDeConfirmacao: DateTime.parse(e["dataConfirmacao"]),
          HoraConfirmacao: e["horaDeAlmoco"],
          IdEmpresa: e["idEmpresa"],
          Id: e["id"],
        )).toList();
    return result;
  }
}

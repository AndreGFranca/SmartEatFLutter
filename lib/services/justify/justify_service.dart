import 'package:smart_eats/models/Menu/menu_model.dart';
import 'package:smart_eats/models/justify/justify_create.dart';
import 'package:smart_eats/models/justify/justify_read.dart';
import '../http_service.dart';

class JustifyService {
  final _httpService = HttpService();
  final String _baseJustifiesEndPoint = "/justificativas";

  Future<dynamic> RegisterJustify(JustifyCreate create) async {
    try {
      String url = '$_baseJustifiesEndPoint';
      var result = await _httpService.post(url, create.toJson());

      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> ListJustifies()async{
    try {
      String url = '$_baseJustifiesEndPoint';
      var result = await _httpService.get(url);

      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> ConfirmJustify(JustifyRead confirm)async{
    try {
      String url = '$_baseJustifiesEndPoint';
      var result = await _httpService.put(url, confirm.toConfirmJson());

      return result;
    } catch (e) {
      throw e;
    }
  }
}

import 'package:impacteers/Services/data/network/network_api_services.dart';
import 'package:impacteers/res/strings.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> getUserList(Map<String, dynamic> id) async {
    dynamic response;
    try {
      response = await _apiServices.getApi(AppStrings.baseURL, params: id);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }
}

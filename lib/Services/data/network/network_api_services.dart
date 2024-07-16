import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:impacteers/Services/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  final dio = Dio();

  @override
  Future getApi(String url, {Map<String, dynamic>? params}) async {
    dynamic responseJson;

    try {
      final response = await dio.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          log(response.statusCode.toString());
          log("${response.data}");
        }
        responseJson = response.data;
      } else {
        throw Exception("Error occurred while communicating with API: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e);
    }

    return responseJson;
  }
}

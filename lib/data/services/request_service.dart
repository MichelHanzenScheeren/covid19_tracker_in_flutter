import 'package:covid19_tracker_in_flutter/data/errors/covid_error.dart';
import 'package:dio/dio.dart';

class RequestService {
  Future<dynamic> request(String request) async {
    try {
      final Response response = await Dio().get(request);
      return _validateResponse(response);
    } catch (error) {
      _onError(error);
      return null;
    }
  }

  dynamic _validateResponse(Response response) {
    if (response == null || response.statusCode != 200)
      throw CovidError(apiErrorType: CovidErrorType.INVALID_RESPONSE);
    return response.data;
  }

  void _onError(error) {
    if (error.runtimeType == DioError)
      throw CovidError(dioErrorType: error.type);
    throw CovidError();
  }
}
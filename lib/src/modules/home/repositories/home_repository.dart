import 'package:dio/dio.dart';
import 'package:fast_location_app/src/http/app_dio.dart';

class HomeRepository with AppDio {
  Future<Response> getAddress(String cep) async {
    Dio clientHTTP = await AppDio.getConnection();
    Response response = await clientHTTP.get('https://viacep.com.br/ws/$cep/json/');
    return response;
  }
}
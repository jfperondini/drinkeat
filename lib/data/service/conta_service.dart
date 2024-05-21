import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_expection.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/domain/model/conta_model.dart';

class ContaService {
  final ClientIHttp client;

  ContaService(this.client);

  Future<List<ContaModel>> getList() async {
    try {
      final response = await client.get('${ClientEndPoint.conta}?select=*');
      final result = response.data as List;
      return result.map((e) => ContaModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }

  Future<ContaModel> post({required ContaModel conta}) async {
    try {
      final response = await client.post(ClientEndPoint.conta, conta.toJsonService());
      final result = response.data as List; // Assuming response.data is a List<dynamic>
      final List<ContaModel> contaList = result.map((e) => ContaModel.fromJson(e)).toList();
      return contaList.first;
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }

  Future<int> delete({required int id}) async {
    try {
      final response = await client.delete(ClientEndPoint.pessoa, {'id': 'eq.$id'});
      return response.statusCode;
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }
}

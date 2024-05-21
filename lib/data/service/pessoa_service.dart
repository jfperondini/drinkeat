import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_expection.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/domain/model/pessoa_model.dart';

class PessoaService {
  final ClientIHttp client;

  PessoaService(this.client);

  Future<List<PessoaModel>> getList() async {
    try {
      final response = await client.get('${ClientEndPoint.pessoa}?select=*');
      final result = response.data as List;
      return result.map((e) => PessoaModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }

  Future<void> post({required PessoaModel pessoa}) async {
    try {
      await client.post(ClientEndPoint.pessoa, pessoa.toJsonService());
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }

  Future<void> patch({required PessoaModel pessoa, required Map<String, dynamic> body}) async {
    try {
      final response = await client.patch(ClientEndPoint.pessoa, body, {'idPessoa': 'eq.${pessoa.idPessoa}'});
      return response.statusCode;
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }

  Future<int> delete({required int id}) async {
    try {
      final response = await client.delete(ClientEndPoint.pessoa, {'idPessoa': 'eq.$id'});
      return response.statusCode;
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }
}

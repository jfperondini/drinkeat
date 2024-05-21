import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_expection.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita/gasto_model.dart';

class GastoService {
  final ClientIHttp client;

  GastoService(this.client);

  Future<void> post({required GastoModel gasto}) async {
    try {
      await client.post(ClientEndPoint.gasto, gasto.toJson());
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }
}

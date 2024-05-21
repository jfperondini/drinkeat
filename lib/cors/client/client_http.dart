import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/cors/client/client_interceptor.dart';

class ClientHttp implements ClientIHttp {
  final List<InterceptorsWrapper>? interceptor;

  late final Dio dio;
  ClientHttp({this.interceptor}) {
    dio = Dio(BaseOptions(baseUrl: ClientEndPoint.baseUrl));
    if (interceptor != null) {
      dio.interceptors.addAll(
        interceptor ?? [],
      );
    }
  }

  factory ClientHttp.start() {
    return ClientHttp(
      interceptor: [ClientInterceptors()],
    );
  }

  @override
  Future get(String path) async {
    final response = await dio.get(path);
    return response;
  }

  @override
  Future post(path, Map map) async {
    Map<String, String> headers = {
      ClientEndPoint.apiKey: ClientEndPoint.key,
      ClientEndPoint.authorization: ClientEndPoint.bearer,
      ClientEndPoint.contetType: ClientEndPoint.applicationJson,
      ClientEndPoint.prefer: ClientEndPoint.returnRepresentation,
    };
    final response = await dio.post(
      path,
      data: map,
      options: Options(headers: headers),
    );
    return response;
  }

  @override
  Future patch(String path, Map map, Map<String, dynamic>? queryParameters) async {
    Map<String, String> headers = {
      ClientEndPoint.apiKey: ClientEndPoint.key,
      ClientEndPoint.authorization: ClientEndPoint.bearer,
      ClientEndPoint.contetType: ClientEndPoint.applicationJson,
      ClientEndPoint.prefer: ClientEndPoint.returnMinimal,
    };
    final response = await dio.patch(
      path,
      data: map,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }

  @override
  Future delete(String path, Map<String, dynamic>? queryParameters) async {
    Map<String, String> headers = {
      ClientEndPoint.apiKey: ClientEndPoint.key,
      ClientEndPoint.authorization: ClientEndPoint.bearer,
    };
    final response = await dio.delete(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }
}

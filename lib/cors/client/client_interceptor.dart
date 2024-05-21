import 'package:dio/dio.dart';

class ClientInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    const String headerApiKey =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpZGtjdmtqZHd2ZWx6dHpjbWFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI0MTE1NjEsImV4cCI6MjAxNzk4NzU2MX0.HxmzKTqsB-HQ42Q-3VLEgDVKExaBwk4eE0-YcEmEF14";
    options.headers['apikey'] = headerApiKey;

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

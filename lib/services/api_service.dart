
import 'package:dio_http/dio_http.dart';

class ApiService{
  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyapi.io/data/v1/",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      validateStatus: (status){
        return status != null && status > 0;
      },
      headers: {
        "app-id" : "615ffee43a908688ce8b90de"
      },
    )
  );

  postRequest(String path, dynamic data)async{
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ));
    return await _dio.post(path, data: data);
  }
  
  getRequest(String path, dynamic data)async{
    _dio.interceptors..add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ))..add(LogInterceptor(
        responseHeader: true,
        responseBody: true,
        requestBody: true
      ));
    return await _dio.get(path, queryParameters: data);
  }
}
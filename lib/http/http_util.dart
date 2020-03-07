import 'package:dio/dio.dart';
import 'dart:async';

class HttpUtils {
  //全局的dio对象
  static Dio dio;

  //默认的选项配置
  static const String API_PREFIX = 'http://49.232.173.220:3001';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 6000;

  //http请求方式
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELTE = 'delete';

  //请求方式
  static Future request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    //请求处理
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    Dio dio = createInstance();
    var result;

    try {
      Response response = await dio.request(url,
          data: data, options: new Options(method: method));

      result = response.data;
    } on DioError catch (e) {
      print('请求出错:' + e.toString());
    }
    return result;
  }

  //创建dio实例对象
  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = new Dio(options);
    }
    return dio;
  }

  //清空dio对象
  static clear() {
    dio = null;
  }
}

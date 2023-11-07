import 'package:dio/dio.dart';

import 'config.dart';


//
class Http {
  //
  static final Http _instance = Http._internal();

  CancelToken _cancelToken = new CancelToken();
  // 单例模式使用Http类，
  factory Http() => _instance;
  static late final Dio dio;
  //
  Http._internal() {
    // 配置
    BaseOptions options = new BaseOptions();

    dio = new Dio(options);
    //todo： 拦截器暂时不需要
  }
  // 初始化
  void init({ String? baseUrl,
  }){
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
    );
  }

  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }

  Future get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = false,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Response response;
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );

    return response;
  }

  Future post(
      String path, {
        Map<String, dynamic>? params,
        data,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response;
  }

  Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response;
  }

  Future patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response;
  }

  Future delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response;
  }
}



class  HttpUtils {
  static void init({
     String baseUrl=Config.myIp+Config.goBackend,
  }) {
    Http().init(
      baseUrl: baseUrl,
    );
  }

  static void cancelRequests({required CancelToken token}) {
    Http().cancelRequests(token: token);
  }

  static Future get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = false,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    return await Http().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
  }

  static Future post(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

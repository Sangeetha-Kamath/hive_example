import 'package:dio/dio.dart';
import 'package:local_storage_wtih_hive/url_resources.dart';

class DioService{
   static final DioService _instance = DioService._internal();
   factory DioService()=>_instance;
   DioService._internal();
   late final Dio dio;
   void initialize(){
    dio= Dio(BaseOptions(baseUrl:UrlResources.baseUrl,
    connectTimeout: const Duration(milliseconds: 3000),
    receiveTimeout: const Duration(milliseconds: 30000),
    headers: {
      "content-type":"application/json",
      
    } ))..interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      requestUrl: true,
      
    ));
   }
}
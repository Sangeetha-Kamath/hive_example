import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_wtih_hive/post_list/view_model/post_data_source.dart';
import 'package:local_storage_wtih_hive/service/dio_service.dart';
import 'package:local_storage_wtih_hive/url_resources.dart';

import '../../model/network_exception_model.dart';
import '../model/post_model.dart';

class PostRepository{
  final PostDataSource local;
  PostRepository(this.local);
  Future<List<PostModel>> fetchPosts({required int page})async{
      try{
        late final Response response;
        response = await DioService().dio.get(UrlResources.getPosts,queryParameters: {
          "_start":page,
          "_limit":10
        });
        if(response.statusCode == 200){
         return response.data.map<PostModel>((e)=>PostModel.fromJson(e)).toList();
        }else{
        return [];
        }
        

      }on DioException catch(e){
        throw NetworkExceptionModel(statusCode:e.response?.statusCode,errorMessage:e.response?.statusMessage);
        
      }
      catch(e){
          debugPrint("something went wrong:$e");
        throw Exception("Something went wrong:$e");
       
      }
      
  }
}
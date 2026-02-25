import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/post_model.dart';

class PostDataSource {
  final box = Hive.box("postCache");
  final key = "cached_post_20";
  Future<void> cahcePost(List<PostModel> post)async{
   await box.put(key,jsonEncode(post.map((e)=>e.toJson()).toList()));
   debugPrint("json response:${box.values}");
    
  }
  Future<List<PostModel>> getCachedPost()async{
   final jsonList = box.get(key);
    if (jsonList == null) return [];
  
    final decodedList = jsonDecode(jsonList);
   debugPrint("decoded list:${decodedList}");
  final posts =  decodedList.map<PostModel>((e)=>PostModel.fromJson(e)).toList();
  debugPrint("data length:${posts.length}");
  return posts;

  }
}
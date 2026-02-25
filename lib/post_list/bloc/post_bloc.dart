import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_wtih_hive/post_list/bloc/post_state.dart';
import 'package:local_storage_wtih_hive/post_list/model/post_model.dart' show PostModel;
import 'package:local_storage_wtih_hive/post_list/view_model/post_repository.dart';

import 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  final PostRepository repository;
  PostBloc({required this.repository}):super(PostState.initial()){
    on<FecthPostEvent>(_fetchPost);
  }
  Future<void> _fetchPost(FecthPostEvent event, Emitter<PostState> emit)async{
      debugPrint("page value:${state.page}");
     
    if(state.isFetching ||state.isLoading ||state.isLastPage) {
      return;
    } 
    else{     
      final localPost= await repository.local.getCachedPost();
     
      debugPrint("local post length:$localPost");

      emit(state.copyWith(status: PostStatus.success,post:[...state.post??[],...localPost]));
      emit(state.copyWith(status:state.page==0? PostStatus.loading:PostStatus.fetching,isLoading: state.page==0?true:false,isFetching: state.page!=0?true:false));}
      try{
        final posts  =await repository.fetchPosts(page:state.page);
        debugPrint("posts response:$posts");
      final List<PostModel> updatedPost =state.page<(state.post?.length??0/10)?posts:[...state.post??[],...posts];
      debugPrint("post length:${state.post?.length??0}");
        if(updatedPost.length<20){
          debugPrint("cache post called");
          repository.local.cahcePost(updatedPost);
        }
        int page =state.page;
        bool isLastPage = state.isLastPage;
        if(state.page<state.totalPage){
         page++;
       
        }else{
          isLastPage=true;
        }
        emit(state.copyWith(status: PostStatus.success,post: updatedPost,page: page,isLastPage: isLastPage));
        //  debugPrint("page value:${state.page}");
      }catch(e){
        emit(state.copyWith(status: PostStatus.failed,errorMessage: "Something went wrong$e"));
      }finally
      {
        emit(state.copyWith(isFetching: false,isLoading: false));
      }

      
  }
  
}
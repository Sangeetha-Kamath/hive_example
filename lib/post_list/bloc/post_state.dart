import 'package:equatable/equatable.dart';

import '../model/post_model.dart';
enum PostStatus{
  initial,
  loading, 
  fetching,
  
  success,
  failed,
  error
}

class PostState extends Equatable{
  final List<PostModel>? post;
  final PostStatus? status;
  final int page;
  final bool isLoading;
  final bool isFetching;
  final int totalPage;
  final bool isLastPage;
  final String? errorMessage;

 const PostState({required this.status,required this.post,required this.errorMessage,
 required this.isFetching,required this.isLastPage,required this.isLoading,required this.totalPage,required this.page
 });

factory PostState.initial(){
return PostState(status:PostStatus.initial,post:null,errorMessage:null,page:0,isFetching: false,isLastPage: false,isLoading: false,totalPage: 5);
}

  @override
  // TODO: implement props
  List<Object?> get props => [
    post,status,errorMessage,isFetching,isLoading,isLastPage,totalPage
  ];
@override
String toString(){
  return "post status $post $status $errorMessage";
}
PostState copyWith({List<PostModel>? post,PostStatus? status, String? errorMessage,bool? isFetching,bool? isLoading,bool? isLastPage,int? page,int totalPage=5}){ 
  return PostState(post:post??this.post,status:status??this.status,errorMessage:errorMessage??this.errorMessage,isFetching: isFetching??this.isFetching,
  isLoading:isLoading??this.isLoading, isLastPage:isLastPage??this.isLastPage,page:page??this.page,totalPage: totalPage);
}

}
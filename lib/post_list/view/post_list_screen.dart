import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_wtih_hive/post_list/bloc/post_event.dart';

import '../bloc/post_bloc.dart';
import '../bloc/post_state.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
  
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<PostBloc>();
      if(bloc.state.status==PostStatus.initial){
      context.read<PostBloc>().add(FecthPostEvent());}
    });
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent
                
                    ) {
                context.read<PostBloc>().add(FecthPostEvent());
              }
              return true;
            },

            child: ListView.builder(
              itemCount: state.post?.length,
             
              itemBuilder: (context, index) {
               return  Column(
                 children: [
                   SizedBox(height: 60,),
                    Text(state.post?[index].title ?? "")
                 ],
               );
               
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/widgets/home_widgets/posts_list_view_item.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({super.key, required this.posts});

  final List<PostEntity> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => PostsListViewItem(
        index: index + 1,
        post: posts[index],
      ),
      separatorBuilder: (context, index) => const Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}

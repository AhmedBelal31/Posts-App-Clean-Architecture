import 'package:flutter/material.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/screens/post_add_update_screen.dart';

class PostsListViewItem extends StatelessWidget {
  const PostsListViewItem({super.key, required this.index, required this.post});

  final int index;
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostAddUpdateScreen(
            isUpdatePost: true,
            post: post,
          ),
        ));
      },
      child: ListTile(
        leading: Text(
          '$index',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        title: Text(
          post.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, height: 1.3),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            post.body,
            style: TextStyle(
                fontSize: 18,
                height: 1.3,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}

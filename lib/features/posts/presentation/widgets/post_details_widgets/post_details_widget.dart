import 'package:flutter/material.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/widgets/post_details_widgets/update_post_button.dart';
import 'delete_post_button.dart';

class PostDetailsWidget extends StatelessWidget {
  final PostEntity post;

  const PostDetailsWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(height: 20),
          ),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(height: 50),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostButton(post: post),
              DeletePostBtn(postId: post.id!),
            ],
          ),
        ],
      ),
    );
  }
}

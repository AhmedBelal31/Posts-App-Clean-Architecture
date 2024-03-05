import 'package:flutter/material.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';

import '../../screens/post_add_update_screen.dart';

class UpdatePostButton extends StatelessWidget {
  final PostEntity post;

  const UpdatePostButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostAddUpdateScreen(
              isUpdatePost: true,
              post: post,
            ),
          ),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit'),
    );
  }
}

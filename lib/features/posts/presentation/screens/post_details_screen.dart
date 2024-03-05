import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import '../widgets/post_details_widgets/post_details_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostEntity post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Post Details '),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PostDetailsWidget(
          post: post,
        ),
      ),
    );
  }
}

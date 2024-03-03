import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/posts_bloc/posts_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/widgets/posts_screen/posts_list_view.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_screen/message_display_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadingState) {
            return const LoadingWidget();
          } else if (state is PostsSuccessState) {
            List<PostEntity> posts = state.posts;
            posts.shuffle();
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: PostsListView(posts: posts),
              ),
            );
          } else if (state is PostsFailureState) {
            return MessageDisplayWidget(
              message: state.errorMessage,
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Posts',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/posts_bloc/posts_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/screens/post_add_update_screen.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/home_widgets/message_display_widget.dart';
import '../widgets/home_widgets/posts_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Posts',
      ),
    );
  }

  BlocBuilder<PostsBloc, PostsState> _buildBody() {
    return BlocBuilder<PostsBloc, PostsState>(
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
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostAddUpdateScreen(
              isUpdatePost: false,
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

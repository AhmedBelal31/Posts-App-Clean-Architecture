import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/posts_bloc/posts_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/screens/home_screen.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../widgets/post_add_update_widgets/form_widget.dart';

class PostAddUpdateScreen extends StatelessWidget {
  final PostEntity? post;

  final bool isUpdatePost;

  const PostAddUpdateScreen({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is AddDeleteUpdatePostSuccessState) {
              SnackBarMessage().showSuccessSnackBar(context: context, message: state.successMessage);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
              BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
            }
            else if (state is AddDeleteUpdatePostFailureState )
              {
                SnackBarMessage().showSuccessSnackBar(context: context, message: state.errorMessage);

              }
          },
          builder: (context, state) {
            if (state is AddDeleteUpdatePostLoadingState) {
              return const LoadingWidget();
            }
            return FormWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      ),
    );
  }
}

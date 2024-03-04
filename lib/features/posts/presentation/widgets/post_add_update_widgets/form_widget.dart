import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/widgets/post_add_update_widgets/form_button.dart';

import 'custom_text_form_field.dart';

class FormWidget extends StatefulWidget {
  final PostEntity? post;

  final bool isUpdatePost;

  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextFormField(
            controller: _titleController,
            hintText: 'Title',
          ),
          CustomTextFormField(
            controller: _bodyController,
            hintText: 'Body',
            minLines: 6,
            maxLines: 6,
          ),
          const SizedBox(height: 20),
          FormButton(
            onPressed: validateFormThenUpdateOrAddPost,
            text: widget.isUpdatePost ? 'Update' : 'Add',
            icon: widget.isUpdatePost ? Icons.edit : Icons.add,
          ),
        ],
      ),
    );
  }

  void Function()? validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    final post = PostEntity(
      id: widget.isUpdatePost ? widget.post!.id : null,
      title: _titleController.text,
      body: _bodyController.text,
    );
    if (isValid) {
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
          UpdatePostEvent(post: post),
        );
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
          AddPostEvent(post: post),
        );
      }
    }
    return null;
  }
}

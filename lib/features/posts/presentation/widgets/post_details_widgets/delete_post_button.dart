import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../controller/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import '../../screens/home_screen.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtn extends StatelessWidget {
  final int postId;

  const DeletePostBtn({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, foregroundColor: Colors.white),
      onPressed: () => deleteDialog(context),
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is AddDeleteUpdatePostSuccessState) {
                SnackBarMessage().showSuccessSnackBar(
                  context: context,
                  message: state.successMessage,
                );

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false);
              } else if (state is AddDeleteUpdatePostFailureState) {
                Navigator.of(context).pop();
                SnackBarMessage().showSuccessSnackBar(
                  context: context,
                  message: state.errorMessage,
                );
              }
            },
            builder: (context, state) {
              if (state is AddDeleteUpdatePostLoadingState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}

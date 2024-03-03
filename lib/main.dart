import 'package:flutter/material.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/posts_bloc/posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'core/services/service_locator/service_locator.dart';
import 'features/posts/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await setupServiceLocator();
  runApp(const PostsApp());
}

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<PostsBloc>(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Posts APP',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}

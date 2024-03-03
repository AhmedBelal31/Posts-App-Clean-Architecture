import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app_clean_architecture/core/network/network_info.dart';
import 'package:posts_app_clean_architecture/core/services/web_services/web_services.dart';
import 'package:posts_app_clean_architecture/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app_clean_architecture/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app_clean_architecture/features/posts/data/repos/posts_repo_impl.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/repos/posts_repo.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/usecases/delete_postusecase.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:posts_app_clean_architecture/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_app_clean_architecture/features/posts/presentation/controller/posts_bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async{
  /// Register Web Services
  sl.registerLazySingleton<WebServices>(() => WebServices());

  /// Register Remote Data Source
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl(webServices: sl()));

  ///Create SharedPreferences Instance
  final  sharedPreferences = await SharedPreferences.getInstance();
  /// Register Local Data Source
  sl.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
    ),
  );

  /// Register Internet Connection Checker
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  /// Register Network Information
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  /// Register Posts Repo
  sl.registerLazySingleton<PostsRepo>(
    () => PostsRepoImpl(
      postsRemoteDataSource: sl(),
      postsLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// Register Get All Posts UseCase
  sl.registerLazySingleton<GetAllPostsUseCase>(
    () => GetAllPostsUseCase(postsRepo: sl()),
  );

  ///Register Posts BloC
  sl.registerFactory<PostsBloc>(() => PostsBloc(getAllPostsUseCase: sl()));


  ///Register AddDeleteUpdate BloC

  sl.registerFactory<AddDeleteUpdatePostBloc>(
        () => AddDeleteUpdatePostBloc(
      addPostUseCase: sl(),
      updatePostUseCase: sl(),
      deletePostUseCase: sl(),
    ),
  );


  ///Register Add Post UseCase
  sl.registerLazySingleton<AddPostUseCase>(() => AddPostUseCase(postsRepo: sl()));

  ///Register Update Post UseCase
  sl.registerLazySingleton<UpdatePostUseCase>(() => UpdatePostUseCase(postsRepo: sl()));

  ///Register Delete Post UseCase
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(postsRepo: sl()));




}

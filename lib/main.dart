import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter/features/auth/data/data_sources/session_local_data_source.dart';
import 'package:twitter/features/auth/data/repository/supabase_auth_repository.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter/features/auth/domain/usecases/register_usecase.dart';
import 'package:twitter/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:twitter/features/auth/presentation/login/screens/login_page.dart';
import 'package:twitter/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:twitter/features/auth/presentation/register/screens/register_page.dart';
import 'package:twitter/features/feed/data/repository/supabase_post_repository.dart';
import 'package:twitter/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:twitter/features/feed/domain/usecases/fetch_post_usecase.dart';
import 'package:twitter/features/feed/domain/usecases/like_post_usecase.dart';
import 'package:twitter/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:twitter/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:twitter/features/feed/presentation/screens/feed_page.dart';
import 'package:twitter/features/splash/splash.dart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'URL',
    anonKey: 'ANONKEY'
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final SessionLocalDataSource sessionLocalDataSource = SessionLocalDataSourceImpl(secureStorage: secureStorage);
    final UserSessionService userSessionService = UserSessionService(sessionLocalDataSource: sessionLocalDataSource);
    
    return Provider<UserSessionService>.value(
      value: userSessionService,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RegisterBloc(
              registerUsecase: RegisterUsecase(
                authRepository: SupabaseAuthRepository(client: supabase),
              ),
              userSessionService: userSessionService
            ),
          ),
      
          BlocProvider(
            create: (_) => LoginBloc(
              loginUseCase: LoginUseCase(
                authRepository: SupabaseAuthRepository(client: supabase),
              ),
              userSessionService: userSessionService
            ),
          ),
      
          BlocProvider(
            create: (_) => FeedBloc(
              fetchPostsUseCase: FetchPostsUseCase(
                postRepository: SupabasePostRepository(client: supabase),
              ),
              likePostUseCase: LikePostsUseCase(
                postRepository: SupabasePostRepository(client: supabase),
              ),
              userSessionService: userSessionService
            ),
          ),
      
          BlocProvider(
            create: (_) => CreatePostBloc(
              createPostUseCase: CreatePostUseCase(
                postRepository: SupabasePostRepository(client: supabase)
              ),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Twitter Clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashPage(userSessionService: userSessionService),
          routes: {
            '/register' : (_) => const RegisterPage(),
            '/login' : (_) => const LoginPage(),
            '/home' : (_) => const FeedPage(),
            '/splash' : (_) => SplashPage(userSessionService: userSessionService),
          },
        ),
      ),
    );
  }
}


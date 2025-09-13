import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter/features/auth/data/data_sources/session_local_data_source.dart';
import 'package:twitter/features/auth/data/repository/mockAuthRepository.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter/features/auth/domain/usecases/register_usecase.dart';
import 'package:twitter/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:twitter/features/auth/presentation/login/screens/login_page.dart';
import 'package:twitter/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:twitter/features/auth/presentation/register/screens/register_page.dart';
import 'package:twitter/features/feed/data/mock_post_repository.dart';
import 'package:twitter/features/feed/domain/usecases/fetch_post_usecase.dart';
import 'package:twitter/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:twitter/features/feed/presentation/screens/feed_page.dart';
import 'package:twitter/features/splash/splash.dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final SessionLocalDataSource sessionLocalDataSource = SessionLocalDataSourceImpl(secureStorage: secureStorage);
    final UserSessionService userSessionService = UserSessionService(sessionLocalDataSource: sessionLocalDataSource);
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUsecase: RegisterUsecase(
              authRepository: MockAuthRepository(),
            ),
            userSessionService: userSessionService
          ),
        ),

        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(
              authRepository: MockAuthRepository(),
            ),
            userSessionService: userSessionService
          ),
        ),

        BlocProvider(
          create: (_) => FeedBloc(
            fetchPostsUseCase: FetchPostsUseCase(
              postRepository: MockPostRepository(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashPage(userSessionService: userSessionService),
        routes: {
          '/register' : (_) => const RegisterPage(),
          '/login' : (_) => const LoginPage(),
          '/home' : (_) => const FeedPage()
        },
      ),
    );
  }
}


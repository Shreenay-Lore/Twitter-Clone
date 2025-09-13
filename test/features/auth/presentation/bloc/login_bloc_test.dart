import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter/features/auth/presentation/login/bloc/login_bloc.dart';

import '../../data/repository/mock_auth_repository.dart';
import '../../domain/services/mock_user_session_service.dart';

void main(){

  group('LoginBloc test', (){
    late LoginBloc loginBloc;
    late LoginBloc loginBlocWithRepositoryError;
    MockUserSessionService mockUserSessionService = MockUserSessionService();

    setUp(() {
      loginBloc = LoginBloc(
        loginUseCase: LoginUseCase(
          authRepository: MockAuthRepository()
        ),
        userSessionService: mockUserSessionService
      );
      loginBlocWithRepositoryError = LoginBloc(
        loginUseCase: LoginUseCase(
          authRepository: MockAuthErrorRepository()
        ),
        userSessionService: mockUserSessionService
      );
    },);

    blocTest(
      'emit[LoginLoading, LoginSuccess] when login is successful',
      build:()=> loginBloc, 
      act: (bloc) => bloc.add(
        LoginSubmitted(
          email: 'shree@gmail.com',  
          password: "Pass1234"
        )
      ),
      expect: () => [
        LoginLoading(),
        LoginSuccess(),
      ],
    );

    blocTest(
      'emit[LoginLoading, LoginFailure] when email is wrong',
      build:()=> loginBloc, 
      act: (bloc) => bloc.add(
        LoginSubmitted(
          email: 'shreecom',  
          password: "Pass1234"
        )
      ),
      expect: () => [
        LoginLoading(),
        isA<LoginFailure>(),
      ],
    );


    blocTest(
      'emit[LoginLoading, LoginFailure] when repository return an error',
      build:()=> loginBlocWithRepositoryError, 
      act: (bloc) => bloc.add(
        LoginSubmitted(
          email: 'shree@gmail.com',  
          password: "Pass1234"
        )
      ),
      expect: () => [
        LoginLoading(),
        isA<LoginFailure>(),
      ],
    );



  });
}
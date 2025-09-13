import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/auth/domain/usecases/register_usecase.dart';
import 'package:twitter/features/auth/presentation/register/bloc/register_bloc.dart';

import '../../data/repository/mock_auth_repository.dart';
import '../../domain/services/mock_user_session_service.dart';

void main(){

  group('RegisterBloc test', (){
    late RegisterBloc registerBloc;
    late RegisterBloc registerBlocWithRepositoryError;
    MockUserSessionService mockUserSessionService = MockUserSessionService();

    setUp(() {
      registerBloc = RegisterBloc(
        registerUsecase: RegisterUsecase(
          authRepository: MockAuthRepository()
        ),
        userSessionService: mockUserSessionService
      );
      registerBlocWithRepositoryError = RegisterBloc(
        registerUsecase: RegisterUsecase(
          authRepository: MockAuthErrorRepository()
        ),
        userSessionService: mockUserSessionService
      );
    },);

    blocTest(
      'emit[RegisterLoading, RegisterSuccess] when register is success',
      build:()=> registerBloc, 
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: 'shree@gmail.com', 
          username: "shree", 
          password: "Pass1234"
        )
      ),
      expect: () => [
        RegisterLoading(),
        RegisterSuccess(),
      ],
    );

    blocTest(
      'emit[RegisterLoading, RegisterFailure] when email is wrong',
      build:()=> registerBloc, 
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: 'shreecom', 
          username: "shree", 
          password: "Pass1234"
        )
      ),
      expect: () => [
        RegisterLoading(),
        isA<RegisterFailure>(),
      ],
    );


    blocTest(
      'emit[RegisterLoading, RegisterFailure] when repository return an error',
      build:()=> registerBlocWithRepositoryError, 
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: 'shree@gmail.com', 
          username: "shree", 
          password: "Pass1234"
        )
      ),
      expect: () => [
        RegisterLoading(),
        isA<RegisterFailure>(),
      ],
    );



  });
}
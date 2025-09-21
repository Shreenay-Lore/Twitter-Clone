import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter/features/auth/domain/usecases/login_usecase.dart';

import '../../data/repository/mock_auth_repository.dart';

void main(){
  group('LoginUseCase test', (){
    late LoginUseCase loginUsecase;

    setUp((){
      loginUsecase = LoginUseCase(
        authRepository: MockAuthRepository()
      );
    });

    test('Should login user successfully and return token', () async {
      const String email = 'shree@test.com';
      const String password = 'password123';

      final result = await loginUsecase.call(
        email: email,
        password: password
      );
      expect(result, isA<UserSessionEntity>());
      expect(result.email, email);
      expect(result.token, "token");
    });


    test('Should return an error if email is Empty', () async {
      const String email = '';
      const String password = 'password123';

      expect(() async => await loginUsecase.call(
        email: email,
        password: password
      ), throwsA(isA<Exception>()));
    });

    test('Should return an error if email have wrong format', () async {
      const String email = 'shree';
      const String password = 'password123';

      expect(() async => await loginUsecase.call(
        email: email,
        password: password
      ), throwsA(isA<Exception>()));
    });

    test('Should return an error if password does not have atleast 4 characters', () async {
      const String email = 'shree@test.com';
      const String password = '123';

      expect(() async => await loginUsecase.call(
        email: email,
        password: password
      ), throwsA(isA<Exception>()));
    });

  });
}
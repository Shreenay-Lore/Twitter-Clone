import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/auth/domain/usecases/register_usecase.dart';

import '../../data/repository/mock_auth_repository.dart';

void main(){
  group('RegistrationUseCase test', (){
    late RegisterUsecase registerUsecase;
    late RegisterUsecase registerWithErrorUsecase;

    setUp((){
      registerUsecase = RegisterUsecase(
        authRepository: MockAuthRepository()
      );
      registerWithErrorUsecase = RegisterUsecase(
        authRepository: MockAuthErrorRepository()
      );
    });

    test('Should register user successfully and return token', () async {
      const String email = 'shree@test.com';
      const String username = 'shree';
      const String password = 'password123';

      final result = await registerUsecase.call(
        email: email,
        username: username,
        password: password
      );

      expect(result, 'token');
    });


    test('Should return an error if email is Empty', () async {
      const String email = '';
      const String username = 'shree';
      const String password = 'password123';

      expect(() async => await registerUsecase.call(
        email: email,
        username: username,
        password: password
      ), throwsA(isA<Exception>()));

    });

    test('Should return an error if email have wrong format', () async {
      const String email = 'shree';
      const String username = 'shree';
      const String password = 'password123';

      expect(() async => await registerUsecase.call(
        email: email,
        username: username,
        password: password
      ), throwsA(isA<Exception>()));

    });

    test('Should return an error if password does not have atleast 4 characters', () async {
      const String email = 'shree@test.com';
      const String username = 'shree';
      const String password = '123';

      expect(() async => await registerUsecase.call(
        email: email,
        username: username,
        password: password
      ), throwsA(isA<Exception>()));

    });


    test('Should return an error if username is Empty', () async {
      const String email = 'shree@test.com';
      const String username = '';
      const String password = 'password123';

      expect(() async => await registerUsecase.call(
        email: email,
        username: username,
        password: password
      ), throwsA(isA<Exception>()));

    });

    test('Should return an error if got any Api error', () async {
      const String email = 'shree@test.com';
      const String username = 'Shree';
      const String password = 'password123';

      expect(() async => await registerWithErrorUsecase.call(
        email: email,
        username: username,
        password: password
      ), throwsA(isA<Exception>()));
    });


  });
}
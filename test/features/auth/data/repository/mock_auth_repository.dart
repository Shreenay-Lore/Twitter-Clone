import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter/features/auth/domain/models/login_params.dart';
import 'package:twitter/features/auth/domain/entities/user_entity.dart';
import 'package:twitter/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository implements AuthRepository{
  @override
  Future<UserSessionEntity> register({required UserEntity user}) async {
    return UserSessionEntity(
      id: '1234',
      email: user.email,
      token: 'token'
    );
  }

  @override
  Future<UserSessionEntity> login({required LoginParams loginParams}) async {
    return UserSessionEntity(
      id: '1234',
      email: loginParams.email,
      token: 'token'
    );
  }
}

class MockAuthErrorRepository implements AuthRepository{
  @override
  Future<UserSessionEntity> register({required UserEntity user}) async {
    throw Exception('Registration Failed');
  }
  
  @override
  Future<UserSessionEntity> login({required LoginParams loginParams}) async {
    throw Exception('Login Failed');
  }
}
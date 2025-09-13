import 'package:twitter/features/auth/domain/models/login_params.dart';
import 'package:twitter/features/auth/domain/entities/user_entity.dart';
import 'package:twitter/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository implements AuthRepository{
  @override
  Future<String> register({required UserEntity user}) async {
    return 'token';
  }
  
  @override
  Future<String> login({required LoginParams loginParams}) async {
    return 'token';
  }

}

class MockAuthErrorRepository implements AuthRepository{
  @override
  Future<String> register({required UserEntity user}) async {
    throw Exception('Registration Failed');
  }
  
  @override
  Future<String> login({required LoginParams loginParams}) async {
    throw Exception('Login Failed');
  }
}
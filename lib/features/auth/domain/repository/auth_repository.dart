import 'package:twitter/features/auth/domain/models/login_params.dart';
import 'package:twitter/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<String> register({required UserEntity user});
  Future<String> login({required LoginParams loginParams});
}
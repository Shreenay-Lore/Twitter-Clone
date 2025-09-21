import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter/features/auth/domain/models/login_params.dart';
import 'package:twitter/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserSessionEntity> register({required UserEntity user});
  Future<UserSessionEntity> login({required LoginParams loginParams});
}
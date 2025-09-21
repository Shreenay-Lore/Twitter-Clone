import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter/features/auth/domain/models/login_params.dart';
import 'package:twitter/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<UserSessionEntity> call({required String email, required String password}) async {
    final loginParams = LoginParams(
      email: email, 
      password: password
    );

    final user = await authRepository.login(loginParams: loginParams);

    return user;
  }
}
import 'package:twitter/features/auth/domain/entities/user_entity.dart';
import 'package:twitter/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<String> call({required String email, required String username, required String password}) async {
    final user = UserEntity(
      email: email, 
      username: username, 
      password: password
    );

    final token = await authRepository.register(user: user);

    return token;
  }
}
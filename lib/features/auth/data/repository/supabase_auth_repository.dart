import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter/features/auth/domain/models/login_params.dart';
import 'package:twitter/features/auth/domain/entities/user_entity.dart';
import 'package:twitter/features/auth/domain/repository/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository{
  final SupabaseClient client;

  SupabaseAuthRepository({required this.client});

  @override
  Future<UserSessionEntity> login({required LoginParams loginParams}) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: loginParams.email,
        password: loginParams.password,
      );

      if (response.session != null && response.session!.accessToken.isNotEmpty) {
        final userSession = UserSessionEntity(
          email: response.session!.user.email!,
          id: response.session!.user.id,
          token: response.session!.accessToken,
        );
        return userSession; 
      } else {
        throw Exception('Login failed: No session returned.');
      }
    } on AuthException catch (e) {
      throw Exception('Auth error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<UserSessionEntity> register({required UserEntity user}) async {
    try {
      final response = await client.auth.signUp(
        email: user.email,
        password: user.password,
        data: {
          'username' : user.username
        }
      );

      if (response.session != null && response.session!.accessToken.isNotEmpty) {
        final userSession = UserSessionEntity(
          email: response.session!.user.email!,
          id: response.session!.user.id,
          token: response.session!.accessToken,
        );
        return userSession; 
      } else {
        throw Exception('Registration failed: No session returned.');
      }
    } on AuthException catch (e) {
      throw Exception('Auth error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  
}

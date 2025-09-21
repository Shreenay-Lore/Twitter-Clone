import 'package:twitter/features/auth/data/data_sources/session_local_data_source.dart';
import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';

class MockUserSessionService implements UserSessionService {

  @override
  Future<bool> isLoggedIn() async {
    return true;
  }

  @override
  Future<void> logout() async {}

  @override
  SessionLocalDataSource get sessionLocalDataSource => throw UnimplementedError();
  
  @override
  Future<UserSessionEntity?> getUserSession() async {
    return UserSessionEntity(
      email: 'test@gmail.com',
      id: '1234',
      token: 'token'
    );
  }
  
  @override
  Future<void> saveUserSession({required UserSessionEntity userSession}) async {}
  
}
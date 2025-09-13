import 'package:twitter/features/auth/data/data_sources/session_local_data_source.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';

class MockUserSessionService implements UserSessionService {
  @override
  Future<String?> getUserSession() async {
    return 'mock_token';
  }

  @override
  Future<bool> isLoggedIn() async {
    return true;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> saveUserSession({required String token}) async {}

  @override
  // TODO: implement sessionLocalDataSource
  SessionLocalDataSource get sessionLocalDataSource => throw UnimplementedError();
  
}
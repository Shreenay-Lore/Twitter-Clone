import 'package:twitter/features/auth/data/data_sources/session_local_data_source.dart';
import 'package:twitter/features/auth/domain/entities/user_session_entity.dart';

class UserSessionService {
  final SessionLocalDataSource sessionLocalDataSource;

  UserSessionService({required this.sessionLocalDataSource});

  Future<void> saveUserSession({required UserSessionEntity userSession}) async {
    await sessionLocalDataSource.saveSession(session: userSession);
  }

  Future<UserSessionEntity?> getUserSession() {
    return sessionLocalDataSource.getSession();
  }

  Future<void> logout(){
    return sessionLocalDataSource.clearSession();
  }

  Future<bool> isLoggedIn() async {
    final session = await sessionLocalDataSource.getSession();
    return session != null && session.token.isNotEmpty;
  }
}
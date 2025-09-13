import 'package:twitter/features/auth/data/data_sources/session_local_data_source.dart';

class UserSessionService {
  final SessionLocalDataSource sessionLocalDataSource;

  UserSessionService({required this.sessionLocalDataSource});

  Future<void> saveUserSession({required String token}) async {
    await sessionLocalDataSource.saveToken(token: token);
  }

  Future<String?> getUserSession() {
    return sessionLocalDataSource.getToken();
  }

  Future<void> logout(){
    return sessionLocalDataSource.deleteToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await sessionLocalDataSource.getToken();
    return token != null && token.isNotEmpty;
  }
}
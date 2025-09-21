import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  UserSessionService userSessionService;

  LoginBloc({required this.loginUseCase, required this.userSessionService}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try{
      final userSession = await loginUseCase.call( email: event.email, password: event.password);
      await userSessionService.saveUserSession(userSession: userSession);
      emit(LoginSuccess());

    }
    catch(e){
      emit(LoginFailure(message: formatError(e)));
    }

  }
}

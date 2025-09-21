import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/auth/domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUsecase registerUsecase;
  UserSessionService userSessionService;

  RegisterBloc({required this.registerUsecase, required this.userSessionService}) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter emit) async {
    emit(RegisterLoading());
    try{
      final session = await registerUsecase.call(
        email: event.email, 
        username: event.username, 
        password: event.password
      );
      await userSessionService.saveUserSession(userSession: session);
      emit(RegisterSuccess());
    }
    catch(e){
      emit(RegisterFailure(message: formatError(e)));
    }
    
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:twitter/features/feed/presentation/bloc/post/create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostUseCase createPostUseCase;

  CreatePostBloc({required this.createPostUseCase}) : super(CreatePostInitial()) {
    on<CreatePostsRequested>(_onCreatePostsRequested);
  }

  Future<void> _onCreatePostsRequested(CreatePostsRequested event, Emitter<CreatePostState> emit) async {
    emit(CreatePostLoading());
    try{
      await createPostUseCase.call(
        userId: event.userId,
        username: event.username,
        content: event.content,
        imageUrl: event.imageUrl ?? '',
      );
      emit(CreatePostSuccess());
    }
    catch(e){
      print(formatError(e));
      emit(CreatePostFailure(message: formatError(e)));
    }

  }
}


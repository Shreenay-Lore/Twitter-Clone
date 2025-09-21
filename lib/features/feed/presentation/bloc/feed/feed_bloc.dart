import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/usecases/fetch_post_usecase.dart';
import 'package:twitter/features/feed/domain/usecases/like_post_usecase.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FetchPostsUseCase fetchPostsUseCase;
  LikePostsUseCase likePostUseCase;
  UserSessionService userSessionService;

  FeedBloc({
      required this.fetchPostsUseCase, 
      required this.likePostUseCase,
      required this.userSessionService
    }) : super(FeedInitial()) {
    on<FetchPostsRequested>(_onFetchPostsRequested);
    on<LikePostRequested>(_onLikePostRequested);

  }

  Future<void> _onFetchPostsRequested(FetchPostsRequested event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try{
      final session = await userSessionService.getUserSession();
      final posts = await fetchPostsUseCase.call(currentUserId: session?.id);
      emit(FeedLoaded(posts: posts));
    }
    catch(e){
      emit(FeedFailure(message: formatError(e)));
    }

  }

  Future<void> _onLikePostRequested(LikePostRequested event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try{
      await likePostUseCase.call(
        postId: event.postId,
        userId: event.userId,
      );
      add(FetchPostsRequested());
    }
    catch(e){
      emit(FeedFailure(message: formatError(e)));
    }

  }
}


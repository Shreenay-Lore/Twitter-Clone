import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/usecases/fetch_post_usecase.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FetchPostsUseCase fetchPostsUseCase;

  FeedBloc({required this.fetchPostsUseCase}) : super(FeedInitial()) {
    on<FetchPostsRequested>(_onFetchPostsRequested);
  }

  Future<void> _onFetchPostsRequested(FetchPostsRequested event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try{
      await Future.delayed(Duration(seconds: 5));
      final posts = await fetchPostsUseCase.call();
      emit(FeedLoaded(posts: posts));
    }
    catch(e){
      emit(FeedFailure(message: formatError(e)));
    }

  }
}


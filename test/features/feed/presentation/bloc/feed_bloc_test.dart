import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/feed/domain/usecases/fetch_post_usecase.dart';
import 'package:twitter/features/feed/domain/usecases/like_post_usecase.dart';
import 'package:twitter/features/feed/presentation/bloc/feed/feed_bloc.dart';

import '../../../auth/domain/services/mock_user_session_service.dart';
import '../../data/repository/mock_post_repository.dart';

void main(){

  group('FeedBloc test', (){
    late FeedBloc feedBloc;
    late FeedBloc feedBlocWithError;
    MockUserSessionService mockUserSessionService = MockUserSessionService();

    setUp(() {
      feedBloc = FeedBloc(
        fetchPostsUseCase: FetchPostsUseCase(
          postRepository: MockPostRepository()
        ),
        likePostUseCase: LikePostsUseCase(
          postRepository: MockPostRepository()
        ),
        userSessionService: mockUserSessionService
      );
      
      feedBlocWithError = FeedBloc(
        fetchPostsUseCase: FetchPostsUseCase(
          postRepository: MockPostWithErrorRepository()
        ),
        likePostUseCase: LikePostsUseCase(
          postRepository: MockPostWithErrorRepository()
        ),
        userSessionService: mockUserSessionService
      );
      
    },);

    blocTest(
      'emit[FeedLoading, FeedLoaded] when posts are fetched successfully',
      build:()=> feedBloc, 
      act: (bloc) => bloc.add(
        FetchPostsRequested()
      ),
      expect: () => [
        FeedLoading(),
        isA<FeedLoaded>() 
      ],
    );

    blocTest(
      'emit[FeedLoading, FeedFailure] when loaded posts are failed',
      build:()=> feedBlocWithError, 
      act: (bloc) => bloc.add(
        FetchPostsRequested()
      ),
      expect: () => [
        FeedLoading(),
        isA<FeedFailure>() 
      ],
    );

  });
}
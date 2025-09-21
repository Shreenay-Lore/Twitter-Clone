import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:twitter/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:twitter/features/feed/presentation/bloc/post/create_post_event.dart';

import '../../data/repository/mock_post_repository.dart';

void main(){

  group('CreatePostBloc test', (){
    late CreatePostBloc createPostBloc;
    late CreatePostBloc createPostBlocWithError;


    setUp(() {
      createPostBloc = CreatePostBloc(
        createPostUseCase: CreatePostUseCase(
          postRepository: MockPostRepository()
        ),
      );
      
      createPostBlocWithError = CreatePostBloc(
        createPostUseCase: CreatePostUseCase(
          postRepository: MockPostWithErrorRepository()
        ),
      );
      
    },);

    blocTest(
      'emit[CreatePostLoading, CreatePostSuccess] when posts are created successfully',
      build:()=> createPostBloc, 
      act: (bloc) => bloc.add(
        CreatePostsRequested(
          userId: "12",
          username: "Shreenay",
          content: "Twitter Clone",
          imageUrl: ""
        )
      ),
      expect: () => [
        CreatePostLoading(),
        isA<CreatePostSuccess>() 
      ],
    );

    blocTest(
      'emit[CreatePostLoading, CreatePostFailure] when create posts are failed',
      build:()=> createPostBlocWithError, 
      act: (bloc) => bloc.add(
        CreatePostsRequested(
          userId: "12",
          username: "Shreenay",
          content: "Twitter Clone",
          imageUrl: ""
        )
      ),
      expect: () => [
        CreatePostLoading(),
        isA<CreatePostFailure>() 
      ],
    );

  });
}
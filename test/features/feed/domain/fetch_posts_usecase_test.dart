import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/usecases/fetch_post_usecase.dart';

import '../data/repository/mock_post_repository.dart';

void main(){
  group('FetchPostsUseCase test', (){
    late FetchPostsUseCase fetchPostUsecase;
    late FetchPostsUseCase fetchPostErrorUsecase;

    setUp((){
      fetchPostUsecase = FetchPostsUseCase(
        postRepository: MockPostRepository()
      );
      fetchPostErrorUsecase = FetchPostsUseCase(
        postRepository: MockPostWithErrorRepository()
      );
    });

    test('Should return the list of posts', () async {
      final result = await fetchPostUsecase.call();
      
      expect(result, isA<List<PostEntity>>());
      expect(result.length, greaterThan(0));
    });


    test('Should return an error if got any API error', () async {   
      expect(() async => await fetchPostErrorUsecase.call(), throwsA(isA<Exception>()));
    });

  });
}
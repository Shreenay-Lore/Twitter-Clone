import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/feed/domain/usecases/create_post_usecase.dart';

import '../data/repository/mock_post_repository.dart';

void main(){
  group('CreatePostsUseCase test', (){
    late MockPostRepository mockPostRepository;
    late MockPostWithErrorRepository mockPostWithErrorRepository;

    setUp((){
      mockPostRepository = MockPostRepository();
      mockPostWithErrorRepository = MockPostWithErrorRepository();
    });

    test('Should create a post successfully', () async {
      String userId = "1234";
      String username = "Shree";
      String content = "Twitter Clone";
      String imageUrl = '';

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostRepository
      );
      
      final result = await createPostUseCase.call(
        userId: userId,
        username: username,
        content: content,
        imageUrl: imageUrl,
      );
      
      expect(result, isTrue);
    });

     test('Should return an error if username and content are empty.', () async {
      String userId = "1234";
      String username = "";
      String content = "";
      String imageUrl = '';

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostRepository
      );
      
      expect(() async => await createPostUseCase.call(
        userId: userId,
        username: username,
        content: content,
        imageUrl: imageUrl,
      ), throwsA(isA<Exception>()));
    });

    test('Should return an Exception if there is an error with the repo', () async {
      String userId = "1234";
      String username = "Shree";
      String content = "Twitter Clone";
      String imageUrl = '';

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostWithErrorRepository
      );
      
      expect(() async => await createPostUseCase.call(
        userId: userId,
        username: username,
        content: content,
        imageUrl: imageUrl,
      ), throwsA(isA<Exception>()));
    });

  });
}
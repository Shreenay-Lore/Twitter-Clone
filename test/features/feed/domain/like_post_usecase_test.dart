import 'package:flutter_test/flutter_test.dart';
import 'package:twitter/features/feed/domain/usecases/like_post_usecase.dart';

import '../data/repository/mock_post_repository.dart';

void main(){
  group('LikePostUseCase test', (){
    late MockPostRepository mockPostRepository;

    setUp((){
      mockPostRepository = MockPostRepository();
    });

    test('Should like a post successfully', () async {

      LikePostsUseCase likePostsUseCase = LikePostsUseCase(
        postRepository: mockPostRepository
      );
      
      final result = await likePostsUseCase.call(
        userId: "1234",
        postId: "post_1234"
      );
      
      expect(result, isTrue);
    });

  });
}
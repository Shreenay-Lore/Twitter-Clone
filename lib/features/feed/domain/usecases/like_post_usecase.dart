import 'package:twitter/features/feed/domain/repository/post_repository.dart';

class LikePostsUseCase {
  final PostRepository postRepository;

  LikePostsUseCase({required this.postRepository});

  Future<bool> call({required String userId, required String postId}) async {
    final result = await postRepository.likePost(
      userId: userId,
      postId: postId
    );
    return result;
  }
}
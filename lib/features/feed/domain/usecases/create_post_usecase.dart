import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/repository/post_repository.dart';

class CreatePostUseCase {
  final PostRepository postRepository;

  CreatePostUseCase({required this.postRepository});

  Future<bool> call({required String userId, required String username, required String content, required String imageUrl}) async {
    final post = PostEntity(
      userId: userId, 
      username: username, 
      content: content, 
      createdAt: DateTime.now(),
      likesCount: 0,
      commentsCount: 0,
      repostsCount: 0,
      imageUrl: imageUrl
    );
    final result = await postRepository.createPost(post: post);
    return result;
  }
}
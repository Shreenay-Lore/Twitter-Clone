import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/repository/post_repository.dart';

class FetchPostsUseCase {
  final PostRepository postRepository;

  FetchPostsUseCase({required this.postRepository});

  Future<List<PostEntity>> call({String? currentUserId}) async {
    final result = await postRepository.fetchPosts(currentUserId: currentUserId);
    return result;
  }
}
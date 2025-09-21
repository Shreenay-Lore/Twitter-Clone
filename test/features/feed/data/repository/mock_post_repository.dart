
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/repository/post_repository.dart';

class MockPostRepository implements PostRepository{
  @override
  Future<List<PostEntity>> fetchPosts({String? currentUserId}) async {
    return [
      PostEntity(userId: '12', username: 'Shreenay', content: 'Science Tech', createdAt: DateTime.now())
    ];
  }
  
  @override
  Future<bool> createPost({required PostEntity post}) async {
    return true;
  }
  
  @override
  Future<bool> likePost({required String userId, required String postId}) async {
    return true;
  }
}


class MockPostWithErrorRepository implements PostRepository{
  @override
  Future<List<PostEntity>> fetchPosts({String? currentUserId}) async {
    throw Exception('Something went Wrong');
  }
  
  @override
  Future<bool> createPost({required PostEntity post}) async {
    throw Exception('Something went Wrong');
  }
  
  @override
  Future<bool> likePost({required String userId, required String postId}) async {
    throw Exception('Something went Wrong');
  }
}

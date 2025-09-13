
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/repository/post_repository.dart';

class MockPostRepository implements PostRepository{
  @override
  Future<List<PostEntity>> fetchPosts() async {
    return [
      PostEntity(userId: '12', username: 'Shreenay', content: 'Science Tech', createdAt: DateTime.now())
    ];
  }
}


class MockPostWithErrorRepository implements PostRepository{
  @override
  Future<List<PostEntity>> fetchPosts() async {
    throw Exception('Something went Wrong');
  }
}

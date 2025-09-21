abstract class CreatePostEvent {}

class CreatePostsRequested extends CreatePostEvent {
  final String userId;
  final String username;
  final String content; 
  final String? imageUrl;

  CreatePostsRequested({
    required this.userId, 
    required this.username, 
    required this.content, 
    this.imageUrl
  });
}

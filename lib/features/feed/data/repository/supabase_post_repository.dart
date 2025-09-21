
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/domain/repository/post_repository.dart';

class SupabasePostRepository implements PostRepository{
  final SupabaseClient client;
  SupabasePostRepository({required this.client});

  String postsTableName = 'posts';
  String likesTableName = 'likes';


  @override
  Future<bool> createPost({required PostEntity post}) async {
    try {
      final data = post.toJson();
      await client.from(postsTableName).insert(data);
      return true;
    } on PostgrestException catch (e) {
      throw Exception("Database error: ${e.message}");
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }


  @override
  Future<List<PostEntity>> fetchPosts({String? currentUserId}) async {
    try {
      final postsResponse = await client
          .from(postsTableName)
          .select()
          .order('created_at', ascending: false);


      final likesResponse = await client
          .from(likesTableName)
          .select('post_id')
          .eq('user_id', currentUserId ?? '');

      final likesPostIds = (likesResponse as List)
          .map((like)=> like['post_id'] as String)
          .toSet();

      return (postsResponse as List).map((json) {
        final post = PostEntity.fromJson(json);
        final isLiked = likesPostIds.contains(post.id);
        return post.copyWith(isLikeByCurrentUser: isLiked);
      }).toList();

    } on PostgrestException catch (e) {
      throw Exception("Database error: ${e.message}");
    } catch (e) {
      throw Exception("Failed to fetch posts: $e");
    }
  }
  
  @override
  Future<bool> likePost({required String userId, required String postId}) async {
    try {
      final response = await client
          .from(postsTableName)
          .select('likes_count')
          .eq('id', postId)
          .single();

      final currentLikes = response['likes_count'] ?? 0;

      final existingLike = await client
          .from(likesTableName)
          .select()
          .eq('user_id', userId)
          .eq('post_id', postId)
          .maybeSingle();

      if(existingLike != null){
        await client
          .from(likesTableName)
          .delete()
          .eq('user_id', userId)
          .eq('post_id', postId);

        await client
          .from(postsTableName)
          .update({'likes_count': currentLikes - 1})
          .eq('id', postId);
      } else {
        await client
          .from(likesTableName)
          .insert({
            'user_id': userId,
            'post_id': postId,
          });

        await client
          .from(postsTableName)
          .update({'likes_count': currentLikes + 1})
          .eq('id', postId);
      }

      return true;

    } on PostgrestException catch (e) {
      throw Exception("Database error: ${e.message}");
    } catch (e) {
      throw Exception("Failed to like post: $e");
    }
  }
  
}


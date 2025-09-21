import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/feed/domain/entities/post_entity.dart';
import 'package:twitter/features/feed/presentation/bloc/feed/feed_bloc.dart';

class PostCards extends StatelessWidget {
  final PostEntity post;
  const PostCards({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.username,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          formatDate(post.createdAt),
                          style: const TextStyle(color: Colors.white, fontSize: 12,),
                        ),
                      ],
                    ), 
                    const SizedBox(height: 10),
                    Text(
                      post.content,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          
          const SizedBox(height: 10),
      
          if(post.imageUrl != null && post.imageUrl!.isNotEmpty)...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(post.imageUrl!),
            ),
          ],
      
          const SizedBox(height: 10),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PostStat(
                icon: post.isLikeByCurrentUser == true ? Icons.favorite : Icons.favorite_border,
                iconColor: post.isLikeByCurrentUser == true ? Colors.red : Colors.grey,
                count: post.likesCount,
                onTap: (){
                  final userSessionService = context.read<UserSessionService>();
                  userSessionService.getUserSession().then((session){
                    if(session != null){
                      context.read<FeedBloc>().add(
                        LikePostRequested(
                          postId: post.id!, 
                          userId: post.userId
                        )
                      );
                    }
                  });
                }),
              _PostStat(icon: Icons.comment, count: post.commentsCount, onTap: (){}),
              _PostStat(icon: Icons.loop, count: post.repostsCount, onTap: (){}),
              const Icon(Icons.share, size: 18, color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }
}


class _PostStat extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final int? count;
  final VoidCallback onTap;
  const _PostStat({super.key, required this.icon, this.count, required this.onTap, this.iconColor});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon, size: 18, color: iconColor ?? Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(
            '${count ?? 0}',
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
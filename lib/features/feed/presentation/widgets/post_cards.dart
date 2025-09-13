import 'package:flutter/material.dart';
import 'package:twitter/core/utils.dart';
import 'package:twitter/features/feed/domain/entities/post_entity.dart';

class PostCards extends StatelessWidget {
  final PostEntity post;
  const PostCards({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                post.username,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              Text(
                formatDate(post.createdAt),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.content,
            style: const TextStyle(fontSize: 16),
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
              _PostStat(icon: Icons.favorite_border, count: post.likesCount,),
              _PostStat(icon: Icons.favorite_border, count: post.commentsCount,),
              _PostStat(icon: Icons.favorite_border, count: post.repostsCount,)
            ],
          )
        ],
      ),

    );
  }
}


class _PostStat extends StatelessWidget {
  final IconData icon;
  final int? count;
  const _PostStat({super.key, required this.icon, this.count});

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Icon(
          icon, size: 18, color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          '${count ?? 0}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
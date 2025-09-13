import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:twitter/features/feed/presentation/widgets/post_cards.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  @override
  void initState() {
    context.read<FeedBloc>().add(FetchPostsRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if(state is FeedLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is FeedLoaded){
              final posts = state.posts;
              if(posts.isEmpty){
                return const Center(child: Text('No posts found'));
              }

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => PostCards(post: posts[index])
              );
            }
            else if(state is FeedFailure){
              return Center(child: Text('Error: ${state.message}'));
            }

            return const SizedBox.shrink();

          },
        ),
      ),
    );
  
  }
}
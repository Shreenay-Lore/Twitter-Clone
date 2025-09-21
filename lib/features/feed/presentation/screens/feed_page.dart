import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/features/auth/domain/services/user_session_service.dart';
import 'package:twitter/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:twitter/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:twitter/features/feed/presentation/bloc/post/create_post_event.dart';
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

  void _showCreatePostModal(BuildContext context){
    final TextEditingController contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      builder: (context) {
        return BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if(state is CreatePostSuccess){
              Navigator.pop(context);
              context.read<FeedBloc>().add(FetchPostsRequested());
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post Created!')));
            }
            if(state is CreatePostFailure){
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }

          },
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                          ),

                          const SizedBox(width: 20,),

                          Expanded(
                            child: TextFormField(
                              controller: contentController,
                              maxLines: null,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "What's happening?",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none
                              ),
                              validator: (value) => value == null || value.trim().isEmpty
                                ? 'Content is required' : null,
                            ),
                          ),

                          const SizedBox(width: 16,),

                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: state is CreatePostLoading ? null : () async {
                                if(formKey.currentState!.validate()) {
                                  final userSession = await context.read<UserSessionService>().getUserSession();

                                  if(userSession != null){
                                    context.read<CreatePostBloc>().add(
                                      CreatePostsRequested(
                                        userId: userSession.id, 
                                        username: userSession.email.split('@').first, 
                                        content: contentController.text.trim(),
                                        imageUrl: ''
                                      )
                                    );

                                  }
                                }
                              }, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                              ),
                              child: state is CreatePostLoading ?
                                const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2,),
                                ) :
                                const Text('Post', style: TextStyle(color: Colors.white),)
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }, 
          
        );
      
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.5,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(backgroundColor: Colors.grey[800],),
        ),
        title: Image.asset('assets/images/icon.jpg', height: 32, width: 32),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.mail_outline, color: Colors.white,)
          ),

          IconButton(
            onPressed: () async {
              await context.read<UserSessionService>().logout();
              Navigator.pushReplacementNamed(context, '/splash');
            }, 
            icon: const Icon(Icons.logout, color: Colors.white,)
          )
          
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _showCreatePostModal(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),      
    );
  
  }
}
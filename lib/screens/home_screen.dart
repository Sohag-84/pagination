import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagination/provider/post_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostProvider postProvider;

  @override
  void initState() {
    super.initState();
    postProvider = PostProvider();
  }

  @override
  void dispose() {
    super.dispose();
    postProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => postProvider..fetchedPosts(),
        child: Consumer<PostProvider>(
          builder: (context, value, child) {
            return NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent &&
                    !postProvider.isLoading) {
                  postProvider.fetchedPosts();
                }
                return false;
              },
              child: ListView.builder(
                itemCount:
                    postProvider.posts.length + (postProvider.hasMore ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == postProvider.posts.length) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.green,
                        size: 40,
                      ),
                    );
                  }
                  final post = postProvider.posts[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          post.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(post.body),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

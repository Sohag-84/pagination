import 'package:flutter/material.dart';
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
              child: ListView.builder(
                itemCount: postProvider.posts.length,
                itemBuilder: (BuildContext context, int index) {
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

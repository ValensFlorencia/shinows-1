import 'package:flutter/material.dart';
import 'package:shinows/data/dummy_posts.dart';
import 'package:shinows/screens/detail_screen.dart';

class SearchMenuScreen extends StatelessWidget {
  final String category;

  const SearchMenuScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredPosts = dummyPosts.where((post) {
      if (category == 'food') {
        return post.title.toLowerCase().contains('breakfast') ||
            post.title.toLowerCase().contains('food');
      } else if (category == 'vitamins') {
        return post.title.toLowerCase().contains('vitamins') ||
            post.title.toLowerCase().contains('vitamins');
      } else if (category == 'workout') {
        return post.title.toLowerCase().contains('workout') ||
            post.title.toLowerCase().contains('exercise');
      }
      return false;
    }).toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: '$category',
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 9),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Top'),
              Tab(text: 'Accounts'),
              Tab(text: 'Hashtags'),
              Tab(text: 'Posts'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPostsGrid(filteredPosts),
            const Center(child: Text('Accounts Content')),
            const Center(child: Text('Hashtags Content')),
            _buildPostsGrid(filteredPosts),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsGrid(List filteredPosts) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom dalam grid
          crossAxisSpacing: 16.0, // Jarak antar kolom
          mainAxisSpacing: 16.0, // Jarak antar baris
          childAspectRatio: 0.75, // Rasio item grid
        ),
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(post: post),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Gambar
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      post.imageUrl,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Teks
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Author
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(post.imageAuth),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                post.author,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

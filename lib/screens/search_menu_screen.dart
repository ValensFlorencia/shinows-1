import 'package:flutter/material.dart';
import 'package:shinows/data/dummy_posts.dart';
import 'package:shinows/screens/detail_screen.dart';

class SearchMenuScreen extends StatefulWidget {
  final String category;
  final String? noResultsMessage;
  final List filteredPosts; // Optional message for no results

  const SearchMenuScreen({
    Key? key,
    required this.category,
    required this.filteredPosts,
    this.noResultsMessage,
  }) : super(key: key);

  @override
  State<SearchMenuScreen> createState() => _SearchMenuScreenState();
}

class _SearchMenuScreenState extends State<SearchMenuScreen> {
  late TextEditingController _searchController;
  late List filteredPosts;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.text = widget.category;
    _filterPosts(widget.category);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPosts(String query) {
    setState(() {
      filteredPosts = dummyPosts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.author.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
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
              controller: _searchController,
              onChanged: (value) => _filterPosts(value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    _filterPosts('');
                  },
                ),
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 9),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => _filterPosts(_searchController.text),
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
    if (filteredPosts.isEmpty) {
      return Center(
        child: Text(
          widget.noResultsMessage ?? 'Does not have a relevant content',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
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

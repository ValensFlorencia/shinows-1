import 'package:flutter/material.dart';
import 'package:shinows/screens/search_menu_screen.dart';
import 'package:shinows/data/dummy_posts.dart';

void main() {
  runApp(const SearchScreenApp());
}

class SearchScreenApp extends StatelessWidget {
  const SearchScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> suggestions = [
    {"text": "food", "category": "food"},
    {"text": "workout", "category": "workout"},
    {"text": "vitamins", "category": "vitamins"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 9),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: TextButton(
                onPressed: () {
                  final input = searchController.text.toLowerCase();

                  List filteredPosts = dummyPosts.where((post) {
                    return post.title.toLowerCase().contains(input) ||
                        post.author.toLowerCase().contains(input);
                  }).toList();

                  if (input.contains("food")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchMenuScreen(
                          category: 'food',
                          filteredPosts: filteredPosts,
                        ),
                      ),
                    );
                  } else if (input.contains("vitamins")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchMenuScreen(
                          category: 'vitamins',
                          filteredPosts: filteredPosts,
                        ),
                      ),
                    );
                  } else if (input.contains("workout")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchMenuScreen(
                          category: 'workout',
                          filteredPosts: filteredPosts,
                        ),
                      ),
                    );
                  } else if (filteredPosts.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountsScreen(author: input),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchMenuScreen(
                          category: input,
                          filteredPosts: [],
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You may like",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: Text(
                      suggestion['text']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchMenuScreen(
                            category: suggestion['category']!,
                            filteredPosts: [],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountsScreen extends StatelessWidget {
  final String author;

  const AccountsScreen({Key? key, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          author,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Text(
                author[0].toUpperCase(),
                style: const TextStyle(fontSize: 40, color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              author,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

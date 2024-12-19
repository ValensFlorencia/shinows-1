import 'package:flutter/material.dart';
import 'package:shinows/data/dummy_posts.dart';
import 'package:shinows/screens/detail_screen.dart';
import 'package:shinows/screens/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter posts berdasarkan nama author
    final valtinoPosts =
        dummyPosts.where((post) => post.author == 'valtinolouwel').toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'valtinolouwel',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Profile Section
          Column(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('images/valval.jpg'),
              ),
              const SizedBox(height: 8),
              // Profile Name
              const Text(
                '@lewuolonitlav',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              // Following, Followers, Likes and Saves
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Fokus di tengah
                children: [
                  _buildStatColumn('22', 'Following'),
                  SizedBox(width: 16.0), // Jarak kustom
                  _buildStatColumn('2218', 'Followers'),
                  SizedBox(width: 16.0),
                  _buildStatColumn('197.5K', 'Likes'),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileEditScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Share Profile action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Share Profile',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          // Post Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: valtinoPosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 kolom dalam grid
                  crossAxisSpacing: 16.0, // Jarak antar kolom
                  mainAxisSpacing: 16.0, // Jarak antar baris
                  childAspectRatio: 0.75, // Rasio item grid
                ),
                itemBuilder: (context, index) {
                  final post = valtinoPosts[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke layar detail
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
                            child: Image.asset(
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
                                      backgroundImage:
                                          AssetImage(post.imageAuth),
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
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build the stat column
  Column _buildStatColumn(String count, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold, // Membuat teks menjadi tebal
          ),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600] // Membuat label juga tebal
              ),
        ),
      ],
    );
  }
}

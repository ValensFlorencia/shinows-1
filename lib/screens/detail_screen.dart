import 'package:flutter/material.dart';
import 'package:shinows/models/post_model.dart';

class DetailScreen extends StatelessWidget {
  final Post post;

  const DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Posted',
          style: TextStyle(
            color: Color(0xFF00D9C0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: Colors.grey[300],
            height: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Gambar profil dan nama pengguna
                CircleAvatar(
                  backgroundImage: AssetImage(post.imageAuth),
                  radius: 15,
                ),
                const SizedBox(width: 12),
                Text(
                  post.author,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                post.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 390,
              ),
            ),
            const SizedBox(height: 9),
            // Like, Comment, Share Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.grey),
                      onPressed: () {
                        // Handle like action
                      },
                    ),
                    const Text('098765'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline_outlined, color: Colors.grey),
                      onPressed: () {
                        // Handle comment action
                      },
                    ),
                    const Text('66'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Share'),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey),
                      onPressed: () {
                        // Handle share action
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 9),
            // Judul artikel
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Deskripsi artikel
            Text(
              post.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

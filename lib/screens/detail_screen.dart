import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinows/models/post_model.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePosts = prefs.getStringList('favoritePosts') ?? [];
    setState(() {
      _isFavorite = favoritePosts.contains(widget.post.title);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavoriteStatus(); // Memuat ulang status bookmark
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritePosts = prefs.getStringList('favoritePosts') ?? [];
    setState(() {
      if (_isFavorite) {
        favoritePosts.remove(widget.post.title);
        _isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.post.title} remove from bookmark')));
      } else {
        favoritePosts.add(widget.post.title);
        _isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.post.title} added to bookmark')));
      }
    });
    await prefs.setStringList('favoritePosts', favoritePosts);
  }

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
                  backgroundImage: AssetImage(widget.post.imageAuth),
                  radius: 15,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.post.author,
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
                widget.post.imageUrl,
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
                      icon:
                          const Icon(Icons.favorite_border, color: Colors.grey),
                      onPressed: () {
                        // Handle like action
                      },
                    ),
                    const Text('98765'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline_outlined,
                          color: Colors.grey),
                      onPressed: () {
                        // Handle comment action
                      },
                    ),
                    const Text('66'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                          _isFavorite ? Icons.bookmark : Icons.bookmark_border),
                      color: _isFavorite ? Colors.black : null,
                    )
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
              widget.post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Deskripsi artikel
            Text(
              widget.post.description,
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

import 'package:flutter/material.dart';
import 'package:shinows/screens/detail_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final List<String> recentImages = [
    'images/1.jpg',
    'images/2.jpg',
    'images/3.jpg',
    'images/4.jpg',
    'images/fatburn.jpg',
    'images/6.jpeg',
    'images/7.jpg',
    'images/8.jpg',
    'images/hairgrow.jpg',
    'images/5.jpg',
    'images/9.jpg',
    'images/valval.jpg',
    'images/hairvitamin.jpg',
    'images/healthysnacks.jpg',
    'images/ada.jpg',
    'images/wow.jpeg',
  ];

  List<bool> isImagePressed = [];
  String selectedImage = 'images/super.jpg'; // Default image

  @override
  void initState() {
    super.initState();
    isImagePressed = List.generate(recentImages.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "New Post",
          style: TextStyle(
            color: Color(0xFF00D9C0),
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPostScreen(imageUrl: selectedImage),
                ),
              );
            },
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio:
                  1, // Rasio 1:1 untuk memastikan gambar berbentuk persegi
              child: Container(
                color: Colors.grey[200],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  child: Image.asset(
                    selectedImage, // Gambar yang dipilih
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recents",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 0,
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: recentImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage =
                          recentImages[index]; // Update gambar utama
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      isImagePressed[index] = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      isImagePressed[index] = false;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isImagePressed[index] = false;
                    });
                  },
                  child: Opacity(
                    opacity: isImagePressed[index] ? 0.5 : 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(recentImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

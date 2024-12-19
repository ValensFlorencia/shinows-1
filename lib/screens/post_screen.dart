import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final List<String> recentImages = [
    'https://th.bing.com/th/id/OIP.DvP0bnIfw4mS0nrglNiDnQHaHa?w=174&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://th.bing.com/th/id/OIP.cwSUe0cKOb9J3WwZiN1hrgHaHa?rs=1&pid=ImgDetMain',
    'https://cms.disway.id/uploads/4f704cc5404ea1045e88fb4cdd1aadd0.jpg',
    'https://www.wowkeren.com/display/images/photo/2024/04/30/00508358.webp',
    'https://i.kym-cdn.com/editorials/icons/original/000/006/177/blackcatzoningout_meme.jpg',
    'https://i.mydramalist.com/Rq2nR_2f.jpg',
    'http://thecleverheart.com/wp-content/uploads/2023/04/find-a-reason-to-smile-every-day-1024x1024.png',
    'https://kpopping.com/documents/42/4/800/241110-Shao-Zi-Heng-Starlight-Boys-Fan-Meeting-documents-5.jpeg?v=3364f',
    'https://tse3.mm.bing.net/th?id=OIP._p0DQ0CCG08zyAnr0TT6agHaEK&pid=Api&P=0&h=180',
    'https://allears.net/wp-content/uploads/2020/08/disney-princess-wreck-it-ralph-scaled.jpg',
    'https://hauloffame.co/wp-content/uploads/2022/09/Classy-Short-Nail-Designs-1024x768.jpg',
    'https://i2.wp.com/resepkoki.id/wp-content/uploads/2018/11/puff-pastry.jpg?fit=1194%2C893&ssl=1',
    'https://wallpaperaccess.com/full/354970.jpg',
    'https://i.pinimg.com/originals/69/d0/72/69d072018e6e95ed0f9cb08da8d4e899.jpg',
    'https://i.pinimg.com/736x/bd/0f/5c/bd0f5cca54418c80bbdca5a17622c790.jpg',
    'https://i.pinimg.com/736x/39/dd/9a/39dd9a62af6558596a7e3c0cb457182c.jpg',
  ];

  List<bool> isImagePressed =
      List.generate(16, (_) => false); // Menyimpan status gambar yang ditekan

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
              // Aksi tombol "Next"
            },
            child: const Text(
              "Next",
              style: TextStyle(color: Color(0xFF00D9C0), fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[200],
                  child: Image.asset(
                    'images/super.jpg',
                    width: double.infinity,
                    height: 1200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_library_outlined),
                      onPressed: () {
                        // Aksi ketika ikon photo library ditekan
                      },
                    ),
                    const Icon(Icons.camera_alt_outlined),
                  ],
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
            flex: 3,
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
                  onTapDown: (_) {
                    setState(() {
                      isImagePressed[index] =
                          true; // Menandai gambar yang sedang ditekan
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      isImagePressed[index] =
                          false; // Mengembalikan status gambar
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isImagePressed[index] =
                          false; // Mengembalikan status gambar jika tap dibatalkan
                    });
                  },
                  child: Opacity(
                    opacity: isImagePressed[index]
                        ? 0.5
                        : 1.0, // Mengatur opacity saat gambar ditekan
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(recentImages[index]),
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

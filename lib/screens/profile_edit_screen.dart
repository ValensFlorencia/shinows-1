import 'package:flutter/material.dart';
import 'package:shinows/screens/profile_screen.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF00D9C0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Profile Picture Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/valval.jpg'),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      // Handle picture change action
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 16,
                    ),
                    label: const Text(
                      'Edit picture or avatar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildTextField('Name', 'valtinolouwel'),
                  _buildTextField('Username', '@lewuolonitlav'),
                  _buildTextField('Pronouns', 'Pronouns'),
                  _buildTextField('Bio', 'Bio'),
                  _buildTextField('Links', 'Links'),
                  _buildTextField('Gender', 'Male'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Save Button
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D9C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

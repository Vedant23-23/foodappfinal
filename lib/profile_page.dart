import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();

  final _nameController = TextEditingController(text: "Emilia Clarke");
  final _emailController =
      TextEditingController(text: "emiliaclarke@email.com");
  final _mobileController =
      TextEditingController(text: "emiliaclarke@email.com");
  final _addressController =
      TextEditingController(text: "No 23, 6th Lane, Colombo 03");
  final _passwordController = TextEditingController(text: "12345678");
  final _confirmPasswordController = TextEditingController(text: "12345678");

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    // You can store or update the user info here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile Saved Successfully')),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                      child: Text("Profile",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold))),
                  Icon(Icons.shopping_cart_outlined)
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/img/avatar.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Column(
                        children: const [
                          Icon(Icons.edit, color: Colors.orange),
                          Text("Edit Profile",
                              style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Hi there Emilia!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const Text("Sign Out", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              _buildTextField("Name", _nameController),
              _buildTextField("Email", _emailController),
              _buildTextField("Mobile No", _mobileController),
              _buildTextField("Address", _addressController),
              _buildTextField("Password", _passwordController, obscure: true),
              _buildTextField("Confirm Password", _confirmPasswordController,
                  obscure: true),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Save", style: TextStyle(fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

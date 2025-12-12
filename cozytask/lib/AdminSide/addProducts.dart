import 'package:cozytask/components/backButtonLogin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductAdminPage extends StatefulWidget {
  const AddProductAdminPage({super.key});

  @override
  State<AddProductAdminPage> createState() => _AddProductAdminPageState();
}

class _AddProductAdminPageState extends State<AddProductAdminPage> {
  final TextEditingController priceController = TextEditingController();
  File? selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ReturnLoginButton(),
              ),

              const Center(
                child: Text(
                  'Add Product',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Price",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF000000),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              SizedBox(
                height: 50,
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0XFFD8E8F4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Drop Image",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF000000),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0XFFD8E8F4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedImage == null
                      ? const Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 60),

              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(320, 50),
                        backgroundColor: const Color(0XFF004463),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'ADD ITEM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(320, 50),
                        backgroundColor: const Color(0XFF7B7B7B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

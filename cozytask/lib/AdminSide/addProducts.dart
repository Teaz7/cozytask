import 'dart:typed_data';
import 'package:cozytask/database/models/storeModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cozytask/components/backButtonLogin.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/productModel.dart';

class AddProductAdminPage extends StatefulWidget {
  const AddProductAdminPage({super.key});

  @override
  State<AddProductAdminPage> createState() => _AddProductAdminPageState();
}

class _AddProductAdminPageState extends State<AddProductAdminPage> {
  List<Store> storelist = [];

  final TextEditingController nameController = TextEditingController();
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

  Future<void> _addProduct() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
      return;
    }

    try {
      Uint8List? imageBytes;
      if (selectedImage != null) {
        imageBytes = await selectedImage!.readAsBytes();
      }

      const String defaultCategory = "General";

      final data = await DBHelper.instance.readAllStore();
      setState(() {
        storelist = data;
      });

      for (var i in storelist) {
        await DBHelper.instance.createProduct(Product(
          name: nameController.text,
          category: defaultCategory,
          amount: int.tryParse(priceController.text) ?? 0,
          photo: imageBytes,
          storeid: i.id
        ));
      }
      
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error adding product: $e")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                "Product Name",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF000000),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0XFFD8E8F4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Price",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF000000),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
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
              ),

              const SizedBox(height: 20),

              const Text(
                "Product Image",
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
                  // ✅ 1. HEIGHT ADJUSTMENT
                  // Increased from 350 to 400. You can go up to 500 if needed.
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0XFFD8E8F4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedImage == null
                      ? const Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            selectedImage!,

                            // ✅ 2. IMAGE FITTING ADJUSTMENT
                            // Use BoxFit.cover to fill the box (might crop edges).
                            // Use BoxFit.contain to show entire image (might leave empty space).
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
                      onPressed: _addProduct,
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

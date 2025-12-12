import 'dart:io';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final int? id;
  final String name;
  final int price;
  final File? image;

  const EditProductPage({
    super.key,
    this.id,
    required this.name,
    required this.price,
    this.image,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  // ✅ FIX: Remove 'late' and initialize directly
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values
    nameController.text = widget.name;
    priceController.text = widget.price.toString();
  }

  @override
  void dispose() {
    // ✅ IMPORTANT: Always dispose controllers
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 5),
            const Center(
              child: Text(
                "Edit Item",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004562),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFD8E8F4),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF004562), width: 3),
                ),
                child: widget.image == null
                    ? const Icon(
                        Icons.person,
                        size: 120,
                        color: Color(0xFF004562),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(widget.image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Item Name",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 45,
              child: TextField(
                controller: nameController, // ✅ Now properly initialized
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD8E8F4),
                  hintText: "Enter new name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Item Price",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 45,
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD8E8F4),
                  hintText: "Enter new price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'id': widget.id,
                    'name': nameController.text,
                    'price': int.tryParse(priceController.text) ?? widget.price,
                    'image': widget.image,
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: const Color(0xFF004562),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "SAVE CHANGES",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: const Color(0xFF7B7B7B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

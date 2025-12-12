import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cozytask/AdminSide/editProduct';

class ModifyProductPage extends StatelessWidget {
  final String name;
  final int price;
  final File? image;

  const ModifyProductPage({
    super.key,
    required this.name,
    required this.price,
    this.image,
  });

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

            const SizedBox(height: 10),

            Center(
              child: Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  color: const Color(0xFFD8E8F4),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFF004562),
                    width: 3,
                  ),
                ),
                child: image == null
                    ? const Icon(
                        Icons.person,
                        size: 120,
                        color: Color(0xFF004562),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(image!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004562),
                    ),
                  ),
                  Text(
                    "Price: $price points",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProductPage(
                        name: name,
                        price: price,
                        image: image,
                      ),
                    ),
                  );
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
                  "EDIT INFO",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: const Color(0xFF7B7B7B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "DELETE ITEM",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

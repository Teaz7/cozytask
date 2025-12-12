import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cozytask/AdminSide/addProducts.dart';
import 'package:cozytask/AdminSide/modifyProduct.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/productModel.dart';
import 'package:cozytask/components/backButtonLogin.dart';

class ProductsAdminPage extends StatelessWidget {
  const ProductsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Products Admin',
      debugShowCheckedModeBanner: false,
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  Future<List<Product>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<Product>> _loadProducts() async {
    try {
      return await DBHelper.instance.readAllProducts();
    } catch (e) {
      print("Error loading products: $e");
      return [];
    }
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = _loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: ReturnLoginButton(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF004562),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "PRODUCTS",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'GillSansMT',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: FutureBuilder<List<Product>>(
                          future: _productsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF68A3BC),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Error: ${snapshot.error}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No products found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                            final products = snapshot.data!;
                            return RefreshIndicator(
                              onRefresh: _refreshProducts,
                              child: GridView.builder(
                                itemCount: products.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 125 / 180,
                                    ),
                                itemBuilder: (_, i) =>
                                    _productCard(products[i], context),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProductAdminPage(),
                    ),
                  );
                  if (result == true) _refreshProducts();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 60),
                  backgroundColor: const Color(0XFF003D54),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'ADD PRODUCT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        File? imageFile;
        if (product.photo != null && product.photo!.isNotEmpty) {
          final tempDir = Directory.systemTemp;
          final tempFile = File('${tempDir.path}/temp_product_image.jpg');
          await tempFile.writeAsBytes(product.photo!);
          imageFile = tempFile;
        }

        // ✅ Navigate and await the result from ModifyProductPage
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ModifyProductPage(
              id: product.id, // ✅ PASS PRODUCT ID
              name: product.name,
              price: product.amount,
              image: imageFile,
            ),
          ),
        );

        // ✅ Handle the returned data map
        if (result != null && result is Map<String, dynamic>) {
          // ✅ Update the database
          await _updateProductInDB(result);
          // ✅ Refresh the UI
          _refreshProducts();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFacd1fc),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProductImage(product.photo),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF004562),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Price: ${product.amount}',
              style: const TextStyle(fontSize: 14, color: Color(0xFF004562)),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ NEW METHOD: Update product in database
  Future<void> _updateProductInDB(Map<String, dynamic> updatedData) async {
    try {
      // Assuming your Product model has an id field
      final updatedProduct = Product(
        id: updatedData['id'],
        name: updatedData['name'],
        amount: updatedData['price'],
        photo: updatedData['image'] != null
            ? await (updatedData['image'] as File).readAsBytes()
            : null,
      );

      await DBHelper.instance.updateProduct(updatedProduct);
      print("✅ Product updated successfully");
    } catch (e) {
      print("❌ Error updating product: $e");
      // Show error snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update product: $e')));
    }
  }

  Widget _buildProductImage(Uint8List? photoBytes) {
    double imageSize = 150;
    if (photoBytes == null || photoBytes.isEmpty) {
      return Icon(
        Icons.inventory_2_outlined,
        color: const Color(0xFF5b8cdb),
        size: imageSize,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        photoBytes,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Icon(
          Icons.broken_image,
          color: const Color(0xFF5b8cdb),
          size: imageSize,
        ),
      ),
    );
  }
}

import 'package:cozytask/AdminSide/addProducts';
import 'package:cozytask/AdminSide/modifyProduct';
import 'package:flutter/material.dart';

class productsAdminPage extends StatelessWidget {
  const productsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'GillSansMT',
      ),
      home: const Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned.fill(child: ShoppingPage()),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final List<Map<String, dynamic>> _products = List.generate(
    6,
    (i) => {
      'name': 'Item #${i + 1}',
      'price': 500 + i * 100,
      'image': null,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Container(
          width: 380,
          decoration: BoxDecoration(
            color: const Color(0xFF004562),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Text(
                "PRODUCTS",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                height: 480,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  itemCount: _products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 125 / 150,
                  ),
                  itemBuilder: (_, i) =>
                      _productCard(_products[i], context),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductAdminPage(),
                ),
              );
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _productCard(Map<String, dynamic> data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ModifyProductPage(
              name: data['name'],
              price: data['price'],
              image: data['image'],
            ),
          ),
        );
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
            const Icon(
              Icons.person_2_outlined,
              color: Color(0xFF5b8cdb),
              size: 60,
            ),
            const SizedBox(height: 3),
            Text(
              data['name'],
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF004562),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Price: ${data['price']}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF004562),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cozytask/components/backbutton.dart';
import 'package:cozytask/components/bottomnavbar.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ShopPage());

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned.fill(
                child: ShoppingPage()
              ),
              BottomNavBar()
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
    (i) => {'name': 'Item #${i + 1}', 'price': 500 + i * 100},
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomBackButton(),

        const SizedBox(height: 15),

        Container(
          width: 360,
          height: 650, // smaller height
          decoration: BoxDecoration(
            color: const Color(0xFF004562),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 5),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/COZY_TASK_LOGO_WHITE.png',
                    height: 65,
                  ),
                  const Text(
                    'STORE',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Current Points:',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      '2100 Points',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              // SCROLLABLE PRODUCT GRID  //
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: _products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 125 / 150,
                        ),
                    itemBuilder: (_, i) => _productCard(_products[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }

  /* --------------------  WIDGET HELPERS  -------------------- */
  Widget _productCard(Map<String, dynamic> data) {
    return Container(
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
            style: const TextStyle(fontSize: 14, color: Color(0xFF004562)),
          ),
        ],
      ),
    );
  }
}
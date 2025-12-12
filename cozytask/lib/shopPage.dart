import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/components/bottomnavbar.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/productModel.dart';
import 'package:cozytask/database/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:cozytask/storeItem.dart';

class ShopPage extends StatelessWidget {
  final int? userid;
  const ShopPage({super.key, required this.userid});

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
              Positioned.fill(child: ShoppingPage(userid: userid,)),
              BottomNavBar(userid: userid,),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  final int? userid;
  const ShoppingPage({super.key, required this.userid});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List<Product> productlist = [];
  late User user;

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await DBHelper.instance.returnUser(widget.userid);
    setState(() {
      user = data;
    });
  }
  
  Future<void> loadProducts() async {
    final storeid = await DBHelper.instance.returnCalendarID(widget.userid);
    final data = await DBHelper.instance.returnProductsfromStore(storeid);
    setState(() {
      productlist = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomBackButton(userid: widget.userid,),

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
              Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 5)),

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
                  children:  [
                    Text(
                      'Current Points:',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      user.points.toString(),
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
                    itemCount: productlist.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 125 / 150,
                        ),
                    itemBuilder: (_, i) => _productCard(productlist[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /* --------------------  WIDGET HELPERS  -------------------- */
  Widget _productCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => StoreItem(userid: widget.userid, product: product,)));
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
            product.photo != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    product.photo!,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(
                  Icons.image_outlined,
                  color: Color(0xFF5b8cdb),
                  size: 60,
                ),
            const SizedBox(height: 3),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF004562),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Price: ${product.amount}',
              style: const TextStyle(fontSize: 14, color: Color(0xFF004562)),
            ),
          ],
        ),
      ),
    );
  }
}

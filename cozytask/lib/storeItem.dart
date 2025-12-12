import 'package:cozytask/components/storeBackButton.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/productModel.dart';
import 'package:cozytask/database/models/purchasesModel.dart';
import 'package:cozytask/database/models/userModel.dart';
import 'package:cozytask/shopPage.dart';

import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  final int? userid;
  final Product product;
  const StoreItem({super.key, required this.userid, required this.product});

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
          child: Stack(children: [Positioned.fill(child: ShoppingPageItem(userid: userid, product: product,))]),
        ),
      ),
    );
  }
}

class ShoppingPageItem extends StatefulWidget {
  final int? userid;
  final Product product;
  const ShoppingPageItem({super.key, required this.userid, required this.product});

  @override
  State<ShoppingPageItem> createState() => _ShoppingPageItemState();
}

class _ShoppingPageItemState extends State<ShoppingPageItem> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final data = await DBHelper.instance.returnUser(widget.userid);
    setState(() {
      user = data;
      isLoading = false;
    });
  }

  Future<bool> _showPurchaseConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'PURCHASE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004562),
                            fontFamily: 'GillSansMT',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ITEM',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004562),
                            fontFamily: 'GillSansMT',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Are you sure you want to\npurchase this item for ${widget.product.amount} points?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF004562),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Color(0xFF004562),
                          ),
                          child: const Text(
                            'CONFIRM',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: const Color(0xFF7B7B7B),
                          ),
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ) ??
        false;
  }

  Future<void> _showPurchaseSuccessDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Dialog(
            backgroundColor: Colors.white, // Solid background
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/img/COZY_TASK_LOGO.png',
                    width: 120,
                    height: 120,
                  ),
                  Text(
                    'ITEM PURCHASED\nSUCCESSFULLY!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004562),
                      fontFamily: 'GillSansMT',
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    'Click anywhere to continue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF004562),
                      fontFamily: 'GillSansMT',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handlePurchase() async {
    if (user == null) return;

    // Check if user has enough points
    if (user!.points < widget.product.amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insufficient points! You need ${widget.product.amount} points.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Deduct points from user
    final updatedPoints = user!.points - widget.product.amount;
    
    // Update user points in database
    // You'll need to add this method to your DBHelper if it doesn't exist
    await DBHelper.instance.updateUserPoints(widget.userid, updatedPoints);
    await DBHelper.instance.createPurchases(Purchases(
      photo: widget.product.photo,
      userid: widget.userid,
      prodid: widget.product.id
    ));
    await DBHelper.instance.deleteProduct(widget.product.id);
    
    // Show success dialog
    await _showPurchaseSuccessDialog(context);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShopPage(userid: widget.userid)),
    );
    
    // Reload user data
    await loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Storebackbutton(userid: widget.userid,),
        const SizedBox(height: 100),
        Container(
          width: 360,
          height: 400,
          decoration: BoxDecoration(
            color: const Color(0xFFacd1fc),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Color(0xFF004562),
              width: 5,
              style: BorderStyle.solid,
            ),
          ),
          child: widget.product.photo != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    widget.product.photo!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_outlined,
                    size: 200,
                    color: Color(0xFF004562),
                  ),
                ),
        ),
        Text(
          widget.product.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004562),
          ),
        ),
        Text(
          'Price: ${widget.product.amount} Points',
          style: TextStyle(fontSize: 20, color: Color(0xFF004562)),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            bool confirmed = await _showPurchaseConfirmation(context);

            if (confirmed) {
              // Show the new success dialog
              await _handlePurchase();

              // Add your purchase logic here
              // e.g., deduct points, update inventory, etc.
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF004562),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Purchase',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

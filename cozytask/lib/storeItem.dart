import 'package:cozytask/components/storeBackButton.dart';

import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  final int? userid;
  const StoreItem({super.key, required this.userid});

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
          child: Stack(children: [Positioned.fill(child: ShoppingPageItem(userid: userid,))]),
        ),
      ),
    );
  }
}

class ShoppingPageItem extends StatefulWidget {
  final int? userid;
  const ShoppingPageItem({super.key, required this.userid});

  @override
  State<ShoppingPageItem> createState() => _ShoppingPageItemState();
}

class _ShoppingPageItemState extends State<ShoppingPageItem> {
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
                      'Are you sure you want to\npurchase this item?',
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
          child: Align(
            alignment: Alignment.center,
            child: Icon(Icons.person, size: 200, color: Color(0xFF004562)),
          ),
        ),
        Text(
          'Item Name',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004562),
          ),
        ),
        Text(
          'Price: 500 Points',
          style: TextStyle(fontSize: 20, color: Color(0xFF004562)),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            bool confirmed = await _showPurchaseConfirmation(context);

            if (confirmed) {
              // Show the new success dialog
              await _showPurchaseSuccessDialog(context);

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

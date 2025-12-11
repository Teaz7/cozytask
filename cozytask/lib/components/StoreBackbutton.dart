import 'package:cozytask/shopPage.dart';
import 'package:flutter/material.dart';

class Storebackbutton extends StatefulWidget {
  final int? userid;
  const Storebackbutton({super.key, required this.userid});

  @override
  State<Storebackbutton> createState() => _StorebackbuttonState();
}

class _StorebackbuttonState extends State<Storebackbutton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 60),

        SizedBox(
          width: 350,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopPage(userid: widget.userid,)),
                );
              },
              child: Image.asset(
                'assets/icon/BackButton.png',
                height: 30,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

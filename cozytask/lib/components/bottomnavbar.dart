import 'package:cozytask/calendar.dart';
import 'package:cozytask/dashboard.dart';
import 'package:cozytask/main.dart';
import 'package:cozytask/profile.dart';
import 'package:cozytask/settings.dart';
import 'package:cozytask/shopPage.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int? userid;
  const BottomNavBar({super.key, required this.userid});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  void _openDrawer() => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext modalContext) => _drawerSheet(modalContext),
  );

  Widget _drawerSheet(BuildContext modalContext) => Container(
    height: 320,
    decoration: const BoxDecoration(
      color: Color(0XFF004463),
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      children: [
        const SizedBox(height: 15),
        Container(
          width: 200,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("User ID: ${widget.userid}");
                Navigator.pop(modalContext);
                Navigator.push(
                  modalContext,
                  MaterialPageRoute(builder: (context) => DashboardPage(userid: widget.userid,)),
                );
              },
              child: _tile(Icons.home, 'Home'),
            ),

            GestureDetector(
              onTap: () {
                print("User ID: ${widget.userid}");
                Navigator.pop(modalContext);
                Navigator.push(
                  modalContext,
                  MaterialPageRoute(builder: (context) => ShopPage(userid: widget.userid,)),
                );
              },
              child: _tile(Icons.store, 'Store'),
            ),

            GestureDetector(
              onTap: () {
                print("User ID: ${widget.userid}");
                Navigator.pop(modalContext);
                Navigator.push(
                  modalContext,
                  MaterialPageRoute(builder: (context) => CalendarPage(userid: widget.userid,)),
                );
              },
              child: _tile(Icons.calendar_today, 'Calendar'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("User ID: ${widget.userid}");
                Navigator.pop(modalContext);
                Navigator.push(
                  modalContext,
                  MaterialPageRoute(builder: (context) => SettingsPage(userid: widget.userid,)),
                );
              },
              child: _tile(Icons.settings, 'Settings'),
            ),

            GestureDetector(
              onTap: () {
                print("User ID: ${widget.userid}");
                Navigator.pop(modalContext);
                Navigator.push(
                  modalContext,
                  MaterialPageRoute(builder: (context) => ProfilePage(userid: widget.userid,)),
                );
              },
              child: _tile(Icons.person, 'Profile'),
            ),

            GestureDetector(
              onTap: () {
                print("User ID: ${widget.userid}");
                Navigator.pop(modalContext);
                Navigator.push(
                  modalContext,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: _tile(Icons.logout_outlined, 'Logout'),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _tile(IconData icon, String label) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 70, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: _openDrawer,
          behavior: HitTestBehavior.translucent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0XFF004463),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsetsGeometry.all(10),
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      height: 3,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                    ),    
                  ],
                )                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
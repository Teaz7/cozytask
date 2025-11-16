import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  void _openDrawer() => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _drawerSheet(),
  );

  Widget _drawerSheet() => Container(
    height: 320,
    decoration: const BoxDecoration(
      color: Color(0XFF004463),
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tile(Icons.home, 'Home'),
            _tile(Icons.store, 'Store'),
            _tile(Icons.calendar_today, 'Calendar'),
          ],
        ),
        const SizedBox(height: 10),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tile(Icons.settings, 'Settings'),
            _tile(Icons.person, 'Profile'),
            _tile(Icons.logout_outlined, 'Logout'),
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
      bottom: 30,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: _openDrawer,
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0XFF004463),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
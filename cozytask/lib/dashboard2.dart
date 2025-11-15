import 'package:flutter/material.dart';

void main() {
  runApp(const DashBoardApp());
}

class DashBoardApp extends StatelessWidget {
  const DashBoardApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: const Scaffold(body: Center(child: Login())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _dashBoardState();
}

/* -------------------------------------------------
   NEW CODE : slide-up drawer helpers
   ------------------------------------------------- */
class _dashBoardState extends State<Login> {
  /* ---- open the blue sheet ---- */
  void _openDrawer() => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _drawerSheet(),
  );

  /* ---- blue drawer content ---- */
  Widget _drawerSheet() => Container(
    height: 320,
    decoration: const BoxDecoration(
      color: Colors.blue,
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
        /* row 1 */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tile(Icons.home, 'Home'),
            _tile(Icons.store, 'Store'),
            _tile(Icons.calendar_today, 'Calendar'),
          ],
        ),
        const SizedBox(height: 10),
        /* row 2 */
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

  /* ---- single icon + label ---- */
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

  /* ---- visible handle only ---- */
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: _openDrawer,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:cozytask/chooseaccount.dart';
import 'package:cozytask/main.dart';
import 'package:cozytask/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NavTestPage());
}

class NavTestPage extends StatelessWidget {
  const NavTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT'
      ),
      home: NavTest(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavTest extends StatefulWidget {
  const NavTest({super.key});

  @override
  State<NavTest> createState() => _NavTestState();
}

class _NavTestState extends State<NavTest> {
  @override

  int _selectedIndex = 0;

  final List<Widget> widgetOptions = const [
    Login(),
    SignUp(),
    ChooseAccount()
  ];

  void _onItemTapped (int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '1'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '2'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '3'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
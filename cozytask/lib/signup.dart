import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/calendarModel.dart';
import 'package:cozytask/database/models/productModel.dart';
import 'package:cozytask/database/models/storeModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cozytask/main.dart';
import 'database/models/userModel.dart';

void main() {
  runApp(const SignUpPage());
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(body: Center(child: const SignUp())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<String> fields = [
    'Username:',
    'Email Address:',
    'University:',
    'Year Level:',
    'Password:',
    'Confirm Password:',
  ];
  List<TextInputType> fieldType = [
    TextInputType.text,
    TextInputType.emailAddress,
    TextInputType.text,
    TextInputType.number,
    TextInputType.text,
    TextInputType.text,
  ];
  List<User> users = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool fieldsEmpty() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        universityController.text.isEmpty ||
        yearController.text.isEmpty ||
        passController.text.isEmpty ||
        confirmController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await DBHelper.instance.readAllUser();
    setState(() {
      users = data;
    });
  }

  Future<int?> getStoreIdForUser(int userId) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      "store",
      columns: ["STORE_ID"],
      where: "USER_ID = ?",
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first["STORE_ID"] as int?;
    }
    return null;
  }

  Future<void> duplicateProductsForNewUser(int newStoreId) async {
    // Get all existing products from the database
    final allProducts = await DBHelper.instance.readAllProducts();
    
    if (allProducts.isEmpty) {
      print("No products to duplicate");
      return;
    }

    // Create a map to track unique products by their key attributes
    // Using name + category as the unique identifier
    final Map<String, Product> uniqueProducts = {};
    
    for (var product in allProducts) {
      // Create a unique key (name + category, case-insensitive)
      String productKey = '${product.name.toLowerCase().trim()}_${(product.category ?? '').toLowerCase().trim()}';
      
      // Keep the first occurrence of each unique product
      if (!uniqueProducts.containsKey(productKey)) {
        uniqueProducts[productKey] = product;
      }
    }

    // Now create copies for the new user's store
    for (var product in uniqueProducts.values) {
      await DBHelper.instance.createProduct(
        Product(
          name: product.name,
          amount: product.amount,
          category: product.category,
          photo: product.photo,
          storeid: newStoreId,
        ),
      );
      print("Added product: ${product.name} to store $newStoreId");
    }
    
    print("Duplicated ${uniqueProducts.length} unique products for store $newStoreId");
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      nameController,
      emailController,
      universityController,
      yearController,
      passController,
      confirmController,
    ];

    void clearController() async {
      for (var i in controllers) {
        i.clear();
      }
    }

    void addUser() async {
      if (!fieldsEmpty()) {
        if (passController.text == confirmController.text) {
          int newid = await DBHelper.instance.createUser(
            User(
              name: nameController.text,
              password: passController.text,
              email: emailController.text,
              university: universityController.text,
              year: int.parse(yearController.text),
              points: 0,
              loginstatus: 'Logged Out',
              petid: null,
            ),
          );

          await DBHelper.instance.createCalendar(
            Calendar(numoftask: 0, userid: newid),
          );
          int newstore = await DBHelper.instance.createStore(Store(num: 0, userid: newid));
          await duplicateProductsForNewUser(newstore);

          clearController();
          loadUsers();
          print("Database updated!");
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(45)),

        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/img/COZY_TASK_TEXT_BLUE_LOGO.png',
            height: 75,
          ),
        ),

        Padding(padding: EdgeInsets.all(25)),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.center,
          child: Text(
            'CREATE AN ACCOUNT',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0XFF68A3BC),
            ),
          ),
        ),

        //Text Fields for looped
        for (int i = 0; i < fields.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  width: 300,
                  alignment: Alignment.centerLeft,
                  child: Text(fields[i], style: TextStyle(fontSize: 14)),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: 300,
                  height: 50,
                  child: TextField(
                    keyboardType: fieldType[i],
                    controller: controllers[i],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0XFFD8E8F4),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

        Padding(padding: EdgeInsets.all(10)),

        ElevatedButton(
          onPressed: () {
            addUser();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(220, 40),
            backgroundColor: Color(0XFF68A3BC),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'SIGN UP',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already have an account? ", style: TextStyle(fontSize: 12)),

              RichText(
                text: TextSpan(
                  text: 'Log In.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:typed_data';

class Product {
  int? id;
  int amount;
  String name;
  String? category; // ✅ Hidden from UI
  Uint8List? photo;
  int? storeid; // ✅ Not needed but kept for compatibility

  Product({
    this.id,
    required this.amount,
    required this.name,
    this.category,
    this.photo,
    this.storeid, // ✅ Optional
  });

  Map<String, dynamic> toMap() {
    return {
      'PROD_ID': id,
      'PROD_Name': name,
      'PROD_Category': category,
      'PROD_Amount': amount,
      'PROD_Photo': photo,
      'STORE_ID': 1, // ✅ CONSTANT - always 1
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['PROD_ID'],
      name: map['PROD_Name'],
      category: map['PROD_Category'],
      amount: map['PROD_Amount'],
      photo: map['PROD_Photo'],
      storeid: map['STORE_ID'], // ✅ Will be 1
    );
  }
}

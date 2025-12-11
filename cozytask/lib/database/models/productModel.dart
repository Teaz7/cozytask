class Product {
  int? id, storeid;
  int amount;
  String name, category, photo;

  Product({
    this.id,
    this.storeid,
    required this.amount,
    required this.name,
    required this.category,
    required this.photo
  });

  Map<String, dynamic> toMap() {
    return {
      'PROD_ID': id,
      'PROD_Name': name,
      'PROD_Category': category,
      'PROD_Amount': amount,
      'PROD_Photo': photo,
      'STORE_ID': storeid
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['PROD_ID'],
      name: map['PROD_Name'],
      category: map['PROD_Category'],
      amount: map['PROD_Amount'],
      photo: map['PROD_Photo'],
      storeid: map['STORE_ID']
    );
  }
}

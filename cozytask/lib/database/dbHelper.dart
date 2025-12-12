import 'package:cozytask/database/models/purchasesModel.dart';
import 'package:cozytask/database/models/subtaskModel.dart';
import 'package:cozytask/database/models/taskModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/userModel.dart';
import 'models/calendarModel.dart';
import 'models/storeModel.dart';
import 'models/productModel.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("app.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "app.db");

    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    await deleteDatabase(path);
    _database = await _initDB("app.db");
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user(
      USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      USER_Name TEXT NOT NULL,
      USER_Password TEXT NOT NULL,
      USER_Email TEXT NOT NULL,
      USER_University TEXT NOT NULL,
      USER_YearLevel INTEGER NOT NULL,
      USER_Points INTEGER NOT NULL,
      USER_LoginStatus TEXT NOT NULL,
      USER_SelectedPetID INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE calendar(
      CAL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      CAL_NumOfTask INTEGER NOT NULL,
      USER_ID INTEGER,
      FOREIGN KEY (USER_ID) REFERENCES user (USER_ID) ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE task(
      TASK_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      TASK_Name TEXT NOT NULL,
      TASK_Description TEXT NOT NULL,
      TASK_PriorityClass INTEGER NOT NULL,
      TASK_Status TEXT NOT NULL,
      TASK_DateStart TEXT NOT NULL,
      TASK_DateFinish TEXT NOT NULL,
      TASK_Progress INTEGER NOT NULL,
      CAL_ID INTEGER,
      USER_ID INTEGER,
      FOREIGN KEY (CAL_ID) REFERENCES calendar(CAL_ID) ON DELETE CASCADE,
      FOREIGN KEY (USER_ID) REFERENCES user (USER_ID) ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE subtask(
      SUBTASK_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      SUBTASK_Name TEXT NOT NULL,
      SUBTASK_Status TEXT NOT NULL,
      TASK_ID INTEGER,
      FOREIGN KEY (TASK_ID) REFERENCES task (TASK_ID) ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE reward(
      REWARD_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      REWARD_Points INTEGER NOT NULL,
      TASK_ID INTEGER,
      USER_ID INTEGER,
      FOREIGN KEY (TASK_ID) REFERENCES task (TASK_ID) ON DELETE CASCADE,    
      FOREIGN KEY (USER_ID) REFERENCES user (USER_ID) ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE store(
      STORE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      STORE_NumOfProduct INTEGER NOT NULL,
      USER_ID INTEGER,
      FOREIGN KEY (USER_ID) REFERENCES user (USER_ID) ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE product(
      PROD_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      PROD_Name TEXT NOT NULL,
      PROD_Category TEXT,
      PROD_Amount INTEGER NOT NULL,
      PROD_Photo BLOB,
      STORE_ID INTEGER NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE purchases(
      PUR_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      PUR_Photo BLOB,
      USER_ID INTEGER,
      PROD_ID INTEGER
    )
    ''');
  }

  /*          -- USER CRUD --         */
  Future<int> createUser(User user) async {
    final db = await instance.database;
    return await db.insert("user", user.toMap());
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;
    final result = await db.query("user", orderBy: "USER_ID DESC");
    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return await db.update(
      "user",
      user.toMap(),
      where: "USER_ID = ?",
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete("user", where: "USER_ID = ?", whereArgs: [id]);
  }

  Future<int?> returnUserID(String email, String password) async {
    final db = await instance.database;
    final result = await db.query(
      "user",
      columns: ["USER_ID"],
      where: "USER_Email = ? AND USER_Password = ?",
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first["USER_ID"] as int;
    } else {
      return null;
    }
  }

  Future<User> returnUser(int? userid) async {
    final db = await instance.database;
    final result = await db.query("user", where: "USER_ID = ?", whereArgs: [userid]);
    return User.fromMap(result.first);
  }

  Future<int> updateUserPoints(int? userid, int points) async {
    final db = await database;
      return await db.update(
        'user',
        {'USER_Points': points},
        where: 'USER_ID = ?',
        whereArgs: [userid],
      );
  }

  /*          -- CALENDAR CRUD --         */
  Future<int> createCalendar(Calendar calendar) async {
    final db = await instance.database;
    return await db.insert("calendar", calendar.toMap());
  }

  Future<int?> returnCalendarID(int? userid) async {
    final db = await instance.database;
    final result = await db.query(
      "calendar",
      columns: ["CAL_ID"],
      where: "USER_ID = ?",
      whereArgs: [userid],
    );
    if (result.isNotEmpty) {
      return result.first["CAL_ID"] as int?;
    } else {
      return null;
    }
  }

  /*          -- STORE CRUD --         */
  Future<int> createStore(Store store) async {
    final db = await instance.database;
    return await db.insert("store", store.toMap());
  }

  Future<List<Store>> readAllStore() async {
    final db = await instance.database;
    final result = await db.query("store", orderBy: "STORE_ID DESC");
    return result.map((e) => Store.fromMap(e)).toList();
  }

  /*          -- PRODUCT CRUD --         */
  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    return await db.insert("product", product.toMap());
  }

  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;
    final result = await db.query("product", orderBy: "PROD_ID DESC");
    return result.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return await db.update(
      "product",
      product.toMap(),
      where: "PROD_ID = ?",
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int? id) async {
    final db = await instance.database;
    return await db.delete("product", where: "PROD_ID = ?", whereArgs: [id]);
  }

  Future<List<Product>> returnProductsfromStore(int? id) async {
    final db = await instance.database;
    final result = await db.query("product", where: "STORE_ID = ?", whereArgs: [id], orderBy: "PROD_ID DESC");
    return result.map((e) => Product.fromMap(e)).toList();
  }

  Future<int?> returnStoreID(int id) async {
    final db = await instance.database;
    final result = await db.query(
      "store",
      columns: ["STORE"],
      where: "USER_ID = ?",
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first["STORE_ID"] as int;
    } else {
      return null;
    }
  }

  /*          -- PURCHASES CRUD --         */
  Future<int> createPurchases(Purchases purchases) async {
    final db = await instance.database;
    return await db.insert("product", purchases.toMap());
  }

  /*          -- TASK CRUD --         */
  Future<int> createTask(Task task) async {
    final db = await instance.database;
    return await db.insert("task", task.toMap());
  }

  Future<List<Task>> readAllTask(int? userid) async {
    final db = await instance.database;
    final result = await db.query(
      "task",
      where: "USER_ID = ?",
      whereArgs: [userid],
      orderBy: "TASK_ID DESC",
    );
    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<Task> returnTask(int? taskid) async {
    final db = await instance.database;
    final result = await db.query(
      "task",
      where: "TASK_ID = ?",
      whereArgs: [taskid],
    );
    return Task.fromMap(result.first);
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete("task", where: "TASK_ID = ?", whereArgs: [id]);
  }

  Future<int> taskMarkAsDone(int id, int userid) async {
    final db = await instance.database;
    await db.rawUpdate(
      "UPDATE user SET USER_Points = USER_Points + 500 WHERE USER_ID = ?",
      [userid]
    );
    return await db.update(
      "task",
      {"TASK_Progress": 100},
      where: "TASK_ID = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateTaskProgress(int taskId, int progress) async {
    Database db = await instance.database;
    return await db.update("task", {'TASK_Progress': progress}, where: 'TASK_ID = ?', whereArgs: [taskId]);
  }

  Future<List<Task>> getTasksByDate(int? userid, String date) async {
    final db = await instance.database;
    final result = await db.query("task", where: "USER_ID = ? AND TASK_DateFinish = ? AND TASK_Progress < 100", whereArgs: [userid, date], orderBy: "TASK_ID DESC");
    return result.map((e) => Task.fromMap(e)).toList();
  }
  
  /*          -- SUBTASK CRUD --         */
  Future<int> createSubtask(SubtTask subtask) async {
    final db = await instance.database;
    return await db.insert("subtask", subtask.toMap());
  }

  Future<List<SubtTask>> readAllSubtask(int? taskid) async {
    final db = await instance.database;
    final result = await db.query(
      "subtask",
      where: "TASK_ID = ?",
      whereArgs: [taskid],
      orderBy: "SUBTASK_ID DESC",
    );
    return result.map((e) => SubtTask.fromMap(e)).toList();
  }

  Future<int> deleteSubtask(int id) async {
    final db = await instance.database;
    return await db.delete("subtask", where: "SUBTASK_ID = ?", whereArgs: [id]);
  }

  Future<int> updateSubtask(SubtTask subtask) async {
  Database db = await instance.database;
  return await db.update("subtask", subtask.toMap(), where: 'SUBTASK_ID = ?', whereArgs: [subtask.id]);
}
}

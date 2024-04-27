import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'your_database.db';
  static final _databaseVersion = 1;

  static final loginTable = 'login_table';
  static final signupTable = 'signup_table';
  static final userTable = 'user_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnMobile = 'mobile';
  static final columnPassword = 'password';
  static final columnFullName = 'full_name'; // Add columnFullName
  static final columnEmail = 'email'; // Add columnEmail

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $loginTable (
  $columnId INTEGER PRIMARY KEY,
  $columnName TEXT NOT NULL,
  $columnMobile TEXT NOT NULL,
  $columnPassword TEXT NOT NULL
)
    ''');

    await db.execute('''
      CREATE TABLE $signupTable (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnMobile TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $userTable (
        $columnId INTEGER PRIMARY KEY,
        $columnFullName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnMobile TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertLogin(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // Ensure that the 'name' key is not included in the row before insertion
    row.remove(DatabaseHelper.columnName);
    return await db.insert(loginTable, row);
  }

  Future<int> insertSignup(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(signupTable, row);
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(userTable, row);
  }

  Future<List<Map<String, dynamic>>> queryAllLoginRows() async {
    Database db = await instance.database;
    return await db.query(loginTable);
  }

  Future<List<Map<String, dynamic>>> queryAllSignupRows() async {
    Database db = await instance.database;
    return await db.query(signupTable);
  }

  Future<List<Map<String, dynamic>>> queryAllUserRows() async {
    Database db = await instance.database;
    return await db.query(userTable);
  }

  Future<int> updateLogin(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(loginTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateSignup(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(signupTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(userTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteLogin(int id) async {
    Database db = await instance.database;
    return await db.delete(loginTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteSignup(int id) async {
    Database db = await instance.database;
    return await db.delete(signupTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(userTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<bool> authenticateUser(String mobileNumber, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      loginTable,
      where: '$columnMobile = ? AND $columnPassword = ?',
      whereArgs: [mobileNumber, password],
    );

    // If the query returns a row, authentication succeeds
    return result.isNotEmpty;
  }

  Future<bool> authenticateAdmin(String mobileNumber, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      userTable,
      where: '$columnMobile = ? AND $columnPassword = ?',
      whereArgs: [mobileNumber, password],
    );

    // If the query returns a row, authentication succeeds
    return result.isNotEmpty;
  }
}

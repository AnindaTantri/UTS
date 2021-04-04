import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Stok.dart';
import 'Deskripsi.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';

    //create, read databases
    var itemDatabase = openDatabase(path,
        version: 1, onCreate: _createDb, onUpgrade: _onUpgrade);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //update tabel
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _createDb(db, newVersion);
  }

  //buat tabel baru dengan nama stok dan deskripsi
  void _createDb(Database db, int version) async {
    var batch = db.batch();
    batch.execute('DROP TABLE IF EXISTS stok');
    batch.execute('DROP TABLE IF EXISTS deskripsi');
    batch.execute('''
      CREATE TABLE stok (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      serialnumber INTEGER,
      name TEXT,
      qty INTEGER
      )
    ''');
    batch.execute('''
      CREATE TABLE deskripsi (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      serialnumber INTEGER,
      name TEXT,
      keterangan TEXT
      )
    ''');
    await batch.commit();
  }

//select databases
  Future<List<Map<String, dynamic>>> selectStok() async {
    Database db = await this.initDb();
    var mapList = await db.query('stok',
        orderBy: 'name'); //nampilin data dari table diurutkan dengan nama
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectDeskripsi() async {
    Database db = await this.initDb();
    var mapList = await db.query('deskripsi',
        orderBy: 'name'); //nampilin data dari table diurutkan dengan nama
    return mapList;
  }

//fungsi untuk mengisi data pada tabel stok
  Future<int> insertStok(Stok object) async {
    Database db = await this.initDb();
    int count = await db.insert('stok', object.toMap());
    return count;
  }

//fungsi untuk mengisi data pada tabel deskripsi
  Future<int> insertDeskripsi(Deskripsi object) async {
    Database db = await this.initDb();
    int count = await db.insert('deskripsi', object.toMap());
    return count;
  }

//fungsi untuk update data tabel stok
  Future<int> updateStok(Stok object) async {
    Database db = await this.initDb();
    int count = await db
        .update('stok', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//fungsi untuk update data tabel deskripsi
  Future<int> updateDeskripsi(Deskripsi object) async {
    Database db = await this.initDb();
    int count = await db.update('deskripsi', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //fungsi untuk menghapus data tabel stok
  Future<int> deleteStok(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('stok', where: 'id=?', whereArgs: [id]);
    return count;
  }

//fungsi untuk menghapus data tabel deskripsi
  Future<int> deleteDeskripsi(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('deskrpsi', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //fungsi untuk mengembalikan nilai data yang baru dimasukkan
  Future<List<Stok>> getStokList() async {
    var stokMapList = await selectStok();
    int count = stokMapList.length;
    List<Stok> stokList = [];
    for (int i = 0; i < count; i++) {
      stokList.add(Stok.fromMap(stokMapList[i]));
    }
    return stokList;
  }

  Future<List<Deskripsi>> getDeskripsiList() async {
    var deskripsiMapList = await selectDeskripsi();
    int count = deskripsiMapList.length;
    List<Deskripsi> deskripsiList = [];
    for (int i = 0; i < count; i++) {
      deskripsiList.add(Deskripsi.fromMap(deskripsiMapList[i]));
    }
    return deskripsiList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}

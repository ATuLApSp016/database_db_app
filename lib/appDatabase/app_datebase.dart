import 'package:database_db_app/models/note_models.dart';
import 'package:database_db_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  /// creating singleton
  AppDatabase._();

  /// accessing the app DB class object
  static final String LOGIN_UID = 'uid';
  static final AppDatabase instance = AppDatabase._();

  ///creating global static table name and fields
  static const String NOTE_TABLE = 'note';
  static const String USER_TABLE = 'user';

  static const String NOTE_ID = 'note_id';
  static const String NOTE_TITLE = 'note_title';
  static const String NOTE_DESC = 'note_desc';
  static const String NOTE_CREATED_AT = 'note_created_at';

  static const String USER_ID = 'uid';
  static const String USER_NAME = 'uName';
  static const String USER_EMAIL = 'uEmail';
  static const String USER_NUMBER = 'uNumber';
  static const String USER_PASSWORD = 'uPassword';

  /// all the logic of database will be provided here
  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDB();
      return myDB!;
    }
  }

  Future<Database> initDB() async {
    var rootPath = await getApplicationDocumentsDirectory();
    var actualPath = join(rootPath.path, 'noteDB.db');

    return await openDatabase(actualPath, version: 1, onCreate: (db, version) {
      /// do that work which you want to execute in DB when for the first time and only time when DB is created
      /// we need to add the tables in here...
      db.execute(
          "create table $NOTE_TABLE ( $NOTE_ID integer primary key autoincrement, $USER_ID integer, $NOTE_TITLE text, $NOTE_DESC text, $NOTE_CREATED_AT text)");
      db.execute(
          "create table $USER_TABLE ( $USER_ID integer primary key autoincrement, $USER_NAME text, $USER_EMAIL text unique, $USER_NUMBER text, $USER_PASSWORD text)");
    });
  }

  /// db create
  /// table create

  /// insert data
  Future<bool> addNote(NoteModel newNote) async {
    var db = await getDB();
    var uid = await getUUID();
    newNote.userId = uid;
    var rowEffected = await db.insert(NOTE_TABLE, newNote.toMap());

    return rowEffected > 0;
  }

  /// fetch data
  Future<List<NoteModel>> fetchAllNotes() async {
    var db = await getDB();
    var uid = await getUUID();

    List<NoteModel> arrNotes = [];
    var data =
    await db.query(NOTE_TABLE, where: '$USER_ID = ?', whereArgs: ['$uid']);

    for (Map<String, dynamic> eachMap in data) {
      var eachModel = NoteModel.fromMap(eachMap);
      arrNotes.add(eachModel);
    }
    return arrNotes;
  }

  ///update the note
  Future<void> updateNote(NoteModel updatedNote) async {
    var db = await getDB();
    db.update(NOTE_TABLE, updatedNote.toMap(),
        where: '$NOTE_ID = ?', whereArgs: [updatedNote.id]);
  }

  ///delete the note
  Future<void> deleteNote(int id) async {
    var db = await getDB();
    db.delete(NOTE_TABLE, where: '$NOTE_ID = ?', whereArgs: [id]);
  }

  ///Queries for USER
  ///
  /// user signup
  Future<bool> addNewUser(UserModel newUser) async {
    var userdb = await getDB();
    bool haveAccount = await checkIfEmailAlready(newUser.uEmail);
    bool accountCreated = false;
    if (!haveAccount) {
      var rowsEffected = await userdb.insert(USER_TABLE, newUser.toMap());
      accountCreated = rowsEffected > 0;
    }
    return accountCreated;
  }

  /// user check email exists
  Future<bool> checkIfEmailAlready(String email) async {
    var db = await getDB();
    var mData = await db.query(USER_TABLE, where: '$USER_EMAIL = ?', whereArgs: [email]);
    return mData.isNotEmpty;
  }

  /// user login
  Future<bool> loginUser(String email, String pass) async {
    var userdb = await getDB();
    var mData = await userdb.query(USER_TABLE,
        where: '$USER_EMAIL = ? AND $USER_PASSWORD = ?',
        whereArgs: [email, pass]);

    if (mData.isNotEmpty) {
      setUUID(UserModel.fromMap(mData.first).uid);
    }
    return mData.isNotEmpty;
  }

  ///get UUID
  Future<int> getUUID() async {
    var perfs = await SharedPreferences.getInstance();
    return perfs.getInt('UID')!;
  }

  ///set UUID
  Future<void> setUUID(int uid) async {
    var perfs = await SharedPreferences.getInstance();
    await perfs.setInt('UID', uid);
  }
}

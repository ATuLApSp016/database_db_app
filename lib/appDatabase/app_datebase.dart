
import 'package:database_db_app/models/note_models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {


  /// creating singleton
  AppDatabase._();

  /// accessing the app DB class object
  static final AppDatabase db = AppDatabase._();

  ///creating global static table name and fields
  static const String TABLE_NOTE_NAME = 'note';
  static const String COLUMN_NOTE_ID = 'note_id';
  static const String COLUMN_NOTE_TITLE = 'note_title';
  static const String COLUMN_NOTE_DESC = 'note_desc';
  static const String COLUMN_NOTE_CREATED_AT = "note_created_at";

  /// all the logic of database will we provided here
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
          "create table $TABLE_NOTE_NAME ( $COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text, $COLUMN_NOTE_CREATED_AT text)");
    });
  }

  /// db create
  /// table create


  /// insert data
  void addNote({required NoteModel newNote}) async {
    var db = await getDB();
    db.insert(TABLE_NOTE_NAME, newNote.toMap());
  }

  /// fetch data
  Future<List<NoteModel>> fetchAllNotes() async {
    var db = await getDB();
    var data = await db.query(TABLE_NOTE_NAME);

    List<NoteModel> mData = [];

    for(Map<String, dynamic> eachMap in data) {
      var eachModel = NoteModel.fromMap(eachMap);
      mData.add(eachModel);
    }
    return mData;
  }
}
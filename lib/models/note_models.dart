import 'package:database_db_app/appDatabase/app_datebase.dart';

class NoteModel {
  int id;
  String title;
  String desc;
  String? createdAt;

  NoteModel(
      {required this.title, required this.desc, this.createdAt, this.id = 0});

  ///map to model
  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
      id: map[AppDatabase.COLUMN_NOTE_ID],
      title: map[AppDatabase.COLUMN_NOTE_TITLE],
      desc: map[AppDatabase.COLUMN_NOTE_DESC],
      createdAt: map[AppDatabase.COLUMN_NOTE_CREATED_AT]);

  ///model to map
  Map<String, dynamic> toMap() {
    return {
      AppDatabase.COLUMN_NOTE_TITLE: title,
      AppDatabase.COLUMN_NOTE_DESC: desc,
      AppDatabase.COLUMN_NOTE_CREATED_AT: createdAt,
    };
  }
}

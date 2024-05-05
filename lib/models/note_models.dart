import 'package:database_db_app/appDatabase/app_datebase.dart';

class NoteModel {
  int id;
  int userId;
  String title;
  String desc;
  String createdAt;

  NoteModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.createdAt,
  });

  ///map to model
  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
      id: map[AppDatabase.NOTE_ID],
      userId: map[AppDatabase.USER_ID],
      title: map[AppDatabase.NOTE_TITLE],
      desc: map[AppDatabase.NOTE_DESC],
      createdAt: map[AppDatabase.NOTE_CREATED_AT]);

  ///model to map
  Map<String, dynamic> toMap() {
    return {
      AppDatabase.USER_ID: userId,
      AppDatabase.NOTE_TITLE: title,
      AppDatabase.NOTE_DESC: desc,
      AppDatabase.NOTE_CREATED_AT: createdAt,
    };
  }
}

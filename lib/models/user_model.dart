import 'package:database_db_app/appDatabase/app_datebase.dart';

class UserModel {
  int uid;
  String uName;
  String uEmail;
  String uNumber;
  String uPassword;

  UserModel({
    required this.uid,
    required this.uName,
    required this.uEmail,
    required this.uNumber,
    required this.uPassword,
  });

  ///
  ///map to model

  factory UserModel.fromMap(Map<String, dynamic> userMap) => UserModel(
    uid: userMap[AppDatabase.USER_ID],
    uName: userMap[AppDatabase.USER_NAME],
    uEmail: userMap[AppDatabase.USER_EMAIL],
    uNumber: userMap[AppDatabase.USER_NUMBER],
    uPassword: userMap[AppDatabase.USER_PASSWORD],
  );

  ///
  ///model to map
  Map<String, dynamic> toMap() {
    return {
      AppDatabase.USER_NAME: uName,
      AppDatabase.USER_EMAIL: uEmail,
      AppDatabase.USER_NUMBER: uNumber,
      AppDatabase.USER_PASSWORD: uPassword,
    };
  }
}

import 'package:database_db_app/appDatabase/app_datebase.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  List<Map<String, dynamic>> mData = [];
  AppDatabase? db;

  @override
  void initState() {
    super.initState();
    db = AppDatabase.db;
    getNotes();
  }

  void getNotes() async {
    mData = await db!.fetchAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: mData.isNotEmpty
          ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(mData[index][AppDatabase.COLUMN_NOTE_TITLE]),
              subtitle: Text(mData[index][AppDatabase.COLUMN_NOTE_DESC]),
            );
          })
          : const Center(
        child: Text('No Notes yet!!'),
      ),

      /// fetch note from database
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(41)),
              context: context,
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(21),
                  child: Column(
                    children: [
                      const SizedBox(height: 11),
                      const Center(child: Text('Add Notes')),
                      const SizedBox(height: 41),
                      TextField(controller: titleController),
                      const SizedBox(height: 21),
                      TextField(controller: descController),
                      const SizedBox(height: 41),
                      OutlinedButton(
                          onPressed: () {
                            /// add note into database
                            db!.addNote(
                              title: titleController.text,
                              desc: descController.text,
                            );
                            getNotes();
                            Navigator.pop(context);
                          },
                          child: const Text('Add'))
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
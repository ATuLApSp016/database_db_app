import 'package:database_db_app/appDatabase/app_datebase.dart';
import 'package:database_db_app/models/note_models.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  List<NoteModel> mData = [];
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
                  onTap: () {},
                  leading: Text(mData[index].id.toString()),
                  title: Text(mData[index].title),
                  subtitle: Text(mData[index].desc),
                  trailing: Text(mData[index].createdAt.toString()),
                );
              })
          : const Center(
              child: Text('No Notes yet!!'),
            ),

      /// fetch note from database
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          descController.clear();
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(41),
                      topLeft: Radius.circular(41))),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                /// add note into database

                                db!.addNote(
                                    newNote: NoteModel(
                                        title: titleController.text,
                                        desc: descController.text,
                                        createdAt: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString()));
                                getNotes();
                                Navigator.pop(context);
                              },
                              child: const Text('Add')),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                        ],
                      )
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

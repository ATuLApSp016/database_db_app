import 'package:database_db_app/appDatabase/app_datebase.dart';
import 'package:database_db_app/models/note_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var dateFormat = DateFormat.MMMMEEEEd();
  List<NoteModel> mData = [];
  AppDatabase? db;

  @override
  void initState() {
    super.initState();
    db = AppDatabase.instance;
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
              itemBuilder: (_, index) {
                var time = dateFormat.format(
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(mData[index].createdAt.toString())));
                print(time);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      titleController.text = mData[index].title;
                      descController.text = mData[index].desc;
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(41)),
                          context: context,
                          builder: (_) {
                            return getBottomSheet(
                              isUpdate: true,
                              updateIndex: mData[index].id,
                              createdAt: time,
                            );
                          });

                      /*   var updateNote = NoteModel(
                          id: mData[index].id,
                          title: 'Update note',
                          desc:
                              'ububrf ed  v  wdkrfnkir nr vnfrnf krek l mfdrn fnir',
                          createdAt: mData[index].createdAt);
                      db!.updateNote(updateNote);

                      getNotes();*/
                    },
                    leading: Text('${index + 1}'),
                    title: Text(mData[index].title),
                    subtitle: Text(mData[index].desc),
                    trailing: Column(
                      children: [
                        Text(time),
                        InkWell(
                          onTap: () {
                            db!.deleteNote(mData[index].id);
                            getNotes();
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(41)),
              context: context,
              builder: (_) {
                return getBottomSheet();
              });
          /*  db!.addNote(
              newNote: NoteModel(
                  title: 'Add note',
                  desc: 'bfhifr ihwebfe ef ffh  ejffe ej9f fee9f i ffff',
                  createdAt: DateTime.now().millisecondsSinceEpoch.toString()));
          getNotes();*/
          /*   titleController.clear();
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
              });*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getBottomSheet({
    bool isUpdate = false,
    int updateIndex = -1,
    String? id,
    String? updateTitle,
    String? updateDesc,
    String? createdAt,
  }) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(41), topRight: Radius.circular(41))),
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          children: [
            const SizedBox(height: 11),
            Center(
                child: Text(
              isUpdate ? 'Update Notes' : 'Add Notes',
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
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
                      if (isUpdate) {
                        var updateNote = NoteModel(
                          id: updateIndex,
                          title: titleController.text,
                          desc: descController.text,
                          userId: updateIndex, createdAt: '',
                        );
                        db!.updateNote(updateNote);

                        getNotes();
                        Navigator.pop(context);
                      } else {
                        /// using Map
                        /// add note into database
                        db!.addNote(NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            id: 0,
                            userId: 0));

                        getNotes();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(isUpdate ? 'Update' : 'Add')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getBottomSheetWidget1() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(41), topRight: Radius.circular(41))),
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          children: [
            const SizedBox(height: 11),
            const Center(
                child: Text(
              'Add Notes',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
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
                      db!.addNote(NoteModel(
                        id: 0,
                        userId: 0,
                        title: titleController.text,
                        desc: descController.text,
                        createdAt:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                      ));
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
      ),
    );
  }

  Widget getBottomSheetWidget2() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(41), topRight: Radius.circular(41))),
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          children: [
            const SizedBox(height: 11),
            const Center(
                child: Text(
              'Update Notes',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
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
                      /// update note into database
                      var updateNote = NoteModel(
                        id: 0,
                        userId: 0,
                        title: titleController.text,
                        desc: descController.text,
                        createdAt:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                      );
                      db!.updateNote(updateNote);

                      getNotes();
                      Navigator.pop(context);
                    },
                    child: const Text('Update')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

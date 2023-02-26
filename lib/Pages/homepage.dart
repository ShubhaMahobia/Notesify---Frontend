import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesify/Models/note.dart';
import 'package:notesify/Pages/add_new_note.dart';
import 'package:notesify/Provider/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("N O T E S I F Y"),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: SafeArea(
          child: (notesProvider.notes.length > 0)
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (context, index) {
                    Note currentNote = notesProvider.notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => AddNew(
                                      isUpdate: true,
                                      note: currentNote,
                                    )));
                      },
                      onLongPress: () {
                        notesProvider.deleteNote(currentNote);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15, // soften the shadow
                              spreadRadius: 0.1, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 5  horizontally
                                5.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentNote.title!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentNote.content!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black45),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text("No Notes Yet"),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => const AddNew(isUpdate: false),
                fullscreenDialog: true),
          )
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

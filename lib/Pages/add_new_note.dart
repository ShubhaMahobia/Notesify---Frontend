import 'package:flutter/material.dart';
import 'package:notesify/Models/note.dart';
import 'package:notesify/Provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNew extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNew({super.key, required this.isUpdate, this.note});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentConrtroller = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentConrtroller.dispose();
  }

  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
      id: Uuid().v1(),
      userid: "1",
      title: titleController.text,
      content: contentConrtroller.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentConrtroller.text;
    Provider.of<NotesProvider>(context, listen: false).update(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentConrtroller.text = widget.note!.content!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                updateNote();
              } else {
                addNewNote();
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
        title: const Text("ADD NEW"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) {
                if (value != '') {
                  noteFocus.requestFocus();
                }
              },
              autofocus: (widget.isUpdate == true) ? false : true,
              style: const TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: " Title",
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentConrtroller,
                focusNode: noteFocus,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  hintText: " Note",
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

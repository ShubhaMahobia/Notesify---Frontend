import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:notesify/Models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://different-tuna-slacks.cyclic.app/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<void> delete(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decode = jsonDecode(response.body);
    log(decode.toString());
    List<Note> notes = [];

    for (var noteMap in decode) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}

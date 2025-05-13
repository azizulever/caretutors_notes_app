import 'package:get/get.dart';

class NotesController extends GetxController {
  final RxList<Map<String, String>> notes = <Map<String, String>>[].obs;

  void addNote(Map<String, String> note) {
    notes.add(note);
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }

  void editNote(int index, Map<String, String> updatedNote) {
    notes[index] = updatedNote;
  }
}

import 'package:get/get.dart';

class NotesController extends GetxController {
  final RxList<Map<String, String>> notes = <Map<String, String>>[].obs;

  void addNote(Map<String, String> note) {
    notes.add(note);
    update();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }

  void updateNote(int index, Map<String, String> note) {
    notes[index] = note;
    update();
  }
}
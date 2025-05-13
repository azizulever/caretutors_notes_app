import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotesController extends GetxController {
  final RxList<Map<String, String>> notes = <Map<String, String>>[].obs;

  void addNote(Map<String, String> note) {
    notes.add(note);
    update();
    Get.back();
    Get.snackbar(
      'Success',
      'Note added successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }

  void editNote(int index, Map<String, String> updatedNote) {
    notes[index] = updatedNote;
  }

  void updateNote(int index, Map<String, String> note) {
    notes[index] = note;
    update();
    Get.back();
    Get.snackbar(
      'Success',
      'Note updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
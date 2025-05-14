import 'package:caretutors_notes_app/features/auth/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final AuthController _authController;
  RxList<Map<String, dynamic>> notes = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  
  NotesController() {
    try {
      _authController = Get.find<AuthController>();
    } catch (e) {
      debugPrint('Error finding AuthController: $e');
      _authController = Get.put(AuthController());
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(_authController.firebaseUser, (user) {
      if (user != null) {
        fetchNotes();
      } else {
        notes.clear();
      }
    });
  }

  Future<void> fetchNotes() async {
    if (_authController.getCurrentUserId() == null) {
      debugPrint('No user logged in, skipping note fetch');
      return;
    }
    
    isLoading.value = true;
    try {
      final userId = _authController.getCurrentUserId();
      debugPrint('Fetching notes for user: $userId');
      
      if (userId == null) {
        isLoading.value = false;
        return;
      }

      _firestore
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
            final List<Map<String, dynamic>> fetchedNotes = [];
            
            for (var doc in snapshot.docs) {
              final data = doc.data() as Map<String, dynamic>;
              fetchedNotes.add({
                'id': doc.id,
                'title': data['title'] ?? 'No Title',
                'content': data['content'] ?? 'No Content',
                'createdAt': data['createdAt'],
              });
            }
            
            notes.assignAll(fetchedNotes);
            isLoading.value = false;
          }, onError: (error) {
            debugPrint('Error in note stream: $error');
            isLoading.value = false;
          });
    } catch (e) {
      debugPrint('Error setting up notes stream: $e');
      isLoading.value = false;
    }
  }

  Future<void> addNote(Map<String, String> note) async {
    try {
      final userId = _authController.getCurrentUserId();
      debugPrint('Adding note for user: $userId');
      
      if (userId == null) {
        return;
      }

      await _firestore.collection('notes').add({
        'title': note['title'],
        'content': note['content'],
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      debugPrint('Note added successfully');
    } catch (e) {
      debugPrint('Error adding note: $e');
    }
  }

  Future<void> updateNote(int index, Map<String, String> updatedNote) async {
    try {
      if (index >= notes.length) {
        return;
      }
      
      final userId = _authController.getCurrentUserId();
      final noteId = notes[index]['id'];
      
      if (userId == null) {
        return;
      }

      await _firestore
          .collection('notes')
          .doc(noteId)
          .update({
        'title': updatedNote['title'],
        'content': updatedNote['content'],
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      debugPrint('Note updated successfully');
    } catch (e) {
      debugPrint('Error updating note: $e');
    }
  }

  Future<void> deleteNote(int index) async {
    try {
      if (index >= notes.length) {
        return;
      }
      
      final noteId = notes[index]['id'];
      
      await _firestore
          .collection('notes')
          .doc(noteId)
          .delete();
      
      debugPrint('Note deleted successfully');
    } catch (e) {
      debugPrint('Error deleting note: $e');
    }
  }
  
  @override
  void onClose() {
    super.onClose();
  }
}
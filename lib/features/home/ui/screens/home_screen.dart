import 'package:caretutors_notes_app/app/app_colors.dart';
import 'package:caretutors_notes_app/features/home/controllers/notes_controller.dart';
import 'package:caretutors_notes_app/features/home/ui/screens/add_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesController notesController = Get.put(NotesController());
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Caretutors Notes App',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.themeColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            notesController.notes.isEmpty
                ? const Center(child: Text('No notes added yet.'))
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notesController.notes.length,
                  itemBuilder: (context, index) {
                    final note = notesController.notes[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: Text(
                          note['title']!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(note['content']!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.themeColor,
                              ),
                              onPressed: () {
                                Get.to(
                                  () => AddNotesScreen(
                                    isEditing: true,
                                    noteIndex: index,
                                    initialTitle: note['title'],
                                    initialContent: note['content'],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                notesController.deleteNote(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 350,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddNotesScreen());
          },
          child: Text('Add Note', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.themeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

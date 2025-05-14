import 'package:caretutors_notes_app/app/app_colors.dart';
import 'package:caretutors_notes_app/app/routes/app_routes.dart';
import 'package:caretutors_notes_app/features/auth/controllers/auth_controller.dart';
import 'package:caretutors_notes_app/features/home/controllers/notes_controller.dart' as notes;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late notes.NotesController notesController;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
    
    if (!Get.isRegistered(tag: 'notesController')) {
      notesController = Get.put(notes.NotesController(), tag: 'notesController');
    } else {
      notesController = Get.find<notes.NotesController>(tag: 'notesController');
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController.fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.themeColor),
            onPressed: () async {
              await authController.signOut();
              if (context.mounted) {
                context.go(AppRoutes.signIn);
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => notesController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : notesController.notes.isEmpty
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
                            note['title'] ?? 'No title',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(note['content'] ?? 'No content'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.themeColor,
                                ),
                                onPressed: () {
                                  context.go(
                                    AppRoutes.editNote,
                                    extra: {
                                      'noteIndex': index,
                                      'title': note['title'],
                                      'content': note['content'],
                                    },
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
            context.go(AppRoutes.addNote);
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

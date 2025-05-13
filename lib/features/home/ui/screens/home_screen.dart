import 'package:caretutors_notes_app/app/app_colors.dart';
import 'package:caretutors_notes_app/features/home/ui/screens/add_notes_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> notes = [];

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
      ),
      body:
          notes.isEmpty
              ? const Center(child: Text('No notes added yet.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
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
                            icon: Icon(Icons.edit, color: AppColors.themeColor),
                            onPressed: () {
                              // TODO: Implement edit functionality
                              print('Edit note at index $index');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteNote(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 350,
        child: FloatingActionButton(
          onPressed: () async {
            final newNote = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNotesScreen()),
            );

            if (newNote != null && mounted) {
              setState(() {
                notes.add(Map<String, String>.from(newNote));
              });
            }
          },
          child: Text('Add Note', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.themeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }
}

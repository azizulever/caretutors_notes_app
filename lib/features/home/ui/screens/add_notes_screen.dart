import 'package:caretutors_notes_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new note',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColors.themeColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 42),
                TextFormField(
                  controller: _titleTEController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final note = {
                          'title': _titleTEController.text,
                          'content': _descriptionTEController.text,
                        };
                        Navigator.pop(context, note);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_downward_sharp,
                      color: Colors.white,
                    ),
                    // child: Text('SignIn'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:caretutors_notes_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
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
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(24))),
    );
  }
}

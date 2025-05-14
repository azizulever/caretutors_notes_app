import 'package:caretutors_notes_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CaretutorsNotes extends StatelessWidget {
  const CaretutorsNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Caretutors Notes',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

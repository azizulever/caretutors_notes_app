import 'package:caretutors_notes_app/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaretutorsNotes extends StatelessWidget {
  const CaretutorsNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: SplashScreen());
  }
}

import 'package:caretutors_notes_app/app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaretutorsNotes extends StatelessWidget {
  const CaretutorsNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Caretutors Notes',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.keepFactory,
    );
  }
}

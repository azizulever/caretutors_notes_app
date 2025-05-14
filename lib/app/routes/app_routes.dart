import 'package:caretutors_notes_app/app/splash_screen.dart';
import 'package:caretutors_notes_app/features/auth/ui/screens/sign_in_screen.dart';
import 'package:caretutors_notes_app/features/auth/ui/screens/sign_up_screen.dart';
import 'package:caretutors_notes_app/features/home/ui/screens/add_notes_screen.dart';
import 'package:caretutors_notes_app/features/home/ui/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String addNote = '/add-note';
  static const String editNote = '/edit-note';
}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.addNote,
      builder: (context, state) => const AddNotesScreen(),
    ),
    GoRoute(
      path: AppRoutes.editNote,
      builder: (context, state) {
        final Map<String, dynamic>? extra =
            state.extra as Map<String, dynamic>?;

        if (extra == null) {
          return const AddNotesScreen();
        }

        return AddNotesScreen(
          isEditing: true,
          noteIndex: extra['noteIndex'] as int,
          initialTitle: extra['title'] as String,
          initialContent: extra['content'] as String,
        );
      },
    ),
  ],
);

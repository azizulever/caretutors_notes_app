import 'package:caretutors_notes_app/app/app_colors.dart';
import 'package:caretutors_notes_app/app/routes/app_routes.dart';
import 'package:caretutors_notes_app/features/auth/controllers/auth_controller.dart';
import 'package:caretutors_notes_app/features/auth/ui/screens/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              Text(
                'Registration',
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'First name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: lastNameTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Last name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: emailTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: passwordTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        if (value!.length <= 6) {
                          return 'Enter a password which is more than 5 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: confirmPasswordTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        if (value!.length <= 6) {
                          return 'Enter a password which is more than 5 characters';
                        }
                        if (value != passwordTEController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Obx(() => SizedBox(
                          width: double.infinity,
                          height: 36,
                          child: ElevatedButton(
                            onPressed: _authController.isLoading.value
                                ? null
                                : _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.themeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _authController.isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                          ),
                        )),
                    SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        text: "Already have an Account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: const TextStyle(color: AppColors.themeColor),
                            recognizer:
                                TapGestureRecognizer()..onTap = _onTapSignUp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String? error = await _authController.signUp(
        email: emailTEController.text.trim(),
        password: passwordTEController.text.trim(),
        firstName: firstNameTEController.text.trim(),
        lastName: lastNameTEController.text.trim(),
      );

      if (error != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        if (context.mounted) {
          context.go(AppRoutes.signIn);
        }
      }
    }
  }

  void _onTapSignUp() {
    context.go(AppRoutes.signIn);
  }
}

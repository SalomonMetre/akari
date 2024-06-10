import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/routing.dart';
import 'package:flutter/material.dart';
import 'package:akari/constants/app_colors.dart';
import '../models/auth_model.dart'; // Import your Auth model
import '../models/db_model.dart'; 

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Sign In'),
        backgroundColor: AppColors.blue2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    // Validate the email and password
                    if (email.isNotEmpty && password.isNotEmpty) {
                      try {
                        // Sign in user
                        await Auth.instance.loginUser(email: email, password: password);
                        // Check if email is verified
                        bool isEmailVerified = Auth()
                                .firebaseAuthInstance
                                .currentUser
                                ?.emailVerified ??
                            false;
                        if (!isEmailVerified) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please verify your email before signing in.'),
                            ),
                          );
                          return;
                        }
                        // Unlock game 1 for all difficulty levels
                        await unlockGame1ForAllDifficulties(email);
                        // Show success message or navigate to a success page
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('You have successfully signed in.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Navigate to home page or any other page
                                  goToNamed(context, destination: RouteNames.homePage);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        // Show error message if sign-in fails
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Error'),
                            content: Text('Failed to sign in: $e'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to sign-up page
                    goToNamed(context, destination: RouteNames.signUpPage, push: true);
                  },
                  child: const Text('Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> unlockGame1ForAllDifficulties(String email) async {
    try {
      // Unlock game 1 for each difficulty level
      await DbModel.instance.save(
        // documentId: Auth().firebaseAuthInstance.currentUser?.email,
        collectionName: "unlocked_games",
        data: {
          "user_email": email,
          "difficulty": "Easy", // You can change this to match your difficulty levels
          "game_no": 1,
        },
      );
      await DbModel.instance.save(
        collectionName: "unlocked_games",
        data: {
          "user_email": email,
          "difficulty": "Medium", // You can change this to match your difficulty levels
          "game_no": 1,
        },
      );
      await DbModel.instance.save(
        collectionName: "unlocked_games",
        data: {
          "user_email": email,
          "difficulty": "Hard", // You can change this to match your difficulty levels
          "game_no": 1,
        },
      );
      // Add more difficulty levels if needed
    } catch (e) {
      print("Error unlocking game 1 for all difficulties: $e");
    }
  }
}

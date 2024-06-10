import 'package:akari/constants/route_names.dart';
import 'package:akari/functions/routing.dart';
import 'package:flutter/material.dart';
import 'package:akari/constants/app_colors.dart';
import '../models/auth_model.dart'; // Import your Auth model

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Auth _auth = Auth(); // Initialize your Auth instance
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.white,
        title: const Text('Sign Up'),
        backgroundColor: AppColors.blue2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        // Toggle password visibility
                        setState(() {
                          _isObscurePassword = !_isObscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscurePassword, // Toggle visibility based on state
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        // Toggle password visibility
                        setState(() {
                          _isObscureConfirmPassword = !_isObscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscureConfirmPassword, // Toggle visibility based on state
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text.trim()) {
                      return 'Passwords do not match';
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
                        // Create user account
                        await _auth.registerUser(email: email, password: password);
                        // Send verification email
                        await _auth.sendVerificationEmail();
                        // Show success message or navigate to a success page
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Please check your email to verify your account.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Navigate to login page or any other page
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        // Show error message if signup fails
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Error'),
                            content: Text('Failed to sign up: $e'),
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
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to sign-in page
                    goToNamed(context, destination: RouteNames.signInPage, push: true);
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

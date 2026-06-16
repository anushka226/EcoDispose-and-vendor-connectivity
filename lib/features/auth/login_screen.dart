import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_screen.dart';
import '../user_dashboard/user_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email: emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const UserDashboardScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message = "Login Failed";

      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      }

      else if (e.code == 'wrong-password') {
        message = 'Wrong password';
      }

      else if (e.code == 'invalid-email') {
        message = 'Invalid email';
      }

      else if (e.code == 'invalid-credential') {
        message = 'Wrong email or password';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F8F2),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              IconButton(

                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 10),

              const Text(

                "User Login",

                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                "Login to continue recycling smarter.",

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 50),

              _buildField(
                "Email",
                Icons.email,
                emailController,
              ),

              const SizedBox(height: 20),

              _buildField(
                "Password",
                Icons.lock,
                passwordController,
                isPassword: true,
              ),

              const SizedBox(height: 35),

              SizedBox(

                width: double.infinity,
                height: 60,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  onPressed: isLoading
                      ? null
                      : loginUser,

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                      : const Text(

                    "Login",

                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(

                child: TextButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                        const RegisterScreen(),
                      ),
                    );
                  },

                  child: const Text(

                    "Create New Account",

                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
      String hint,
      IconData icon,
      TextEditingController controller, {
        bool isPassword = false,
      }) {

    return TextField(

      controller: controller,

      obscureText: isPassword,

      decoration: InputDecoration(

        prefixIcon: Icon(icon),

        hintText: hint,

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
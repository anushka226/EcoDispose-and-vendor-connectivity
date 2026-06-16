import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final TextEditingController fullNameController =
  TextEditingController();

  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> createAccount() async {

    if (fullNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      // =========================
      // FIREBASE AUTH CREATE
      // =========================

      UserCredential userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(

        email: emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      // =========================
      // FIRESTORE SAVE
      // =========================

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({

        'name':
        fullNameController.text.trim(),

        'username':
        usernameController.text.trim(),

        'email':
        emailController.text.trim(),

        'phone':
        phoneController.text.trim(),

        'role': 'user',

        'createdAt':
        FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            "Account Created Successfully",
          ),
        ),
      );

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      String errorMessage =
          e.message ?? "Authentication Error";

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(errorMessage),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
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

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              IconButton(

                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 15),

              const Text(

                "Create Account",

                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                "Join EcoRecycle and start smart recycling.",

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              buildTextField(

                controller: fullNameController,

                hint: "Full Name",

                icon: Icons.person,
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: usernameController,

                hint: "Username",

                icon: Icons.alternate_email,
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: emailController,

                hint: "Email",

                icon: Icons.email,
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: phoneController,

                hint: "Phone Number",

                icon: Icons.phone,
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: passwordController,

                hint: "Password",

                icon: Icons.lock,

                isPassword: true,
              ),

              const SizedBox(height: 35),

              SizedBox(

                width: double.infinity,

                height: 58,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                    const Color(0xFF34A853),

                    shape: RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                  ),

                  onPressed:
                  isLoading ? null : createAccount,

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                      : const Text(

                    "Create Account",

                    style: TextStyle(

                      fontSize: 18,

                      color: Colors.white,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Center(

                child: GestureDetector(

                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: const Text(

                    "Already have an account? Login",

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

  Widget buildTextField({

    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool isPassword = false,
  }) {

    return Container(

      padding:
      const EdgeInsets.symmetric(horizontal: 18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),

      child: TextField(

        controller: controller,

        obscureText: isPassword,

        decoration: InputDecoration(

          border: InputBorder.none,

          hintText: hint,

          icon: Icon(icon),
        ),
      ),
    );
  }
}
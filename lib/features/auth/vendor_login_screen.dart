import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'vendor_register_screen.dart';
import '../vendor_dashboard/vendor_dashboard_screen.dart';

class VendorLoginScreen extends StatefulWidget {

  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() =>
      _VendorLoginScreenState();
}

class _VendorLoginScreenState
    extends State<VendorLoginScreen> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> loginVendor() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {

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

      UserCredential userCredential =

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email: emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      final uid =
          userCredential.user!.uid;

      final vendorDoc =

      await FirebaseFirestore.instance
          .collection('vendors')
          .doc(uid)
          .get();

      if (!vendorDoc.exists) {

        await FirebaseAuth.instance.signOut();

        throw "This account is not registered as vendor";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Vendor Login Successful",
          ),

          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const VendorDashboardScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message =
          "Vendor Login Failed";

      if (e.code == 'user-not-found') {

        message =
        "No vendor found with this email";

      } else if (e.code ==
          'wrong-password') {

        message = "Wrong password";

      } else if (e.code ==
          'invalid-email') {

        message = "Invalid email";

      } else if (e.code ==
          'invalid-credential') {

        message =
        "Wrong email or password";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(message),

          backgroundColor: Colors.red,
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

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

      backgroundColor:
      const Color(0xFFF4F8F2),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              IconButton(

                onPressed: () {
                  Navigator.pop(context);
                },

                icon:
                const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 10),

              const Text(

                "Vendor Login",

                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                "Login to manage recycling pickups.",

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

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    Colors.green,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),

                  onPressed:
                  isLoading
                      ? null
                      : loginVendor,

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                      : const Text(

                    "Login",

                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight:
                      FontWeight.bold,
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

                        const VendorRegisterScreen(),
                      ),
                    );
                  },

                  child: const Text(

                    "Create Vendor Account",

                    style: TextStyle(
                      color: Colors.green,
                      fontWeight:
                      FontWeight.bold,
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

          borderRadius:
          BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
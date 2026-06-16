
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorRegisterScreen extends StatefulWidget {

  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() =>
      _VendorRegisterScreenState();
}

class _VendorRegisterScreenState
    extends State<VendorRegisterScreen> {

  final companyController =
  TextEditingController();

  final vendorNameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> registerVendor() async {

    if (companyController.text.isEmpty ||
        vendorNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
          Text("Please fill all fields"),
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
          .createUserWithEmailAndPassword(

        email: emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('vendors')
          .doc(userCredential.user!.uid)
          .set({

        'companyName':
        companyController.text.trim(),

        'vendorName':
        vendorNameController.text.trim(),

        'email':
        emailController.text.trim(),

        'phone':
        phoneController.text.trim(),

        'role': 'vendor',

        'createdAt':
        FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Vendor Account Created Successfully",
          ),

          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
          Text(e.message ?? "Error"),
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

                "Vendor Registration",

                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              buildField(
                companyController,
                "Company Name",
                Icons.business,
              ),

              const SizedBox(height: 18),

              buildField(
                vendorNameController,
                "Vendor Name",
                Icons.person,
              ),

              const SizedBox(height: 18),

              buildField(
                emailController,
                "Email",
                Icons.email,
              ),

              const SizedBox(height: 18),

              buildField(
                phoneController,
                "Phone Number",
                Icons.phone,
              ),

              const SizedBox(height: 18),

              buildField(
                passwordController,
                "Password",
                Icons.lock,
                isPassword: true,
              ),

              const SizedBox(height: 35),

              SizedBox(

                width: double.infinity,

                height: 58,

                child: ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    Colors.green,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed:
                  isLoading
                      ? null
                      : registerVendor,

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                      : const Text(

                    "Create Vendor Account",

                    style: TextStyle(

                      fontSize: 18,

                      color: Colors.white,

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

  Widget buildField(

      TextEditingController controller,
      String hint,
      IconData icon, {

        bool isPassword = false,
      }) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        horizontal: 18,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

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

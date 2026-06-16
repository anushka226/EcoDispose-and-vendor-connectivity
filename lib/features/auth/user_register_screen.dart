import 'package:flutter/material.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

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
                "Create Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              _field("Full Name", Icons.person),

              const SizedBox(height: 18),

              _field("Username", Icons.alternate_email),

              const SizedBox(height: 18),

              _field("Email", Icons.email),

              const SizedBox(height: 18),

              _field("Phone Number", Icons.phone),

              const SizedBox(height: 18),

              _field(
                "Password",
                Icons.lock,
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

                  onPressed: () {

                  },

                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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

  Widget _field(
      String hint,
      IconData icon, {
        bool isPassword = false,
      }) {

    return TextField(
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
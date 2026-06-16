import 'package:flutter/material.dart';

import 'login_screen.dart';

class RoleSelectionScreen
    extends StatelessWidget {

  const RoleSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Select Role",
        ),
      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>
                        const LoginScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "User",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>
                        const LoginScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "Vendor",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/selection_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: FutureBuilder<DocumentSnapshot>(

        future: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              !snapshot.data!.exists) {

            return const Center(
              child: Text("No User Data Found"),
            );
          }

          final data =
          snapshot.data!.data()
          as Map<String, dynamic>;

          return Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 20),

                Center(

                  child: CircleAvatar(

                    radius: 45,

                    backgroundColor:
                    Colors.green.shade200,

                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                profileTile(
                  "Full Name",
                  data['name'] ?? '',
                ),

                profileTile(
                  "Username",
                  data['username'] ?? '',
                ),

                profileTile(
                  "Email",
                  data['email'] ?? '',
                ),

                profileTile(
                  "Phone",
                  data['phone'] ?? '',
                ),

                profileTile(
                  "Role",
                  data['role'] ?? '',
                ),

                const SizedBox(height: 35),

                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: () async {

                      await FirebaseAuth.instance
                          .signOut();

                      if (!context.mounted) return;

                      Navigator.pushAndRemoveUntil(

                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const SelectionScreen(),
                        ),

                            (route) => false,
                      );
                    },

                    child: const Text(

                      "Logout",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget profileTile(
      String title,
      String value,
      ) {

    return Container(

      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(value),
        ],
      ),
    );
  }
}
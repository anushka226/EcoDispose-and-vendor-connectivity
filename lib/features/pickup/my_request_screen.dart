import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Requests"),
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection('pickup_requests')
            .where('userId', isEqualTo: user!.uid)
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(

            itemCount: docs.length,

            itemBuilder: (context, index) {

              final data = docs[index];

              return ListTile(

                title: Text(data['wasteType']),

                subtitle: Text(data['vendorReply']),

                trailing: Text(
                  data['status'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
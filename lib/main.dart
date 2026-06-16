import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

import 'features/auth/selection_screen.dart';

import 'features/user_dashboard/user_dashboard_screen.dart';

import 'features/vendor_dashboard/vendor_dashboard_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  Future<Widget> getStartScreen() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {

      return const SelectionScreen();
    }

    // CHECK USERS COLLECTION

    final userDoc =

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {

      return const UserDashboardScreen();
    }

    // CHECK VENDORS COLLECTION

    final vendorDoc =

    await FirebaseFirestore.instance
        .collection('vendors')
        .doc(user.uid)
        .get();

    if (vendorDoc.exists) {

      return const VendorDashboardScreen();
    }

    return const SelectionScreen();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: FutureBuilder<Widget>(

        future: getStartScreen(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Scaffold(

              body: Center(
                child:
                CircularProgressIndicator(),
              ),
            );
          }

          return snapshot.data!;
        },
      ),
    );
  }
}
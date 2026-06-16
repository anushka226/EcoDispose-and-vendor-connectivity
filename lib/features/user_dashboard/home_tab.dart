import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F8F2),

      appBar: AppBar(

        backgroundColor: Colors.transparent,

        elevation: 0,

        title: const Text(
          "EcoRecycle",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(18),

        child: Column(

          children: [

            dashboardCard(
              "Items Recycled",
              "12",
              Colors.green,
            ),

            dashboardCard(
              "CO2 Saved",
              "45 kg",
              Colors.teal,
            ),

            dashboardCard(
              "Earnings",
              "₹1250",
              Colors.orange,
            ),

            const SizedBox(height: 20),

            actionButton(
              "Scan Item",
              Icons.camera_alt,
              Colors.green,
            ),

            const SizedBox(height: 15),

            actionButton(
              "Find Vendors",
              Icons.location_on,
              Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
      String title,
      String value,
      Color color,
      ) {

    return Container(

      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(title),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          LinearProgressIndicator(
            value: 0.7,
            color: color,
          ),
        ],
      ),
    );
  }

  Widget actionButton(
      String text,
      IconData icon,
      Color color,
      ) {

    return Container(

      width: double.infinity,

      height: 65,

      decoration: BoxDecoration(

        color: color,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(icon),

          const SizedBox(width: 10),

          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
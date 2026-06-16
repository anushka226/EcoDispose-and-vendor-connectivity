import 'package:flutter/material.dart';
import '../ml/waste_detection_screen.dart';

class ScanTab extends StatelessWidget {
  const ScanTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F8F2),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  IconButton(

                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back),
                  ),

                  const SizedBox(width: 10),

                  const Text(

                    "EcoRecycle",

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _buildCard(
                title: "Items Recycled",
                value: "12",
                color: Colors.lightGreen,
              ),

              const SizedBox(height: 25),

              _buildCard(
                title: "CO2 Saved",
                value: "45 kg",
                color: Colors.teal,
              ),

              const SizedBox(height: 25),

              _buildCard(
                title: "Earnings",
                value: "₹1250",
                color: Colors.orange,
              ),

              const SizedBox(height: 40),

              SizedBox(

                width: double.infinity,
                height: 60,

                child: ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.lightGreen,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: () {

                    print("BUTTON WORKING");

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                        const WasteDetectionScreen(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),

                  label: const Text(

                    "Scan Item",

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(

                width: double.infinity,
                height: 55,

                child: OutlinedButton.icon(

                  onPressed: () {},

                  icon: const Icon(Icons.location_on),

                  label: const Text(
                    "Find Vendors",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({

    required String title,
    required String value,
    required Color color,
  }) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 12),

          Text(

            value,

            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: 0.7,
            color: color,
            backgroundColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
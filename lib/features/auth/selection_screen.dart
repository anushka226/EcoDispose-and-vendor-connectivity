import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'vendor_login_screen.dart' hide LoginScreen;

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F2),

      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // =========================
                // LOGO
                // =========================

                Row(
                  children: [

                    Container(
                      height: 55,
                      width: 55,

                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.eco,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Text(
                        "EcoDispose",

                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // =========================
                // HEADING
                // =========================

                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),

                    children: [

                      TextSpan(
                        text: "Bridging\n",
                        style: TextStyle(color: Colors.black),
                      ),

                      TextSpan(
                        text: "Advanced AI\n",
                        style: TextStyle(color: Colors.green),
                      ),

                      TextSpan(
                        text: "with Global\nSustainability.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "A sophisticated ecosystem designed for smart recycling, AI waste detection and vendor management.",

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 45),

                // =========================
                // USER BUTTON
                // =========================

                GestureDetector(

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const LoginScreen(),
                      ),
                    );
                  },

                  child: Container(

                    width: double.infinity,
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2E7D32),
                          Color(0xFF66BB6A),
                        ],
                      ),

                      borderRadius: BorderRadius.circular(28),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "I want to Recycle",

                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Join the consumer movement",

                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 34,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =========================
                // VENDOR BUTTON
                // =========================

                GestureDetector(

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const VendorLoginScreen(),
                      ),
                    );
                  },

                  child: Container(

                    width: double.infinity,
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF9800),
                          Color(0xFFFFB74D),
                        ],
                      ),

                      borderRadius: BorderRadius.circular(28),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "I am a Vendor",

                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Industrial recycling solutions",

                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.business_center,
                          color: Colors.black,
                          size: 34,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // =========================
                // TRUST TEXT
                // =========================

                Row(
                  children: [

                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.green.shade100,

                      child: const Icon(
                        Icons.person,
                        color: Colors.green,
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 10),

                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.orange.shade100,

                      child: const Icon(
                        Icons.recycling,
                        color: Colors.orange,
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Expanded(
                      child: Text(
                        "Trusted by 12,000+ global eco-stewards.",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // =========================
                // AI CARD
                // =========================

                Container(

                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Column(
                      children: [

                        Container(
                          height: 220,

                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(24),

                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/recycle_ai.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Container(
                              padding: const EdgeInsets.all(12),

                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius:
                                BorderRadius.circular(14),
                              ),

                              child: const Icon(
                                Icons.bolt,
                                color: Colors.green,
                              ),
                            ),

                            const SizedBox(width: 16),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    "AI Insight Active",

                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 6),

                                  Text(
                                    "Analyzing optimal recycling routes and vendor matching in real-time.",

                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
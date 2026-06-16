import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListingsTab extends StatelessWidget {
  const ListingsTab({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor: const Color(0xFFF4F8F2),

      appBar: AppBar(

        backgroundColor: Colors.transparent,

        elevation: 0,

        title: const Text(
          "My Recycling Requests",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection('pickup_requests')
            .where('userId', isEqualTo: user!.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {

            return const Center(
              child: Text(
                "No Recycling Requests Yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: docs.length,

            itemBuilder: (context, index) {

              final data = docs[index];

              return Container(

                margin: const EdgeInsets.only(bottom: 22),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Padding(

                  padding: const EdgeInsets.all(18),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Row(

                        children: [

                          Container(

                            padding: const EdgeInsets.all(10),

                            decoration: BoxDecoration(

                              color: Colors.green.shade100,

                              borderRadius:
                              BorderRadius.circular(14),
                            ),

                            child: const Icon(
                              Icons.recycling,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  data['wasteType'] ?? '',

                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "Confidence: ${data['confidence']}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      buildInfoRow(
                        "Waste Type",
                        data['wasteType'],
                      ),

                      buildInfoRow(
                        "Condition",
                        data['condition'],
                      ),

                      buildInfoRow(
                        "Recyclability",
                        data['recyclabilityScore'],
                      ),

                      buildInfoRow(
                        "Estimated Price",
                        data['estimatedPrice'],
                      ),

                      buildInfoRow(
                        "Status",
                        data['status'],
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        "Recyclable Parts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        data['recyclableParts'],
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        "Non-Recyclable Parts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        data['nonRecyclableParts'],
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(

                        width: double.infinity,

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(

                          color: Colors.green.shade50,

                          borderRadius:
                          BorderRadius.circular(18),
                        ),

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Vendor Response",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              data['vendorReply'],
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildInfoRow(
      String title,
      String value,
      ) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 12),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/selection_screen.dart';

class VendorRequestsScreen
    extends StatelessWidget {

  const VendorRequestsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF4F8F2),

      appBar: AppBar(

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        title: const Text(

          "Vendor Pickup Requests",

          style: TextStyle(
            color: Colors.black,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(

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

            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance

            .collection('pickup_requests')

            .orderBy(
          'createdAt',
          descending: true,
        )

            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {

            return const Center(

              child: Text(

                "No Pickup Requests",

                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          final requests =
              snapshot.data!.docs;

          return ListView.builder(

            padding:
            const EdgeInsets.all(16),

            itemCount: requests.length,

            itemBuilder:
                (context, index) {

              final data =

              requests[index].data()

              as Map<String, dynamic>;

              return Container(

                margin:
                const EdgeInsets.only(
                  bottom: 20,
                ),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color: Colors.black
                          .withOpacity(
                        0.06,
                      ),

                      blurRadius: 12,

                      offset:
                      const Offset(
                        0,
                        4,
                      ),
                    ),
                  ],
                ),

                child: Padding(

                  padding:
                  const EdgeInsets.all(
                    18,
                  ),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      Row(

                        children: [

                          Container(

                            padding:
                            const EdgeInsets
                                .all(12),

                            decoration:
                            BoxDecoration(

                              color: Colors
                                  .green
                                  .shade100,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                14,
                              ),
                            ),

                            child:
                            const Icon(

                              Icons
                                  .recycling,

                              color:
                              Colors.green,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                Text(

                                  data[
                                  'wasteType']
                                      ??
                                      'N/A',

                                  style:
                                  const TextStyle(

                                    fontSize:
                                    24,

                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(

                                  data[
                                  'userEmail']
                                      ??
                                      'N/A',

                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      buildInfo(
                        "Confidence",
                        data['confidence']
                            ??
                            'N/A',
                      ),

                      buildInfo(
                        "Condition",
                        data['condition']
                            ??
                            'N/A',
                      ),

                      buildInfo(
                        "Recyclability",
                        data[
                        'recyclabilityScore']
                            ??
                            'N/A',
                      ),

                      buildInfo(
                        "Estimated Price",
                        data[
                        'estimatedPrice']
                            ??
                            'N/A',
                      ),

                      buildInfo(
                        "Status",
                        data['status']
                            ??
                            'N/A',
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      const Text(

                        "Recyclable Parts",

                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(

                        data[
                        'recyclableParts']
                            ??
                            'N/A',
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      const Text(

                        "Non-Recyclable Parts",

                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(

                        data[
                        'nonRecyclableParts']
                            ??
                            'N/A',
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      Row(

                        children: [

                          Expanded(

                            child:
                            ElevatedButton(

                              style:
                              ElevatedButton
                                  .styleFrom(

                                backgroundColor:
                                Colors.green,

                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  vertical:
                                  15,
                                ),
                              ),

                              onPressed: () {

                                FirebaseFirestore
                                    .instance

                                    .collection(
                                  'pickup_requests',
                                )

                                    .doc(
                                  requests[index]
                                      .id,
                                )

                                    .update({

                                  'status':
                                  'approved',

                                  'vendorReply':
                                  'Pickup Approved',
                                });
                              },

                              child:
                              const Text(

                                "Approve",

                                style:
                                TextStyle(

                                  color:
                                  Colors.white,

                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          Expanded(

                            child:
                            ElevatedButton(

                              style:
                              ElevatedButton
                                  .styleFrom(

                                backgroundColor:
                                Colors.red,

                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  vertical:
                                  15,
                                ),
                              ),

                              onPressed: () {

                                FirebaseFirestore
                                    .instance

                                    .collection(
                                  'pickup_requests',
                                )

                                    .doc(
                                  requests[index]
                                      .id,
                                )

                                    .update({

                                  'status':
                                  'rejected',

                                  'vendorReply':
                                  'Pickup Rejected',
                                });
                              },

                              child:
                              const Text(

                                "Reject",

                                style:
                                TextStyle(

                                  color:
                                  Colors.white,

                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget buildInfo(
      String title,
      String value,
      ) {

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

        children: [

          Text(

            title,

            style: const TextStyle(

              color: Colors.grey,

              fontWeight:
              FontWeight.w600,
            ),
          ),

          Text(

            value,

            style: const TextStyle(
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
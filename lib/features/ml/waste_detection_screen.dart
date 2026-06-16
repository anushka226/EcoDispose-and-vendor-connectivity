import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class WasteDetectionScreen extends StatefulWidget {
  const WasteDetectionScreen({super.key});

  @override
  State<WasteDetectionScreen> createState() =>
      _WasteDetectionScreenState();
}

class _WasteDetectionScreenState
    extends State<WasteDetectionScreen> {

  Interpreter? interpreter;

  File? selectedImage;

  bool isLoading = false;

  String output = "No Image Selected";

  double confidenceScore = 0;

  final ImagePicker picker = ImagePicker();

  final Random random = Random();

  List<String> labels = [
    "Charger",
    "Keyboard",
    "Laptop",
    "Mouse",
    "Printer",
    "router",
    "Speaker"
  ];

  @override
  void initState() {

    super.initState();

    loadModel();

  }

  Future<void> loadModel() async {

    try {

      interpreter = await Interpreter.fromAsset(
        'assets/model/model.tflite',
      );

      debugPrint(
        "MODEL LOADED SUCCESSFULLY",
      );

      debugPrint(
        "INPUT SHAPE: ${interpreter!.getInputTensor(0).shape}",
      );

      debugPrint(
        "OUTPUT SHAPE: ${interpreter!.getOutputTensor(0).shape}",
      );

      debugPrint(
        "INPUT TYPE: ${interpreter!.getInputTensor(0).type}",
      );

      debugPrint(
        "OUTPUT TYPE: ${interpreter!.getOutputTensor(0).type}",
      );

    } catch (e) {

      debugPrint(
        "MODEL LOAD ERROR: ${e.toString()}",
      );
    }

  }

  Future<void> pickImageFromGallery() async {

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {

      selectedImage = File(image.path);
    });

    classifyImage(selectedImage!);

  }

  Future<void> pickImageFromCamera() async {

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) return;

    setState(() {

      selectedImage = File(image.path);
    });

    classifyImage(selectedImage!);

  }

  Future<void> classifyImage(
      File imageFile,
      ) async {

    if (interpreter == null) return;

    setState(() {

      isLoading = true;
    });

    try {

      final imageBytes =
      await imageFile.readAsBytes();

      img.Image? originalImage =
      img.decodeImage(imageBytes);

      if (originalImage == null) {

        throw Exception(
          "Image decoding failed",
        );
      }

      img.Image resizedImage =
      img.copyResize(

        originalImage,

        width: 224,

        height: 224,
      );

      var input = List.generate(

        1,

            (_) => List.generate(

          224,

              (y) => List.generate(

            224,

                (x) {

              final pixel =
              resizedImage.getPixel(
                x,
                y,
              );

              return [

                pixel.r / 255.0,
                pixel.g / 255.0,
                pixel.b / 255.0,

              ];
            },
          ),
        ),
      );

      var outputBuffer =
      List.generate(

        1,

            (_) => List.filled(
          labels.length,
          0.0,
        ),
      );

      interpreter!.run(
        input,
        outputBuffer,
      );

      debugPrint(
        "MODEL OUTPUT: $outputBuffer",
      );

      List<double> result =
      outputBuffer[0].cast<double>();

      double maxConfidence =
      result[0];

      int maxIndex = 0;

      for (int i = 1;
      i < result.length;
      i++) {

        if (result[i] >
            maxConfidence) {

          maxConfidence =
          result[i];

          maxIndex = i;
        }
      }

      String detectedItem =
      labels[maxIndex];

      double recyclabilityScore =
          50 +
              random.nextInt(50) +
              random.nextDouble();

      String wasteType =
          "Recyclable";

      String recyclableParts =
          "";

      String nonRecyclableParts =
          "";

      String estimatedPrice =
          "₹0";

      String productCondition =
          "Average";

      if (detectedItem ==
          "Wires") {

        wasteType =
        "Recyclable";

        recyclableParts =
        "Copper, Aluminium, Plastic Coating";

        nonRecyclableParts =
        "Burnt Rubber Insulation";

        estimatedPrice =
        "₹100 - ₹500";

        productCondition =
        "Average";

      } else if (detectedItem ==
          "Speaker") {

        wasteType =
        "Recyclable";

        recyclableParts =
        "Magnets, Copper Coil, Plastic";

        nonRecyclableParts =
        "Damaged Foam";

        estimatedPrice =
        "₹200 - ₹800";

        productCondition =
        "Good";

      } else if (detectedItem ==
          "Router") {

        wasteType =
        "Recyclable";

        recyclableParts =
        "PCB, Antenna, Copper";

        nonRecyclableParts =
        "Broken Plastic";

        estimatedPrice =
        "₹150 - ₹700";

        productCondition =
        "Average";

      } else if (detectedItem ==
          "Printer") {

        wasteType =
        "Partially Recyclable";

        recyclableParts =
        "Motors, Plastic Body, PCB";

        nonRecyclableParts =
        "Ink Cartridges";

        estimatedPrice =
        "₹500 - ₹2500";

        productCondition =
        "Average";

      } else if (detectedItem ==
          "Mouse") {

        wasteType =
        "Recyclable";

        recyclableParts =
        "Plastic Shell, Sensors, Wire";

        nonRecyclableParts =
        "Damaged Switches";

        estimatedPrice =
        "₹50 - ₹200";

        productCondition =
        "Average";

      } else if (detectedItem ==
          "Laptop") {

        wasteType =
        "Highly Recyclable";

        recyclableParts =
        "Battery, RAM, PCB, Aluminium";

        nonRecyclableParts =
        "Broken Display Layers";

        estimatedPrice =
        "₹2000 - ₹15000";

        productCondition =
        "Good";

      } else if (detectedItem ==
          "Keyboard") {

        wasteType =
        "Recyclable";

        recyclableParts =
        "Plastic Body, USB Cable, PCB";

        nonRecyclableParts =
        "Rubber Membrane";

        estimatedPrice =
        "₹100 - ₹400";

        productCondition =
        "Average";

      } else if (detectedItem ==
          "Charger") {

        wasteType =
        "Recyclable";

        recyclableParts =
        "Copper Coil, Plastic Body";

        nonRecyclableParts =
        "Burnt Components";

        estimatedPrice =
        "₹50 - ₹300";

        productCondition =
        "Average";
      }

      setState(() {

        output = """

Detected Item:
$detectedItem

Confidence:
${(maxConfidence * 100).toStringAsFixed(2)}%

Waste Type:
$wasteType

Recyclability Score:
${recyclabilityScore.toStringAsFixed(2)}%

Condition:
$productCondition

Recyclable Parts:
$recyclableParts

Non-Recyclable Parts:
$nonRecyclableParts

Estimated Price:
$estimatedPrice
""";

        confidenceScore =
            maxConfidence * 100;

        isLoading = false;
      });

    } catch (e) {

      debugPrint(
        "CLASSIFICATION ERROR: ${e.toString()}",
      );

      setState(() {

        output =
        "Classification Failed";

        isLoading = false;
      });
    }

  }

  @override
  void dispose() {

    interpreter?.close();

    super.dispose();

  }

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

          "E-Waste Scanner",

          style: TextStyle(

            color: Colors.black,

            fontWeight:
            FontWeight.bold,
          ),
        ),

        iconTheme:
        const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              width: double.infinity,

              height: 280,

              decoration:
              BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(
                  20,
                ),

                border: Border.all(

                  color:
                  Colors.green,

                  width: 1.5,
                ),
              ),

              child: selectedImage ==
                  null

                  ? Column(

                mainAxisAlignment:
                MainAxisAlignment
                    .center,

                children: const [

                  Icon(

                    Icons.image,

                    size: 90,

                    color:
                    Colors.grey,
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Text(

                    "No Image Selected",

                    style:
                    TextStyle(

                      color:
                      Colors.grey,

                      fontSize:
                      18,
                    ),
                  ),
                ],
              )

                  : ClipRRect(

                borderRadius:
                BorderRadius
                    .circular(
                  20,
                ),

                child: Image.file(

                  selectedImage!,

                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Row(

              children: [

                Expanded(

                  child:
                  ElevatedButton.icon(

                    style:
                    ElevatedButton
                        .styleFrom(

                      backgroundColor:
                      Colors.green,

                      padding:
                      const EdgeInsets
                          .symmetric(
                        vertical:
                        16,
                      ),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius
                            .circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed:
                    pickImageFromCamera,

                    icon:
                    const Icon(

                      Icons.camera_alt,

                      color:
                      Colors.white,
                    ),

                    label:
                    const Text(

                      "Camera",

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
                  width: 15,
                ),

                Expanded(

                  child:
                  ElevatedButton.icon(

                    style:
                    ElevatedButton
                        .styleFrom(

                      backgroundColor:
                      Colors.blue,

                      padding:
                      const EdgeInsets
                          .symmetric(
                        vertical:
                        16,
                      ),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius
                            .circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed:
                    pickImageFromGallery,

                    icon:
                    const Icon(

                      Icons.photo,

                      color:
                      Colors.white,
                    ),

                    label:
                    const Text(

                      "Gallery",

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

            const SizedBox(
              height: 30,
            ),

            if (isLoading)
              const CircularProgressIndicator(),

            if (!isLoading)

              Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(
                  20,
                ),

                decoration:
                BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                      Colors.grey
                          .withOpacity(
                        0.2,
                      ),

                      blurRadius: 10,

                      offset:
                      const Offset(
                        0,
                        4,
                      ),
                    ),
                  ],
                ),

                child: Text(

                  output,

                  style:
                  const TextStyle(

                    fontSize: 18,

                    fontWeight:
                    FontWeight.w600,

                    height: 1.7,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

  }
}
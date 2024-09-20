import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/operations_firebase_controller.dart';

class CountryDetailPage extends StatelessWidget {
  CountryDetailPage({super.key});

  final OperationsFirebaseController _operationsFirebaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    final countryName = Get.arguments['countryName'];
    final countryFlag = Get.arguments['countryFlag'];
    final countryLatLng = Get.arguments['countryLatLng'];
    final countryLink = Get.arguments['countryLinkMap'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          countryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  countryFlag,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'País:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              countryName,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Latitude/Longitude: $countryLatLng',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 38),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () => Get.toNamed(
                  '/openMapPage',
                  arguments: {
                    'url': countryLink,
                    'countryName': countryName,
                  },
                ),
                child: Text(
                  "Abrir no Google Maps",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: _operationsFirebaseController.isProcessing.value
                      ? null
                      : () async {
                          Map<String, dynamic> countrySaved =
                              await _operationsFirebaseController
                                  .addRemoveFavoriteCountry(
                            "$countryName",
                            "$countryFlag",
                            "$countryLatLng",
                            "$countryLink",
                          );

                          await _operationsFirebaseController
                              .isCountryPresent(countryName);

                          Get.showSnackbar(
                            GetSnackBar(
                              messageText: Text(
                                "${countrySaved["message"]}",
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        },
                  child: Text(
                    _operationsFirebaseController.inList.value
                        ? "Salvar como favorito"
                        : "Remover dos Favoritos",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

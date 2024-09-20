import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_countries_flutter/controllers/country_api_controller.dart';
import 'package:rest_countries_flutter/controllers/operations_firebase_controller.dart';
import 'package:rest_countries_flutter/models/country_model.dart';
import 'package:rest_countries_flutter/views/my_widgets/country_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CountryApiController _countryApiController = Get.find();
  final OperationsFirebaseController _operationsFirebaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    _countryApiController.getCountries();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Países de Lingua Portuguesa',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed("/favoritesCountriesPage"),
            style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(Colors.white),
            ),
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () => Get.toNamed("/loginPage"),
            style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(Colors.white),
            ),
            icon: Icon(Icons.logout),
          )
        ],
        backgroundColor: Colors.red[900],
        iconTheme: IconThemeData(color: Colors.white70),
      ),
      body: Obx(() {
        if (_countryApiController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        final countriesList = _countryApiController.countries;

        return ListView.builder(
          itemCount: countriesList.length,
          itemBuilder: (context, index) {
            CountryModel currentCountry = countriesList[index];

            return CountryTile(
              countryFlag: currentCountry.flag,
              countryName: currentCountry.name,
              countryMap: currentCountry.linkMap,
              countryLatLng: currentCountry.latLng,
              buttonFunction: () => Get.toNamed(
                '/countryDetailPage',
                arguments: {
                  'countryName': currentCountry.name,
                  'countryFlag': currentCountry.flag,
                  'countryLatLng': currentCountry.latLng,
                  'countryLinkMap': currentCountry.linkMap,
                },
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_countries_flutter/controllers/country_api_controller.dart';
import 'package:rest_countries_flutter/controllers/operations_firebase_controller.dart';
import 'package:rest_countries_flutter/models/country_model.dart';
import 'package:rest_countries_flutter/views/my_widgets/country_tile.dart';

class FavoritesCountriesPage extends StatelessWidget {
  FavoritesCountriesPage({super.key});

  final OperationsFirebaseController _operationsFirebaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    _operationsFirebaseController.getFavorites();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Países Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
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
        if (_operationsFirebaseController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        final countriesList = _operationsFirebaseController.countries;

        return countriesList.isNotEmpty
            ? ListView.builder(
                itemCount: countriesList.length,
                itemBuilder: (context, index) {
                  CountryModel currentCountry =
                      CountryModel.createFromJson(countriesList[index]);

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
              )
            : const Center(child: Text("Você ainda não tem países favoritos"));
      }),
    );
  }
}

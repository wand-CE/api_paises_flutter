import 'package:get/get.dart';
import 'package:rest_countries_flutter/models/country_model.dart';
import 'package:rest_countries_flutter/services/country_api_service.dart';

class CountryApiController extends GetxController {
  final CountryApiService _countryApiService = CountryApiService();

  var countries = [].obs;
  var isLoading = true.obs;

  Future<void> getCountries() async {
    try {
      isLoading(true);
      await Future.delayed(Duration(seconds: 2));
      final countriesFetched = await _countryApiService.fetchCountries();
      countries.assignAll(countriesFetched);
    } finally {
      isLoading(false);
    }
  }
}

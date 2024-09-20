import 'package:get/get.dart';
import 'package:rest_countries_flutter/services/operations_firebase.dart';

class OperationsFirebaseController extends GetxController {
  final DatabaseOperationsFirebase _databaseOperationsFirebase =
      DatabaseOperationsFirebase();

  var countries = [].obs;
  var isLoading = true.obs;
  var inList = false.obs;

  var isProcessing = false.obs;

  Future<void> getFavorites() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 1));
      final countriesFetched = await _databaseOperationsFirebase.getFavorites();
      countries.assignAll(countriesFetched);
    } finally {
      isLoading(false);
    }
  }

  Future<void> createUser(String emailAddress, String password) async {
    _databaseOperationsFirebase.createNewUserAcoount(emailAddress, password);
  }

  Future<Map<String, dynamic>> loginUser(
      String emailAddress, String password) async {
    return await _databaseOperationsFirebase.signInEmailPass(
        emailAddress, password);
  }

  Future<void> logoutUser() async {
    _databaseOperationsFirebase.logOutUser();
  }

  Future<Map<String, dynamic>> addRemoveFavoriteCountry(String countryName,
      String countryFlag, String countryLatLng, String linkMap) async {
    isProcessing.value = true;
    Map<String, dynamic> addOrRemove =
        await _databaseOperationsFirebase.addRemoveFavoriteCountry(
            countryName, countryFlag, countryLatLng, linkMap);
    getFavorites();

    isProcessing.value = false;
    return addOrRemove;
  }

  Future<void> isCountryPresent(String countryName) async {
    inList.value = false;
    for (var country in countries) {
      if (country["countryName"] == countryName) {
        inList.value = true;
        break;
      }
    }
  }
}

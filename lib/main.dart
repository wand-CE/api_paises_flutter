import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_countries_flutter/controllers/country_api_controller.dart';
import 'package:rest_countries_flutter/controllers/open_map_view_controller.dart';

import 'app_routes.dart';
import 'controllers/operations_firebase_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // A função acima Inicialização de toda a pré-estrutura necessára para o
  // funcionamento de apps de terceiros

  final CountryApiController countryApiController =
      Get.put(CountryApiController());

  final OpenMapViewController openMapViewController =
      Get.put(OpenMapViewController());

  final OperationsFirebaseController operationsFirebaseController =
      Get.put(OperationsFirebaseController());

  runApp(GetMaterialApp(
    initialRoute: AppRoutes.loginPage,
    routes: AppRoutes.define(),
    debugShowCheckedModeBanner: false,
  ));
}

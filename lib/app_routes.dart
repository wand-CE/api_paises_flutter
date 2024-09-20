import 'package:flutter/material.dart';
import 'package:rest_countries_flutter/views/country_detail_page.dart';
import 'package:rest_countries_flutter/views/favorites_countries_page.dart';
import 'package:rest_countries_flutter/views/login_page.dart';
import 'package:rest_countries_flutter/views/open_map_page.dart';
import 'package:rest_countries_flutter/views/register_page.dart';

import 'views/home_page.dart';

class AppRoutes {
  static const homePage = '/homePage';
  static const countryDetailPage = '/countryDetailPage';
  static const openMapPage = '/openMapPage';
  static const signUpPage = '/signUpPage';
  static const loginPage = '/loginPage';
  static const registerPage = '/registerPage';
  static const forgotPassPage = '/forgotPassPage';
  static const favoritesCountriesPage = '/favoritesCountriesPage';

  static Map<String, WidgetBuilder> define() {
    return {
      homePage: (BuildContext context) => HomePage(),
      loginPage: (BuildContext context) => LoginPage(),
      registerPage: (BuildContext context) => RegisterPage(),
      countryDetailPage: (BuildContext context) => CountryDetailPage(),
      openMapPage: (BuildContext context) => OpenMapPage(),
      favoritesCountriesPage: (BuildContext context) =>
          FavoritesCountriesPage(),
      // signUpPage: (BuildContext context) => SignUpPage(),
      // loginPage: (BuildContext context) => LoginPage(),
      // forgotPassPage: (BuildContext context) => ForgotPassPage(),
      // addNotePage: (BuildContext context) => AddNotePage(),
    };
  }
}

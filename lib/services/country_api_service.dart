import 'package:get/get.dart';
import 'package:rest_countries_flutter/models/country_model.dart';

class CountryApiService extends GetConnect {
  final url = "https://restcountries.com/v3.1/lang/portuguese";

  Future<List<dynamic>> fetchCountries() async {
    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final List<dynamic> resultado = response.body;
        List<dynamic> paises = [];
        resultado.forEach((country) => paises.add(
              {
                "flags": country["flags"]["png"],
                "name": country['name']["common"],
                "latLng": country["latlng"].toString(),
                "linkMap": country["maps"]["googleMaps"],
              },
            ));

        return paises.map((json) => CountryModel.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao retornar os paises');
      }
    } catch (e) {
      print(e);
      throw Exception('Não foi possível retornar os paises');
    }
  }
}

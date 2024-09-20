class CountryModel {
  final String flag;
  final String name;
  final String latLng;
  final String linkMap;

  CountryModel({
    required this.flag,
    required this.name,
    required this.latLng,
    required this.linkMap,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      flag: json["flags"],
      name: json["name"],
      latLng: json["latLng"],
      linkMap: json["linkMap"],
    );
  }

  static CountryModel createFromJson(Map<String, dynamic> json) {
    return CountryModel(
      flag: json["countryFlag"],
      name: json["countryName"],
      latLng: json["countryLatLng"],
      linkMap: json["countryLinkMap"],
    );
  }
}

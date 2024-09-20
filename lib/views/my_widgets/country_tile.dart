import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  final String countryFlag;
  final String countryName;
  final String countryLatLng;
  final String countryMap;
  final VoidCallback buttonFunction;

  const CountryTile({
    super.key,
    required this.countryFlag,
    required this.countryName,
    required this.countryLatLng,
    required this.countryMap,
    required this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          leading: Image.network(
            countryFlag,
            width: 70,
          ),
          title: Text(
            countryName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Latitude/Longitude $countryLatLng"),
              SizedBox(height: 10),
              Text("$countryMap"),
            ],
          ),
          onTap: buttonFunction,
        ),
      ),
    );
  }
}

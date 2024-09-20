import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_countries_flutter/controllers/open_map_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenMapPage extends StatelessWidget {
  const OpenMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookTitle = Get.arguments['countryName'] ?? 'País';
    final url = Get.arguments['url'];

    final OpenMapViewController openMapViewController = Get.find();

    openMapViewController.loadPage(url);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$bookTitle',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[900],
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: openMapViewController.reloadPage,
          ),
        ],
      ),
      body: Obx(() {
        if (openMapViewController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return WebViewWidget(
            controller: openMapViewController.webViewController);
      }),
    );
  }
}

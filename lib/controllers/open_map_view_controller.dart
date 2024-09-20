import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenMapViewController extends GetxController {
  late WebViewController webViewController;
  var isLoading = true.obs;

  OpenMapViewController() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  void loadPage(String url) {
    isLoading.value = true;
    webViewController.loadRequest(Uri.parse(url));
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {
        isLoading.value = true;
      },
      onPageFinished: (String url) {
        isLoading.value = false;
      },
      onWebResourceError: (WebResourceError error) {
        isLoading.value = false;
      },
    ));
  }

  void reloadPage() {
    webViewController.reload();
  }
}

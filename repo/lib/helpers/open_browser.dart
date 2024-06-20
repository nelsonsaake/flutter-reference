import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

openBrowser(String url) async {
  try {
    await launcher.launchUrl(Uri.parse(url));
  } catch (e) {
    if (kDebugMode) {
      print("[lib/helpers/open_browser.openBrowser] $e");
    }
  }
}

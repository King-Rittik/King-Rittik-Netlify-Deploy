import 'package:url_launcher/url_launcher.dart';

class Kutils {
  static Future<void> kLaunchUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }
}

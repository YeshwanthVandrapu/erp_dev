import 'package:url_launcher/url_launcher.dart';

void launchURL(link) async {
  // Uri url = Uri(path: 'https://erp.krea.edu.in/');
  Uri url = Uri(path: link);
  if (await canLaunchUrl(url)) {
    launchUrl(url);
  } else {
    throw 'Could not launch url';
  }
}

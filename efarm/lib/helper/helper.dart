
import 'package:url_launcher/url_launcher.dart';


class Helper{

  Future<void> launchURL(String url) async {
    // ignore: deprecated_member_use
    await canLaunch(url) ? await launch(url) : throw 'cannot launch url';
  }




}
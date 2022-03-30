import 'dart:async';
import 'package:http/http.dart' as http;

class VideoAPI {
  static String urlBase = 'http://192.168.0.14:3002/api/tasks/video';
  static Future getVideo() {
    Uri url = Uri.parse(urlBase);
    return http.get(url);
  }
}
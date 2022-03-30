import 'dart:async';
import 'package:http/http.dart' as http;

class ToDoAPI {
  static String urlBase = 'http://192.168.0.14:3002/api/tasks';
  static Future getToDO() {
    Uri url = Uri.parse(urlBase);
    return http.get(url);
  }

  static Future postToDO(title, description, date) {
    Uri url = Uri.parse(urlBase);
    print({title, description, date});

    var payload = {
      "titulo": title,
      "description": description,
      "date": date
    } ;
    print(payload);
    return http.post(url, body: payload);
  }

  static Future deleteToDO(id) {
    Uri url = Uri.parse(urlBase +'/${id }');
    return http.delete(url);
  }
}
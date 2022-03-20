import 'dart:async';
import 'package:http/http.dart' as http;

class ToDoAPI {
  static Future getToDO() {
    Uri url = Uri.parse('http://192.168.0.16:3002/api/tasks');
    return http.get(url);
  }

  static Future postToDO(data) {
    Uri url = Uri.parse('http://192.168.0.16:3002/api/tasks');
    var dadoss = { "nome": data} ;
    return http.post(url, body: { "nome": data});
  }
}
import 'package:http/http.dart' as http;

enum Method {
  get
}

abstract class Router {
  String get uri;
  Method get method;
  Map<String, String> get headers;
}

class ApiClient {

  final http.Client _client = http.Client();

  Future<http.Response> fetch(Router router) async {
    var response = await _client.get(Uri.parse(router.uri));
    return response;
  }
}
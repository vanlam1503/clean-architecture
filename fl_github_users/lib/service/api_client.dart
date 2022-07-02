import 'package:http/http.dart' as http;
import 'package:fl_github_users/model/user_dto.dart';

enum Method {
  get
}

abstract class Router {
  String get uri;
  Method get method;
  Map<String, String> get headers;
}

class UsersService implements Router {

  @override
  String get uri => "https://api.github.com/users";
  @override
  Method get method => Method.get;
  @override
  Map<String, String> get headers => { "": "" };
}

class ApiClient {

  final http.Client _client = http.Client();

  Future<http.Response> fetch(Router router) async {
    var response = await _client.get(Uri.parse(router.uri), headers: router.headers);
    print(response.body);
    return response;
  }
}
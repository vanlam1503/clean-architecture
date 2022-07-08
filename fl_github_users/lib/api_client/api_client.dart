import 'package:http/http.dart' as http;

enum Method {
  get
}

abstract class Router {
  String get uri;
  Method get method;
  Map<String, String>? get headers;
}

abstract class ApiClient {
  Future<Result<String>> fetch(Router router);
}

class ApiClientImpl implements ApiClient {

  final http.Client _client = http.Client();

  @override
  Future<Result<String>> fetch(Router router) async {
    var response = await _client.get(Uri.parse(router.uri), headers: router.headers);
    try {
      switch (response.statusCode) {
        case 200:
          return Result.success(response.body);
        case -1005:
          throw Result.failure(NetworkError.disconnect());
        case -1001:
          throw Result.failure(NetworkError.timeout());
        case -999:
          throw Result.failure(NetworkError.cancel());
        default:
          throw Result.failure(NetworkError.unknown(response.statusCode));
      }
    } catch (e) {
      throw Result.failure(NetworkError.unknown(1000));
    }
   }
}

class Result<T> implements Exception {
  final T? value;
  final Exception? error;
  const Result({this.value, this.error});
  factory Result.success(T value) {
    return Result(value: value, error: null);
  }
  factory Result.failure(Exception error) {
    return Result(value: null, error: error);
  }
}

class NetworkError implements Exception {
  int code;
  String message;

  NetworkError(this.code, this.message);

  factory NetworkError.disconnect() => NetworkError(-1005, "network error");
  factory NetworkError.timeout() => NetworkError(-1001, "time out");
  factory NetworkError.unknown(int code) => NetworkError(code, "Unknown");
  factory NetworkError.cancel() => NetworkError(-999, "Cancel request");
}

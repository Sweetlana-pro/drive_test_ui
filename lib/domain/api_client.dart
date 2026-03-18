import 'dart:io';
import 'dart:convert';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final requestToken = await _makeToken();
    final validatedToken = await _validateUser(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    final sessionId = await _makeSession(requestToken: validatedToken);
    return sessionId;
  }

  Uri makeUri(String path, [Map<String, String>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    }
    return uri;
  }

  // static const _host = 'https://reqres.in/api';
  // static const _imageUrl = 'https://reqres.in/img/faces/2-image.jpg';
  // static const _apiKey = '1234567890';

  Future<String> _makeToken() async {
    final url = makeUri('/authentification/token/new', <String, String>{
      'api_key': _apiKey,
    });

    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;

    // request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    // request.headers.set('api_key', _apiKey);
    // request.add(utf8.encode(jsonEncode({
    //   'email': 'eve.holt@reqres.in',
    //   'password': 'cityslicka',
    // })));
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final url = makeUri(
      '/authentification/token/validate_with_login',
      <String, String>{'api_key': _apiKey},
    );
    // Implementation for validating user
    final parameters = {
      'username': username,
      'password': password,
      'request_token': requestToken,
    };

    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession({required String requestToken}) async {
    final url = makeUri('/authentification/session/new', <String, String>{
      'api_key': _apiKey,
    });
    // Implementation for validating user
    final parameters = {'request_token': requestToken};

    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}

  // extension HttpClientResponseJsonDecode on HttpClientResponse {

  //   // Future <dynamic> jsonDecode () async{
  //   //     return transform(utf8.decoder)
  //   //     .toList()
  //   //     .then((value) => value.join())
  //   //     .then<dynamic>((v) => jsonDecode(v) as Map<String, dynamic>);}
  //   Future<Map<String, dynamic>> jsonDecode() async {
  //     final jsonString = await this
  //         .transform(utf8.decoder)
  //         .toList()
  //         .then((value) => value.join());
  //     return jsonDecode(jsonString) as Map<String, dynamic>;
  //   }
  // }


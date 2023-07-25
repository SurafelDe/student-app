
import 'dart:convert';
import 'dart:io';
import '../../services/http_attrib_options.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

abstract class IHttpService {
  Future<String?> send(HttpAttribOptions httpAttribOptions);
  Future<String?> multiPart(HttpAttribOptions httpAttribOptions, filepath);
}

class HttpService extends IHttpService {

  @override
  Future<String?> send(HttpAttribOptions httpAttribOptions) async {
    try {
      /*prepare header*/
      String contentType = 'application/json'; /*default content type*/

      switch (httpAttribOptions.serializationMethod) {
        case BodySerializationMethod.UrlEncoded:
          contentType = 'application/x-www-form-urlencoded';
          break;
        default:
      }

      /// Get the IpAddress based on requestType.


      Map<String, String> header = {
        'Content-type': contentType,
      };

      http.Response? response;
      var url = Uri.parse(httpAttribOptions.baseUrl + httpAttribOptions.path);

      var _client = RetryClient(http.Client(), retries: 2,
          when: (http.BaseResponse response) {
        return isWorthyRetry(response.statusCode);
      });
      // final Map<String, dynamic> data = json.decode(httpAttribOptions.body?.toString() ?? "");

      if (httpAttribOptions.method == HttpMethods.GET) {
        response = await _client
            .get(url, headers: header)
            .timeout(Duration(seconds: 60));
      } else if (httpAttribOptions.method == HttpMethods.POST) {
        response = await _client
            .post(url,
                body: httpAttribOptions.body, //httpAttribOptions.body,
                headers: header,
                encoding: Encoding.getByName('utf-8'))
            .timeout(Duration(seconds: 60));
      }
      else if (httpAttribOptions.method == HttpMethods.PUT) {
        response = await _client
            .put(url,
            body: httpAttribOptions.body, //httpAttribOptions.body,
            headers: header,
            encoding: Encoding.getByName('utf-8'))
            .timeout(Duration(seconds: 60));
      }
      else if (httpAttribOptions.method == HttpMethods.DELETE) {
        response = await _client
            .delete(url,
            body: httpAttribOptions.body, //httpAttribOptions.body,
            headers: header,
            encoding: Encoding.getByName('utf-8'))
            .timeout(Duration(seconds: 60));
      }

      if (response?.statusCode == 200) {
        return response?.body;
      }
      else if (response?.statusCode == 401 || response?.statusCode == 403) {

        return response?.body;
      }
    } catch (ex, stack) {
      print(stack);
    }

    return null;
  }

  @override
  Future<String?> multiPart(
      HttpAttribOptions httpAttribOptions, filepath) async {

    try {
      String contentType = 'application/json';

      switch (httpAttribOptions.serializationMethod) {
        case BodySerializationMethod.UrlEncoded:
          contentType = 'application/x-www-form-urlencoded';
          break;
        default:
      }

      Map<String, String> header = {
        'Content-type': contentType,
      };

      var request = http.MultipartRequest(httpAttribOptions.method.name, Uri.parse(httpAttribOptions.baseUrl + httpAttribOptions.path));

      if(filepath != null) {
        request.files.add(await http.MultipartFile.fromPath('photo', filepath));
      }

      request.headers.addAll(header);

      Map<String, dynamic> bodyParameters = json.decode(httpAttribOptions.body.toString());
      Map<String, String> stringBodyParameters =
      bodyParameters.map((key, value) => MapEntry(key, (value ?? "").toString()));

      if (httpAttribOptions.body != null) {
        request.fields
            .addAll(stringBodyParameters);
      }

      var response = await request.send();
      print(response);
      final responseString = await response.stream.bytesToString();
      //return response.reasonPhrase;
      return responseString;
    }
    catch (ex, stack) {
      print(stack);
    }
    return null;

  }


  static bool isWorthyRetry(int statusCode) {
    if (statusCode == HttpStatus.requestTimeout ||
        statusCode == HttpStatus.internalServerError ||
        statusCode == HttpStatus.badGateway ||
        statusCode == HttpStatus.serviceUnavailable ||
        statusCode == HttpStatus.gatewayTimeout) return true;
    return false;
  }
}

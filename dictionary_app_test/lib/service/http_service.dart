import 'package:dictionary_app_test/model/result_error.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/";

  static Future<http.Response> getRequest(endPoint) async {
    http.Response response;

    final url = Uri.parse("$baseUrl$endPoint");

    // try {
    //   response = await http.get(url);
    // } on Exception catch (e) {
    //   throw e;
    // }
    // return response;
    response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return response;
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorSearchingDict();
    }
  }
}

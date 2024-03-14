import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  Future<String> translateText(String text, String lang) async {
    String url = "https://todoapp-7jzr.onrender.com/translate/translateLang";
    final response = await http.post(Uri.parse(url),
        body: {"text": text, "targetLang": lang, "sourceLang": "en"});
    var result;
    if (response.statusCode == 200) {
      var answer = json.decode(response.body);
      print(answer);
      if (answer['success'] == true) {
        answer = answer['message']!['data']['translations'];
        result = answer![0]['translatedText'].toString();
      } else {
        result = "Something went wrong";
      }
      print(result);
    } else {
      result = "Something went wrong";
    }
    return result;
  }
}

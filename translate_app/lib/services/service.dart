import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  Future<String> translateText(String text, String lang) async {
    // String key = ""
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final data =
        '{\n  "source": "en",\n  "target": "${lang}",\n  "text": "${text}",\n  "proxies": []\n}';

    print(data);

    final url =
        Uri.parse('https://deep-translator-api.azurewebsites.net/mymemory/');

    final response = await http.post(url, headers: headers, body: data);
    // String url =
    //     "https://deep-translator-api.azurewebsites.net/mymemory/";
    // final response = await http.post(Uri.parse(url), headers: {
    //   'X-RapidAPI-Key': 'c31066519fmsh127a08d5258a9c3p1f3d85jsn61dd90156031',
    //   'X-RapidAPI-Host': 'microsoft-translator-text.p.rapidapi.com'
    // }, body: {
    //   "source": "auto",
    //   "target": lang,
    //   "text": text,
    // });
    print("printing resposnse");
    print(response.statusCode.toString());
    var result;
    if (response.statusCode == 200) {
      var answer = json.decode(response.body);
      print("answer");
      print(answer);
      if (answer['error'] == null) {
        answer = answer['translation'];
        result = answer.toString();
      } else {
        result = "Something went wrong";
      }
      print("result");
      print(result);
    } else {
      result = "Something went wrong";
    }
    return result;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryService {
  static Future<String?> getMeaning(String word) async {
    final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[0]['meanings'][0]['definitions'][0]['definition'];
    }
    return null;
  }

}

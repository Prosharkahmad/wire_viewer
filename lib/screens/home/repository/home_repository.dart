import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<String> getCharacters(query) async {
    final response = await http.get(
        Uri.parse("http://api.duckduckgo.com/?q=" + query + "&format=json"),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        });
    return response.body;
  }
}

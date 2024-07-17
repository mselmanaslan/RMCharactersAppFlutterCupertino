import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/ApiCharacter.dart';
import '../../Model/CharacterApiResponse.dart';
import '../../Model/Filter.dart';

class CharacterService {
  Future<List<ApiCharacter>> fetchCharacters(void Function() callback, Filter filter, int pageNumber) async {
    final String baseUrl = 'https://rickandmortyapi.com/api/character/';
    final Uri url = Uri.parse(
        '$baseUrl?page=$pageNumber&name=${filter.name ?? ''}&status=${filter.status ?? ''}&species=${filter.species ?? ''}&gender=${filter.gender ?? ''}'
    );

    print('Base URL: $baseUrl');
    print('Request URL: $url');

    try {
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = json.decode(response.body);
        final responseInfo = CharacterApiResponse.fromJson(jsonResponse);

        if (responseInfo.info.pages >= pageNumber) {
          callback();
          return responseInfo.results;
        } else {
          print('Sayfa sonu...');
          return [];
        }
      } else {
        throw Exception('Geçersiz yanıt: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Hata: $e');
    }
  }
}

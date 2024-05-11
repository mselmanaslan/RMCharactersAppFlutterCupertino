import 'package:rmcharactersappfluttercupertino/Model/ApiCharacter.dart';

import 'PageInfo.dart';

class CharacterApiResponse {
  final Info info;
  final List<ApiCharacter> results;

  CharacterApiResponse({required this.info, required this.results});

  factory CharacterApiResponse.fromJson(Map<String, dynamic> json) {

    return CharacterApiResponse(
      info: Info.fromJson(json['info']),
      results: List<ApiCharacter>.from(json['results'].map((character) => ApiCharacter.fromJson(character))),
    );
  }
}
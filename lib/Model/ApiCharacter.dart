import 'AdaptedCharacter.dart';

class CharacterResponse {
  final List<ApiCharacter> results;

  CharacterResponse({required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> results = json['results'];
    return CharacterResponse(
      results: results.map((e) => ApiCharacter.fromJson(e)).toList(),
    );
  }
}

class ApiCharacter {
  final int id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Origin? origin;
  final Location? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final String? created;

  ApiCharacter({
    required this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory ApiCharacter.fromJson(Map<String, dynamic> json) {
    return ApiCharacter(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin'] != null ? Origin.fromJson(json['origin']) : null,
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: json['created'],
    );
  }

  AdaptedCharacter AdaptCharacter() {
    return AdaptedCharacter(
      id: id.toString(),
      name: name ?? "N/A",
      image: image ?? "N/A",
      status: status ?? "N/A",
      species: species ?? "N/A",
      gender: gender ?? "N/A",
      origin: origin?.name ?? "N/A",
      location: location?.name ?? "N/A",
      episode: episode?.length ?? 0,
    );
  }
}

class Origin {
  final String? name;
  final String? url;

  Origin({this.name, this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Location {
  final String? name;
  final String? url;

  Location({this.name, this.url});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Episode {
  final String? name;
  final String? episode;

  Episode({this.name, this.episode});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      name: json['name'],
      episode: json['episode'],
    );
  }
}



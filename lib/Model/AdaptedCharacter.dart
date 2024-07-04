class AdaptedCharacter {
  final String id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;
  final String origin;
  final String location;
  final int episode;

  AdaptedCharacter({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.episode,
  });

  Map<String, dynamic> toMap() {
    return {
      'characterId': id,
      'name': name,
      'image': image,
      'status': status,
      'species': species,
      'gender': gender,
      'origin': origin,
      'location': location,
      'episodes': episode,
    };
  }

  factory AdaptedCharacter.fromMap(Map<String, dynamic> map) {
    return AdaptedCharacter(
      id: map['characterId'],
      name: map['name'],
      image: map['image'],
      status: map['status'],
      species: map['species'],
      gender: map['gender'],
      origin: map['origin'],
      location: map['location'],
      episode: map['episodes'],
    );
  }
}

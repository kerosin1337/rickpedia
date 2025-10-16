import 'dart:convert';

import 'character_enum.dart';

class CharacterModel {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final CharacterLocationMeta origin;
  final CharacterLocationMeta location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  bool isFavorite;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    this.isFavorite = false,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'],
      name: map['name'],
      status: CharacterStatus.fromString(map['status']),
      species: map['species'],
      type: map['type'],
      gender: CharacterGender.fromString(map['gender']),
      origin: CharacterLocationMeta.fromMap(map['origin']),
      location: CharacterLocationMeta.fromMap(map['location']),
      image: map['image'],
      episode: List<String>.from(map['episode']),
      url: map['url'],
      created: DateTime.parse(map['created']),
    );
  }

  factory CharacterModel.fromJson(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'],
      name: map['name'],
      status: CharacterStatus.fromString(map['status']),
      species: map['species'],
      type: map['type'],
      gender: CharacterGender.fromString(map['gender']),
      origin: CharacterLocationMeta.fromMap(jsonDecode(map['origin'])),
      location: CharacterLocationMeta.fromMap(jsonDecode(map['location'])),
      image: map['image'],
      episode: List<String>.from(map['episode']),
      url: map['url'],
      created: DateTime.parse(map['created']),
      isFavorite: true,
    );
  }

  String toJson() => jsonEncode({
    'id': id,
    'name': name,
    'status': status.status,
    'species': species,
    'type': type,
    'gender': gender.gender,
    'origin': origin.toJson(),
    'location': location.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created.toIso8601String(),
  });
}

class CharacterLocationMeta {
  final String name;
  final String url;

  CharacterLocationMeta({required this.name, required this.url});

  factory CharacterLocationMeta.fromMap(Map<String, dynamic> map) {
    return CharacterLocationMeta(name: map['name'], url: map['url']);
  }

  String toJson() => jsonEncode({'name': name, 'url': url});
}

import 'package:json_annotation/json_annotation.dart';
import 'package:kdigital_test/src/features/main/data/models/location.dart';
import 'package:kdigital_test/src/features/main/domain/entities/character.dart';

part 'character.g.dart';

@JsonSerializable()
class CharacterModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "species")
  final String species;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "origin")
  final Location origin;
  @JsonKey(name: "location")
  final Location location;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "episode")
  final List<String> episode;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "created")
  final DateTime created;

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
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterEntity toEntity() => CharacterEntity(
        name: name,
        status: status,
        species: species,
        image: image,
      );
}

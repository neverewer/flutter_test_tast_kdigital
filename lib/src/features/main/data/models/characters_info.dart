import 'package:json_annotation/json_annotation.dart';
import 'package:kdigital_test/src/features/main/data/models/character.dart';
import 'package:kdigital_test/src/features/main/data/models/info.dart';
import 'package:kdigital_test/src/features/main/domain/entities/characters_info.dart';

part 'characters_info.g.dart';

@JsonSerializable()
class CharactersInfo {
  @JsonKey(name: "info")
  final Info info;
  @JsonKey(name: "results")
  final List<CharacterModel> characters;

  CharactersInfo({
    required this.info,
    required this.characters,
  });

  factory CharactersInfo.fromJson(Map<String, dynamic> json) => _$CharactersInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersInfoToJson(this);

  CharactersInfoEntity toEntity() => CharactersInfoEntity(
        pages: info.pages,
        characters: characters.map((e) => e.toEntity()).toList(),
      );
}

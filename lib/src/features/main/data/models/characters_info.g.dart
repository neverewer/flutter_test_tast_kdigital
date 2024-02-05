// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersInfo _$CharactersInfoFromJson(Map<String, dynamic> json) =>
    CharactersInfo(
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      characters: (json['results'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharactersInfoToJson(CharactersInfo instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.characters,
    };

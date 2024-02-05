import 'package:kdigital_test/src/features/main/domain/entities/character.dart';

class CharactersInfoEntity {
  final int pages;
  final List<CharacterEntity> characters;

  CharactersInfoEntity({
    required this.pages,
    required this.characters,
  });
}

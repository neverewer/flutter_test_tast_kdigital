import 'package:kdigital_test/src/features/main/domain/entities/characters_info.dart';

abstract interface class ICharactersRepository {
  Future<CharactersInfoEntity> getCharacters(int page);
}

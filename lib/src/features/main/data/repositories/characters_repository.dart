import 'package:kdigital_test/src/features/main/data/data_providers/character_data_provider.dart';
import 'package:kdigital_test/src/features/main/domain/entities/characters_info.dart';
import 'package:kdigital_test/src/features/main/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements ICharactersRepository {
  final ICharactersDataProvider charactersDataProvider;

  CharactersRepositoryImpl({required this.charactersDataProvider});

  @override
  Future<CharactersInfoEntity> getCharacters(int page) async {
    try {
      var charactersInfoModel = await charactersDataProvider.getCharacters(page);
      return charactersInfoModel.toEntity();
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        e,
        stackTrace,
      );
    }
  }
}

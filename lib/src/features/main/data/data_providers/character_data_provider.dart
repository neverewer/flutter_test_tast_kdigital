import 'package:http/http.dart';
import 'package:kdigital_test/src/common/utils/constants/api_constants.dart';
import 'package:kdigital_test/src/common/utils/exceptions/network_exception.dart';
import 'dart:convert' as convert;

import 'package:kdigital_test/src/features/main/data/models/characters_info.dart';

abstract interface class ICharactersDataProvider {
  /// get characters
  Future<CharactersInfo> getCharacters(int page);
}

final class CharactersDataProviderImpl implements ICharactersDataProvider {
  CharactersDataProviderImpl({required client}) : _client = client;

  final Client _client;

  @override
  Future<CharactersInfo> getCharacters(int page) async {
    try {
      var response = await _client.get(Uri.parse('$baseUrl/character/?page=$page'));
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return CharactersInfo.fromJson(jsonResponse);
      }
      throw RemoteDataProviderException(statusCode: response.statusCode);
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
}

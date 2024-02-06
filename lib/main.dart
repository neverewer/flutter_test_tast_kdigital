import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:http/http.dart';
import 'package:kdigital_test/src/common/utils/logger_utils.dart';
import 'package:kdigital_test/src/features/app/app.dart';
import 'package:kdigital_test/src/features/dependencies/model/dependencies.dart';
import 'package:kdigital_test/src/features/main/data/data_providers/character_data_provider.dart';
import 'package:kdigital_test/src/features/main/data/repositories/characters_repository.dart';
import 'package:kdigital_test/src/features/main/domain/repositories/characters_repository.dart';
import 'package:l/l.dart';

void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        () async {
          WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

          //show splash screen
          FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

          //set orientation
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);

          //Create dependencies
          final dependencies = await createDependencies();

          //Run app
          runApp(
            MyApp(
              dependencies: dependencies,
            ),
          );

          //remove splash screen
          FlutterNativeSplash.remove();
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        messageFormatting: LoggerUtils.messageFormatting,
        outputInRelease: false,
        printColors: true,
      ),
    );

//Create immutable dependencies
Future<Dependencies> createDependencies() async {
  final Client client = Client();
  final ICharactersDataProvider charactersDataProvider = CharactersDataProviderImpl(client: client);
  final ICharactersRepository characterRepository =
      CharactersRepositoryImpl(charactersDataProvider: charactersDataProvider);
  final Dependencies dependencies = Dependencies(
    charactersRepository: characterRepository,
  );

  return dependencies;
}

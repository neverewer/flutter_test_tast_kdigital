import 'package:flutter/material.dart';
import 'package:kdigital_test/src/features/dependencies/model/dependencies.dart';
import 'package:kdigital_test/src/features/dependencies/widget/dependencies_scope.dart';
import 'package:kdigital_test/src/features/main/presentation/main_screen.dart';

class MyApp extends StatelessWidget {
  final Dependencies dependencies;

  const MyApp({
    super.key,
    required this.dependencies,
  });

  @override
  Widget build(BuildContext context) => DependenciesScope(
        dependencies: dependencies,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test app',
          home: MainScreen(),
        ),
      );
}

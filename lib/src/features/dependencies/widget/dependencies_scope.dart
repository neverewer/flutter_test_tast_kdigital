import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kdigital_test/src/features/dependencies/model/dependencies.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    super.key,
    required super.child,
    required this.dependencies,
  });

  final Dependencies dependencies;

  /// Get the dependencies from the [context].
  static Dependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DependenciesScope>()!.dependencies;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<Dependencies>('dependencies', dependencies),
    );
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}

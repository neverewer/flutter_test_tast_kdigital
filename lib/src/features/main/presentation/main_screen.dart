import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdigital_test/src/features/dependencies/widget/dependencies_scope.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/features/main/presentation/main_screen_form.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => MainBloc(repository: DependenciesScope.of(context).charactersRepository)
          ..add(
            const MainEvent.fetch(),
          ),
        child: const MainScreenForm(),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdigital_test/src/common/widgets/failture_widget.dart';
import 'package:kdigital_test/src/common/widgets/loading_widget.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_state.dart';
import 'package:kdigital_test/src/features/main/presentation/widgets/main_data_widget.dart';

class MainScreenForm extends StatelessWidget {
  const MainScreenForm({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          MainBloc bloc = context.read<MainBloc>();
          state.mapOrNull(
            error: (state) => showDialog(
              context: context,
              builder: (context) => FailureWidget(
                error: state.error,
                errorButtonCallback: () {
                  bloc.add(const MainEvent$Add());
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
        builder: (context, state) => state.maybeMap(
          idle: (_) => const LoadingWidget(),
          processing: (_) => const LoadingWidget(),
          orElse: () => state.hasData
              ? MainDataWidget(
                  characters: state.data,
                  hasReachedMax: state.hasReachedMax,
                )
              : const CircularProgressIndicator(),
        ),
      );
}

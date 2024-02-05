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
  Widget build(BuildContext context) => BlocBuilder<MainBloc, MainState>(
        builder: (context, state) => state.map(
          idle: (_) => LoadingWidget(),
          processing: (_) => LoadingWidget(),
          successful: (_) => state.hasData
              ? MainDataWidget(
                  characters: state.data!,
                  hasReachedMax: state.hasReachedMax!,
                )
              : CircularProgressIndicator(),
          error: (state) => FailureWidget(
            error: state.error,
            errorButtonCallback: () => context.read<MainBloc>().add(const MainEvent$Fetch()),
          ),
        ),
      );
}

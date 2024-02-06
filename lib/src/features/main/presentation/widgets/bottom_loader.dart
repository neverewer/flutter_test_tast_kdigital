import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdigital_test/src/common/presentation/widgets/loading_widget.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_state.dart';

class BottomLoader extends StatefulWidget {
  const BottomLoader({super.key});

  @override
  State<BottomLoader> createState() => _BottomLoaderState();
}

class _BottomLoaderState extends State<BottomLoader> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainState$Error) {
          // show snack bar with add new page error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Cannot load data. Please try again!',
                style: TextStyle(fontSize: 16),
              ),
              duration: const Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20,
              ),
            ),
          );
          setState(() {
            hasError = true;
          });
        }
      },
      child: hasError ? const ErrorLoaderWidget() : const LoadingWidget(),
    );
  }
}

class ErrorLoaderWidget extends StatelessWidget {
  const ErrorLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton.outlined(
        iconSize: 40,
        style: IconButton.styleFrom(side: const BorderSide(color: Colors.blueAccent)),
        color: Colors.blueAccent,
        onPressed: () => context.read<MainBloc>().add(const MainEvent$Add()),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}

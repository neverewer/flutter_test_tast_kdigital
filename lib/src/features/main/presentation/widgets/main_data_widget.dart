import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdigital_test/src/common/widgets/loading_widget.dart';
import 'package:kdigital_test/src/features/main/domain/entities/character.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/features/main/presentation/widgets/character_list_item_widget.dart';

class MainDataWidget extends StatefulWidget {
  final List<CharacterEntity> characters;
  final bool hasReachedMax;

  const MainDataWidget({
    super.key,
    required this.characters,
    required this.hasReachedMax,
  });

  @override
  State<MainDataWidget> createState() => _MainDataWidgetState();
}

class _MainDataWidgetState extends State<MainDataWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      context.read<MainBloc>().add(const MainEvent.add());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.hasReachedMax ? widget.characters.length : widget.characters.length + 1,
            itemExtent: 200,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return index >= widget.characters.length
                  ? LoadingWidget()
                  : CharacterListItemWidget(
                      character: widget.characters[index],
                    );
            }),
      ),
    );
  }
}

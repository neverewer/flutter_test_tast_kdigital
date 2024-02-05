import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:kdigital_test/src/features/main/domain/repositories/characters_repository.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/features/main/presentation/bloc/main_state.dart';
import 'package:l/l.dart';

/// Business Logic Component MainBLoC
class MainBloc extends Bloc<MainEvent, MainState> implements EventSink<MainEvent> {
  MainBloc({
    required final ICharactersRepository repository,
    final MainState? initialState,
  })  : _characterRepository = repository,
        super(
          initialState ??
              MainState.idle(
                data: null,
                currentPage: null,
                hasReachedMax: null,
                pages: null,
                message: 'Initial idle state',
              ),
        ) {
    on<MainEvent>(
      (event, emit) => event.map<Future<void>>(
        fetch: (event) => _fetch(event, emit),
        add: (event) => _add(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final ICharactersRepository _characterRepository;

  /// Fetch event handler
  Future<void> _fetch(MainEvent$Fetch event, Emitter<MainState> emit) async {
    try {
      emit(MainState.processing(data: state.data, currentPage: null, hasReachedMax: null, pages: null));

      final initialPage = 1;
      final charactersInfo = await _characterRepository.getCharacters(initialPage);

      emit(MainState.successful(
        data: charactersInfo.characters,
        currentPage: initialPage,
        hasReachedMax: false,
        pages: charactersInfo.pages,
      ));
    } on Object catch (err, stackTrace) {
      l.e('An error occurred in the MainBLoC: $err', stackTrace);

      emit(MainState.error(
        data: state.data,
        currentPage: null,
        hasReachedMax: null,
        pages: null,
        error: err,
      ));
      rethrow;
    }
  }

  Future<void> _add(MainEvent$Add event, Emitter<MainState> emit) async {
    try {
      final currentPage = state.currentPage;
      final data = state.data ?? List.empty();
      final pages = state.pages ?? 0;
      final newPage = currentPage == null ? 1 : currentPage + 1;

      if (newPage > pages) {
        emit(MainState.successful(
          data: data,
          currentPage: newPage,
          hasReachedMax: true,
          pages: pages,
        ));
        return;
      }

      final newCharactersInfo = await _characterRepository.getCharacters(newPage);
      data.addAll(newCharactersInfo.characters);

      emit(MainState.successful(
        data: data,
        currentPage: newPage,
        hasReachedMax: false,
        pages: newCharactersInfo.pages,
      ));
    } on Object catch (err, stackTrace) {
      l.e('An error occurred in the MainBLoC: $err', stackTrace);

      emit(MainState.error(
        data: state.data,
        currentPage: null,
        hasReachedMax: null,
        pages: null,
        error: err,
      ));
      rethrow;
    }
  }
}

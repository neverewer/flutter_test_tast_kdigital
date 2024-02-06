import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter_bloc/flutter_bloc.dart';
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
              const MainState.idle(
                data: [],
                currentPage: 0,
                pages: 0,
                hasReachedMax: false,
                error: null,
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
      emit(const MainState.processing(
        data: [],
        currentPage: 0,
        pages: 0,
        hasReachedMax: false,
        error: null,
      ));

      // initial page to load
      const initialPage = 1;

      // load data
      final charactersInfo = await _characterRepository.getCharacters(initialPage);

      emit(MainState.successful(
          data: charactersInfo.characters,
          currentPage: initialPage,
          hasReachedMax: false,
          pages: charactersInfo.pages,
          error: null));
    } on Object catch (err, stackTrace) {
      l.e('An error occurred in the MainBLoC: $err', stackTrace);

      emit(MainState.error(
        data: const [],
        currentPage: 0,
        pages: 0,
        hasReachedMax: false,
        error: err,
      ));

      rethrow;
    }
  }

  Future<void> _add(MainEvent$Add event, Emitter<MainState> emit) async {
    try {
      // Get the next page index
      final newPage = state.currentPage + 1;

      // If we have reached the last page, return
      if (newPage > state.pages) {
        emit(MainState.successful(
          data: state.data,
          currentPage: state.currentPage,
          hasReachedMax: true,
          pages: state.pages,
          error: null,
        ));
        return;
      }

      //get data from current state
      final data = state.data;

      // load data from new page
      final newCharactersInfo = await _characterRepository.getCharacters(newPage);

      //add new data to old data
      data.addAll(newCharactersInfo.characters);

      emit(MainState.successful(
        data: data,
        currentPage: newPage,
        hasReachedMax: false,
        pages: newCharactersInfo.pages,
        error: null,
      ));
    } on Object catch (err, stackTrace) {
      l.e('An error occurred in the MainBLoC: $err', stackTrace);

      emit(MainState.error(
        data: state.data,
        currentPage: state.currentPage,
        pages: state.pages,
        hasReachedMax: state.hasReachedMax,
        error: err,
      ));

      rethrow;
    }
  }
}

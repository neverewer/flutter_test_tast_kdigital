import 'package:kdigital_test/src/features/main/domain/entities/character.dart';
import 'package:meta/meta.dart';

/// {@template main_state_placeholder}
/// Entity placeholder for MainState
/// {@endtemplate}
typedef MainEntity = List<CharacterEntity>;

/// {@template main_state}
/// MainState.
/// {@endtemplate}
sealed class MainState extends _$MainStateBase {
  /// Idling state
  /// {@macro main_state}
  const factory MainState.idle({
    required MainEntity? data,
    required int? currentPage,
    required int? pages,
    required bool? hasReachedMax,
    String message,
  }) = MainState$Idle;

  /// Processing
  /// {@macro main_state}
  const factory MainState.processing({
    required MainEntity? data,
    required int? currentPage,
    required int? pages,
    required bool? hasReachedMax,
    String message,
  }) = MainState$Processing;

  /// Successful
  /// {@macro main_state}
  const factory MainState.successful({
    required MainEntity? data,
    required int? currentPage,
    required int? pages,
    required bool? hasReachedMax,
    String message,
  }) = MainState$Successful;

  /// An error has occurred
  /// {@macro main_state}
  const factory MainState.error({
    required MainEntity? data,
    required int? currentPage,
    required int? pages,
    required bool? hasReachedMax,
    required Object error,
    String message,
  }) = MainState$Error;

  /// {@macro main_state}
  const MainState(
      {required super.data,
      required super.currentPage,
      required super.hasReachedMax,
      required super.pages,
      required super.message});
}

/// Idling state
/// {@nodoc}
final class MainState$Idle extends MainState with _$MainState {
  /// {@nodoc}
  const MainState$Idle(
      {required super.data,
      required super.currentPage,
      required super.hasReachedMax,
      required super.pages,
      super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class MainState$Processing extends MainState with _$MainState {
  /// {@nodoc}
  const MainState$Processing(
      {required super.data,
      required super.currentPage,
      required super.hasReachedMax,
      required super.pages,
      super.message = 'Processing'});
}

/// Successful
/// {@nodoc}
final class MainState$Successful extends MainState with _$MainState {
  /// {@nodoc}
  const MainState$Successful(
      {required super.data,
      required super.currentPage,
      required super.hasReachedMax,
      required super.pages,
      super.message = 'Successful'});
}

/// Error
/// {@nodoc}
final class MainState$Error extends MainState with _$MainState {
  /// {@nodoc}
  final Object error;

  const MainState$Error(
      {required super.data,
      required super.currentPage,
      required super.hasReachedMax,
      required super.pages,
      required this.error,
      super.message = 'An error has occurred.'});
}

/// {@nodoc}
base mixin _$MainState on MainState {}

/// Pattern matching for [MainState].
typedef MainStateMatch<R, S extends MainState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$MainStateBase {
  /// {@nodoc}
  const _$MainStateBase(
      {required this.data,
      required this.currentPage,
      required this.hasReachedMax,
      required this.pages,
      required this.message});

  /// Data entity payload.
  @nonVirtual
  final MainEntity? data;

  @nonVirtual
  final int? currentPage;

  @nonVirtual
  final int? pages;

  @nonVirtual
  final bool? hasReachedMax;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  //  copyWith<R>({
  //   MainEntity? data,
  //   int? currentPage,
  //   String? message,
  // }) =>
  //     R(
  //       data: data,
  //       currentPage: currentPage,
  //       message: message ?? this.message,
  //     );

  /// Pattern matching for [MainState].
  R map<R>({
    required MainStateMatch<R, MainState$Idle> idle,
    required MainStateMatch<R, MainState$Processing> processing,
    required MainStateMatch<R, MainState$Successful> successful,
    required MainStateMatch<R, MainState$Error> error,
  }) =>
      switch (this) {
        MainState$Idle s => idle(s),
        MainState$Processing s => processing(s),
        MainState$Successful s => successful(s),
        MainState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [MainState].
  R maybeMap<R>({
    MainStateMatch<R, MainState$Idle>? idle,
    MainStateMatch<R, MainState$Processing>? processing,
    MainStateMatch<R, MainState$Successful>? successful,
    MainStateMatch<R, MainState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [MainState].
  R? mapOrNull<R>({
    MainStateMatch<R, MainState$Idle>? idle,
    MainStateMatch<R, MainState$Processing>? processing,
    MainStateMatch<R, MainState$Successful>? successful,
    MainStateMatch<R, MainState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}

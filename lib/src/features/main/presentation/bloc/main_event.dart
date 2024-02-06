import 'package:meta/meta.dart';

sealed class MainEvent extends _$MainEventBase {
  const factory MainEvent.fetch() = MainEvent$Fetch;
  const factory MainEvent.add() = MainEvent$Add;

  const MainEvent();
}

final class MainEvent$Fetch extends MainEvent {
  const MainEvent$Fetch();
}

final class MainEvent$Add extends MainEvent {
  const MainEvent$Add();
}

typedef MainEventMatch<R, S extends MainEvent> = R Function(S event);

@immutable
abstract base class _$MainEventBase {
  const _$MainEventBase();

  R map<R>({
    required MainEventMatch<R, MainEvent$Fetch> fetch,
    required MainEventMatch<R, MainEvent$Add> add,
  }) =>
      switch (this) {
        MainEvent$Fetch s => fetch(s),
        MainEvent$Add s => add(s),
        _ => throw AssertionError(),
      };
}

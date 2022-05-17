import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_freezed_bloc.freezed.dart';
part 'example_freezed_event.dart';
part 'example_freezed_state.dart';

class ExampleFreezedBloc
    extends Bloc<ExampleFreezedEvent, ExampleFreezedState> {
  ExampleFreezedBloc() : super(ExampleFreezedState.inital()) {
    on<_ExampleFreezedEventFindNames>(_findNames);
    on<_ExampleFreezedEventAddName>(_addName);
    on<_ExampleFreezedEventRemoveName>(_removedName);
  }

  Future<FutureOr<void>> _addName(_ExampleFreezedEventAddName event,
      Emitter<ExampleFreezedState> emitter) async {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );

    emit(ExampleFreezedState.showBanner(
        names: names, message: 'Aguarde, nome sendo inserido!!!'));

    await Future.delayed(const Duration(seconds: 1));

    final newNames = [...names];
    newNames.add(event.name);
    emit(ExampleFreezedState.data(names: newNames));
  }

  FutureOr<void> _removedName(_ExampleFreezedEventRemoveName event,
      Emitter<ExampleFreezedState> emitter) {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );

    final newNames = [...names];
    newNames.addAll(newNames);
    emit(ExampleFreezedState.data(names: newNames));
  }

  FutureOr<void> _findNames(_ExampleFreezedEventFindNames event,
      Emitter<ExampleFreezedState> emitter) async {
    emit(ExampleFreezedState.loading());
    final names = [
      "Rodrigo Ferreiraa",
      "Renan Ferreiraa",
      "Evandro",
      "Jessica",
      "Emilio"
    ];
    await Future.delayed(const Duration(seconds: 4));
    emit(ExampleFreezedState.data(names: names));
  }
}

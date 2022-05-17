import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInitial()) {
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveNameEvent>(_removedName);
  }

  FutureOr<void> _removedName(
      ExampleRemoveNameEvent event, Emitter<ExampleState> emitter) {
    final stateExample = state;

    if (stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      names.retainWhere((element) => element != event.name);
      emit(ExampleStateData(names: names));
    }
  }

  FutureOr<void> _findNames(
      ExampleFindNameEvent event, Emitter<ExampleState> emitter) async {
    final names = [
      "Rodrigo Ferreira",
      "Renan Ferreira",
      "Evandro",
      "Jessica",
      "Emilio"
    ];
    emit(ExampleStateData(names: names));
  }
}

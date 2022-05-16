part of 'counter_cubit.dart';

abstract class CounterState {
  final int counter;
  CounterState({
    required this.counter,
  });
}

class CounterStateInitial extends CounterState {
  CounterStateInitial() : super(counter: 0);
}

class CounterStateData extends CounterState {
  CounterStateData({required int counter}) : super(counter: counter);
}

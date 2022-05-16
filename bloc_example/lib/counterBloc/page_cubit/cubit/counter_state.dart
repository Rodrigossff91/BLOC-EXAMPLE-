part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  final int counter;
  const CounterState({
    required this.counter,
  });
  @override
  List<Object> get props => [counter];
}

class CounterStateInitial extends CounterState {
  const CounterStateInitial() : super(counter: 0);
}

class CounterStateData extends CounterState {
  const CounterStateData({required int counter}) : super(counter: counter);
}

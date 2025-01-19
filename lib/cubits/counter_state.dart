part of 'counter_cubit.dart';

@immutable
abstract class CounterState {
  final int value;
  final String? message;

  const CounterState({required this.value, this.message});
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(value: 0);
}

class CounterUpdated extends CounterState {
  const CounterUpdated({
    required super.value,
    super.message,
  });
}

class CounterMilestoneReached extends CounterState {
  final bool isPositive;

  const CounterMilestoneReached({
    required super.value,
    required this.isPositive,
    required super.message,
  });
}

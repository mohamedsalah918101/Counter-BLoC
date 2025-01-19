

import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  void increment() {
    final newValue = state.value + 1;
    _emitNewState(newValue);
  }

  void decrement() {
    final newValue = state.value - 1;
    _emitNewState(newValue);
  }

  void reset() {
    emit(const CounterInitial());
  }

  void _emitNewState(int newValue) {
    if (newValue == 10) {
      emit(CounterMilestoneReached(
          value: newValue,
          isPositive: true,
          message: 'Congratulations! You reached 10🎉'));
    } else if (newValue == -10) {
      emit(CounterMilestoneReached(
        value: newValue,
        isPositive: false,
        message: 'Warning: Counter reached -10! ⚠️',
      ));
    } else {
      emit(CounterUpdated(value: newValue));
    }
  }

}

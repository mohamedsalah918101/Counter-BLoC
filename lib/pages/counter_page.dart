import 'package:counter_cubit/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/counter_button.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  void _showDialog(BuildContext context, String message, bool isPositive) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              isPositive ? 'Congratulations!' : 'Warning',
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
              ),
            ),
            content: Text(message),
            icon: Icon(
              isPositive ? Icons.celebration : Icons.warning,
              color: isPositive ? Colors.green : Colors.red,
              size: 32,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<CounterCubit>().reset();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: Text('Reset Counter'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Counter 🎰', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<CounterCubit>().reset();
              },
              icon: Icon(Icons.refresh, color: Colors.white,))
        ],
      ),
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state is CounterMilestoneReached && state.message != null) {
            _showDialog(context, state.message!, state.isPositive);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Text(
                  'Counter: ${state.value}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: state is CounterMilestoneReached
                            ? (state.isPositive ? Colors.green : Colors.red)
                            : null,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 24,
                  children: [
                    CounterButton(
                      onPressed: () => context.read<CounterCubit>().decrement(),
                      icon: Icons.remove,
                      backgroundColor: Colors.red.shade100,
                      iconColor: Colors.red,
                    ),
                    CounterButton(
                      onPressed: () => context.read<CounterCubit>().decrement(),
                      icon: Icons.add,
                      backgroundColor: Colors.green.shade100,
                      iconColor: Colors.green,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

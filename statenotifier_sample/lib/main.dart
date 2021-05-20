import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statenotifier_sample/counter_state.dart';

final counterProvider =
    StateNotifierProvider<CounterStateNotifier, CounterState>(
        (ref) => CounterStateNotifier());

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('state_notifier sample'),
      ),
      body: Center(
        child: Consumer(builder: (context, watch, _) {
          final count = watch(counterProvider);
          print(count);
          return Text('$count');
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read(counterProvider.notifier).increment(),
        label: Text('1'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

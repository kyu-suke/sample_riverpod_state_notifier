import 'package:flutter/material.dart';
// import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:statenotifier_sample/counter_state.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final counterProvider = StateProvider((ref) => 0);
final counterProvider = StateNotifierProvider(
      (ref) => CounterStateNotifier(),
);

// void main() => runApp(MyApp());
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
    return MaterialApp(
      // home: StateNotifierProvider<CounterStateNotifier, CounterState>(
      //   create: (_) => CounterStateNotifier(),
      //   child: HomePage(),
      // ),
      home: HomePage()
    );
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
        // child: Text(
        //   context.select<CounterState, int>((state) => state.count).toString(),
        // ),
        child: Consumer(builder: (context, watch, _) {
          final count = watch(counterProvider).state;
          print("watch");
          return Text('$count');
        }),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read(counterProvider).increment(),
        label: Text('1'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

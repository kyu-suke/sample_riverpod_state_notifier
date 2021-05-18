import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

part 'counter_state.freezed.dart';

part 'counter_state.g.dart';

@freezed
abstract class CounterState with _$CounterState {
  factory CounterState({
    @Default(0) int count,
  }) = _CounterState;

  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);
}

class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier() : super(CounterState());

  void increment() => state = state.copyWith(count: state.count + 1);
}

// class TodoViewModel extends StateNotifier<TodoState> {
//   TodoViewModel() : super(const TodoState());
//
//   void createTodo(String title) {
//     final id = state.todoList.length + 1;
//     final newList = [...state.todoList, Todo(id, title)];
//     state = state.copyWith(todoList: newList);
//   }
//
//   void updateTodo(int id, String title) {
//     final newList = state.todoList
//         .map((todo) => todo.id == id ? Todo(id, title) : todo)
//         .toList();
//     state = state.copyWith(todoList: newList);
//   }
//
//   void deleteTodo(int id) {
//     final newList = state.todoList.where((todo) => todo.id != id).toList();
//     state = state.copyWith(todoList: newList);
//   }

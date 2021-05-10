import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: HomeScreen(),
    ),
  );
}

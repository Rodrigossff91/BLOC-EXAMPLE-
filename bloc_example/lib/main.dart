import 'package:bloc_example/counterBloc/page_bloc/bloc/counter_bloc.dart';
import 'package:bloc_example/counterBloc/page_bloc/counter_bloc_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counterBloc/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/bloc": (context) => BlocProvider(
            create: (context) => CounterBloc(), child: const CounterBlocPage())
      },
      home: const HomePage(),
    );
  }
}

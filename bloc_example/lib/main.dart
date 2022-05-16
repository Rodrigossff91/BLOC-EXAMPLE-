import 'package:bloc_example/counterBloc/page_bloc/bloc/counter_bloc.dart';
import 'package:bloc_example/counterBloc/page_bloc/counter_bloc_page.dart';
import 'package:bloc_example/counterBloc/page_cubit/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counterBloc/home_page.dart';
import 'counterBloc/page_cubit/counter_cubit_page.dart';

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
            create: (context) => CounterBloc(), child: const CounterBlocPage()),
        "/cubit": (context) => BlocProvider(
            create: (context) => CounterCubit(),
            child: const CounterCubitPage())
      },
      home: const HomePage(),
    );
  }
}

import 'package:bloc_example/counterBloc/page_bloc/bloc/counter_bloc.dart';
import 'package:bloc_example/counterBloc/page_bloc/counter_bloc_page.dart';
import 'package:bloc_example/counterBloc/page_cubit/cubit/counter_cubit.dart';
import 'package:bloc_example/features/bloc_example/bloc/example_bloc.dart';
import 'package:bloc_example/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:bloc_example/features/bloc_example/bloc_freezed_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counterBloc/page_cubit/counter_cubit_page.dart';
import 'features/bloc_example/bloc_example.dart';
import 'home/home_page.dart';

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
            child: const CounterCubitPage()),
        "/bloc/example": (context) => BlocProvider(
            create: (context) => ExampleBloc()..add(ExampleFindNameEvent()),
            child: const BlocExamplepPage()),
        "/bloc/example/freezed": (context) => BlocProvider(
            create: (context) => ExampleFreezedBloc()
              ..add(const ExampleFreezedEvent.findNames()),
            child: const BlocFreezedExample())
      },
      home: const HomePage(),
    );
  }
}

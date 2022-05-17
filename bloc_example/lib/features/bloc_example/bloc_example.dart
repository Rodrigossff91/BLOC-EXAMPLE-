import 'dart:developer';

import 'package:bloc_example/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExamplepPage extends StatelessWidget {
  const BlocExamplepPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Example'),
        ),
        // BLOC LISTENER ESCUTA AS ALTERAÇOES DE STATE
        // LISTENERWHEN PODE SER USADO PARA FAZER A LOGICA E QUANDO SERA DISPARADO O LISTNER
        body: BlocListener<ExampleBloc, ExampleState>(
          // bloc: ExampleBloc(),
          listenWhen: (previous, current) {
            if (previous is ExampleStateInitial &&
                current is ExampleStateData) {
              if (current.names.length > 3) {
                return true;
              }
              return false;
            }
            return false;
          },
          listener: (context, state) {
            if (state is ExampleStateData) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("A quantidade de novo é de ${state.names.length}")));
            }
          },
          child: Column(
            children: [
              // BLOC CONSUMER ESCUTA AS ALTERAÇOES DE STATE E REBUILDA A TELA
              BlocConsumer<ExampleBloc, ExampleState>(
                // bloc: ExampleBloc(),
                listenWhen: (previous, current) {
                  if (previous is ExampleStateInitial &&
                      current is ExampleStateData) {
                    if (current.names.length > 3) {
                      return true;
                    }
                    return false;
                  }
                  return false;
                },
                buildWhen: (previous, current) {
                  if (previous is ExampleStateInitial &&
                      current is ExampleStateData) {
                    if (current.names.length > 3) {
                      return true;
                    }
                    return false;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is ExampleStateData) {
                    return Text("Total de nomes é ${state.names.length}");
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {
                  log("Estado alterado");
                },
              ),
              // BLOC SELECTOR ESCUTA AS ALTERAÇOES DE STATE E REBUILDA A TELA E RETORNAR UMA TIPO ESPECIFICO SEM PRECISAR VERIFICAR , SEPARANDO A LOGICA DO BUILDER EM SI
              BlocSelector<ExampleBloc, ExampleState, bool>(
                // bloc: ExampleBloc(),
                selector: (state) {
                  if (state is ExampleStateInitial) {
                    return true;
                  }
                  return false;
                },
                builder: (context, showLoader) {
                  if (showLoader) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocSelector<ExampleBloc, ExampleState, List<String>>(
                  // bloc: ExampleBloc(),
                  selector: (state) {
                if (state is ExampleStateData) {
                  return state.names;
                }
                return [];
              }, builder: (context, names) {
                return ListView.builder(
                    itemCount: names.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            context.read<ExampleBloc>().add(
                                ExampleRemoveNameEvent(name: names[index]));
                          },
                          child: Row(
                            children: [
                              Text(names[index]),
                            ],
                          ),
                        ),
                      );
                    });
              }),
              // BLOC BUILDER BUILDA A TELA
              // BlocBuilder<ExampleBloc, ExampleState>(
              //   // bloc: ExampleBloc(),
              //   builder: (context, state) {
              //     if (state is ExampleStateData) {
              //       return ListView.builder(
              //           itemCount: state.names.length,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.all(20.0),
              //               child: Row(
              //                 children: [
              //                   Text(state.names[index]),
              //                 ],
              //               ),
              //             );
              //           });
              //     }
              //     return const SizedBox.shrink();
              //   },
              // ),
            ],
          ),
        ));
  }
}

import 'package:bloc_example/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Freezed'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text("+"),
          onPressed: (() {
            context
                .read<ExampleFreezedBloc>()
                .add(const ExampleFreezedEvent.addName("aAAAAA"));
          })),
      body: BlocListener<ExampleFreezedBloc, ExampleFreezedState>(
        listener: (context, state) {
          state.whenOrNull(
            showBanner: (_, message) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        child: Column(
          children: [
            BlocSelector<ExampleFreezedBloc, ExampleFreezedState, bool>(
              // bloc: ExampleBloc(),
              selector: (state) {
                return state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );
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
            BlocSelector<ExampleFreezedBloc, ExampleFreezedState, List<String>>(
                selector: (state) {
              return state.maybeWhen(
                  showBanner: (names, message) => names,
                  data: (names) => names,
                  orElse: () => <String>[]);
            }, builder: (context, names) {
              return ListView.builder(
                  itemCount: names.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<ExampleFreezedBloc>().add(
                              ExampleFreezedEvent.removeName(names[index]));
                        },
                        child: Row(
                          children: [
                            Text(names[index]),
                          ],
                        ),
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:hello_web3/l10n/l10n.dart';

class HelloView extends StatelessWidget {
  const HelloView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: BlocConsumer<HelloBloc, HelloState>(
        listenWhen: (prev, curr) => prev.status != curr.status && curr.hasError,
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorMessage)),
          );
        },
        builder: (context, state) {
          if (state.hasData) {
            return const HelloDataContent();
          } else if (state.hasError) {
            return const HelloErrorContent();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

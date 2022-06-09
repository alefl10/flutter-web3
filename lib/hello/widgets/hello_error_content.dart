import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:hello_web3/l10n/l10n.dart';

class HelloErrorContent extends StatelessWidget {
  const HelloErrorContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((HelloBloc bloc) => bloc.state);

    return Center(
      child: state.isLoading
          ? const CircularProgressIndicator()
          : const TryAgainButton(),
    );
  }
}

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: ElevatedButton(
        onPressed: () {
          context.read<HelloBloc>().add(HelloNameRequested());
        },
        child: Text(context.l10n.tryAgainLabel),
      ),
    );
  }
}

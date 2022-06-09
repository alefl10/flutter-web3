import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:hello_web3/l10n/l10n.dart';

class HelloDataContent extends StatelessWidget {
  const HelloDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((HelloBloc bloc) => bloc.state);
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Text(
          l10n.helloWord,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 16),
        Text(
          '${state.name}',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          const SetNameButton(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final hashIndex = (state.txHashes.length - 1) - index;
              return ListTile(
                title: Text('${l10n.transactionWord} ${hashIndex + 1}'),
                subtitle: Text(state.txHashes[hashIndex]),
              );
            },
            itemCount: state.txHashes.length,
          ),
        ),
      ],
    );
  }
}

class SetNameButton extends StatelessWidget {
  const SetNameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: ElevatedButton(
        onPressed: () {
          context.read<HelloBloc>().add(HelloRandomNameSet());
        },
        child: Text(context.l10n.setNameLabel),
      ),
    );
  }
}

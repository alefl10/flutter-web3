import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';
import 'package:username_generator/username_generator.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelloBloc(
        smartContractRepository: context.read<SmartContractRepository>(),
        usernameGenerator: UsernameGenerator(),
      )..add(HelloNameRequested()),
      child: const HelloView(),
    );
  }
}

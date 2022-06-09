import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:username_generator/username_generator.dart';
import 'package:web_three_repository/web_three_repository.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelloBloc(
        webThreeRepository: context.read<WebThreeRepository>(),
        usernameGenerator: UsernameGenerator(),
      )..add(HelloNameRequested()),
      child: const HelloView(),
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:username_generator/username_generator.dart';
import 'package:web_three_repository/web_three_repository.dart';

part 'hello_event.dart';
part 'hello_state.dart';

class HelloBloc extends Bloc<HelloEvent, HelloState> {
  HelloBloc({
    required WebThreeRepository webThreeRepository,
    required UsernameGenerator usernameGenerator,
  })  : _webThreeRepository = webThreeRepository,
        _usernameGenerator = usernameGenerator,
        super(const HelloState()) {
    on<HelloNameRequested>(_nameRequested);
    on<HelloRandomNameSet>(_randomNameSet);
  }

  final WebThreeRepository _webThreeRepository;
  final UsernameGenerator _usernameGenerator;

  FutureOr<void> _nameRequested(
    HelloNameRequested event,
    Emitter<HelloState> emit,
  ) async {
    emit(state.copyWith(status: HelloAsyncStatus.loading));

    try {
      final name = await _webThreeRepository.getName();
      emit(state.copyWith(status: HelloAsyncStatus.success, name: name));
    } catch (e, s) {
      addError(e, s);
      emit(state.copyWith(status: HelloAsyncStatus.error));
    }
  }

  FutureOr<void> _randomNameSet(
    HelloRandomNameSet event,
    Emitter<HelloState> emit,
  ) async {
    emit(state.copyWith(status: HelloAsyncStatus.loading));
    try {
      final name = _usernameGenerator.generateRandom();
      final txHash = await _webThreeRepository.setName(name: name);
      emit(
        state.copyWith(
          name: name,
          txHashes: [...state.txHashes, txHash],
          status: HelloAsyncStatus.success,
        ),
      );
    } catch (e, s) {
      addError(e, s);
      emit(state.copyWith(status: HelloAsyncStatus.error));
    }
  }
}

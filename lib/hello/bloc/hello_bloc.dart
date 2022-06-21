import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';
import 'package:username_generator/username_generator.dart';

part 'hello_event.dart';
part 'hello_state.dart';

class HelloBloc extends Bloc<HelloEvent, HelloState> {
  HelloBloc({
    required SmartContractRepository smartContractRepository,
    required UsernameGenerator usernameGenerator,
  })  : _smartContractRepository = smartContractRepository,
        _usernameGenerator = usernameGenerator,
        super(const HelloState()) {
    on<HelloNameRequested>(_nameRequested);
    on<HelloRandomNameSet>(_randomNameSet);
  }

  final SmartContractRepository _smartContractRepository;
  final UsernameGenerator _usernameGenerator;

  FutureOr<void> _nameRequested(
    HelloNameRequested event,
    Emitter<HelloState> emit,
  ) async {
    emit(state.copyWith(status: HelloAsyncStatus.loading));

    try {
      final name = await _smartContractRepository.getName();
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
      final txHash = await _smartContractRepository.setName(name: name);
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

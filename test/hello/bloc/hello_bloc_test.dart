import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:mocktail/mocktail.dart';
import 'package:username_generator/username_generator.dart';
import 'package:web_three_repository/web_three_repository.dart';

import '../../helpers/helpers.dart';

class MockUsernameGenerator extends Mock implements UsernameGenerator {}

void main() {
  group('HelloBloc', () {
    const name = 'alefldev';
    late WebThreeRepository webThreeRepository;
    late UsernameGenerator usernameGenerator;

    setUp(() {
      webThreeRepository = MockWebThreeRepository();
      usernameGenerator = MockUsernameGenerator();
    });

    HelloBloc buildBloc() => HelloBloc(
          webThreeRepository: webThreeRepository,
          usernameGenerator: usernameGenerator,
        );

    test('emits correct initial state ', () {
      expect(
        HelloBloc(
          webThreeRepository: webThreeRepository,
          usernameGenerator: usernameGenerator,
        ).state,
        const HelloState(),
      );
    });

    group('HelloNameRequested', () {
      blocTest<HelloBloc, HelloState>(
        'emits successful state with correct name on .getName',
        setUp: () {
          when(() => webThreeRepository.getName()).thenAnswer(
            (_) async => name,
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(HelloNameRequested()),
        expect: () => const <HelloState>[
          HelloState(status: HelloAsyncStatus.loading),
          HelloState(status: HelloAsyncStatus.success, name: name),
        ],
      );

      blocTest<HelloBloc, HelloState>(
        'emits error state on .getName exception',
        setUp: () {
          when(() => webThreeRepository.getName()).thenThrow(
            const WebThreeRepositoryException(''),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(HelloNameRequested()),
        expect: () => const <HelloState>[
          HelloState(status: HelloAsyncStatus.loading),
          HelloState(status: HelloAsyncStatus.error),
        ],
      );
    });

    group('HelloNameRequested', () {
      const transaction = 'transaction';

      blocTest<HelloBloc, HelloState>(
        'emits successful state with correct name and transaction on .setName',
        setUp: () {
          when(() => usernameGenerator.generateRandom()).thenReturn(name);
          when(() => webThreeRepository.setName(name: any(named: 'name')))
              .thenAnswer(
            (_) async => transaction,
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(HelloRandomNameSet()),
        expect: () => const <HelloState>[
          HelloState(status: HelloAsyncStatus.loading),
          HelloState(
            status: HelloAsyncStatus.success,
            name: name,
            txHashes: [transaction],
          ),
        ],
      );

      blocTest<HelloBloc, HelloState>(
        'emits error state on .setName exception',
        setUp: () {
          when(() => webThreeRepository.setName(name: any(named: 'name')))
              .thenThrow(const WebThreeRepositoryException(''));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(HelloRandomNameSet()),
        expect: () => const <HelloState>[
          HelloState(status: HelloAsyncStatus.loading),
          HelloState(status: HelloAsyncStatus.error),
        ],
      );
    });
  });
}

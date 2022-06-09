import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockHelloBloc extends MockBloc<HelloEvent, HelloState>
    implements HelloBloc {}

void main() {
  group('HelloView', () {
    late HelloBloc helloBloc;

    setUp(() {
      helloBloc = MockHelloBloc();
    });

    group('renders', () {
      testWidgets('HelloDataContent when there is data', (tester) async {
        when(() => helloBloc.state).thenReturn(
          const HelloState(
            status: HelloAsyncStatus.success,
            name: 'alefldev',
            txHashes: ['transaction1'],
          ),
        );
        await tester.pumpHelloView(helloBloc: helloBloc);
        expect(find.byType(HelloDataContent), findsOneWidget);
      });

      testWidgets('HelloErrorContent when there is an error', (tester) async {
        when(() => helloBloc.state).thenReturn(
          const HelloState(status: HelloAsyncStatus.error),
        );
        await tester.pumpHelloView(helloBloc: helloBloc);
        expect(find.byType(HelloErrorContent), findsOneWidget);
      });

      testWidgets(
        'CircularProgressIndicator when status is loading',
        (tester) async {
          when(() => helloBloc.state).thenReturn(
            const HelloState(status: HelloAsyncStatus.loading),
          );
          await tester.pumpHelloView(helloBloc: helloBloc);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );
    });

    group('shows', () {
      testWidgets('SnackBar on error', (tester) async {
        whenListen(
          helloBloc,
          Stream.value(
            const HelloState(status: HelloAsyncStatus.error),
          ),
          initialState: const HelloState(status: HelloAsyncStatus.loading),
        );
        await tester.pumpHelloView(helloBloc: helloBloc);
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOneWidget);
      });
    });
  });
}

extension on WidgetTester {
  Future<void> pumpHelloView({required HelloBloc helloBloc}) {
    return pumpApp(
      BlocProvider.value(
        value: helloBloc,
        child: const HelloView(),
      ),
    );
  }
}

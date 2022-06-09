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
  group('HelloErrorContent', () {
    late HelloBloc helloBloc;

    setUp(() {
      helloBloc = MockHelloBloc();
    });

    testWidgets(
      'renders CircularProgressIndicator when status is loading',
      (tester) async {
        when(() => helloBloc.state).thenReturn(
          const HelloState(status: HelloAsyncStatus.loading),
        );
        await tester.pumpHelloErrorContent(helloBloc: helloBloc);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'adds HelloRandomNameSet on TryAgainButton tap',
      (tester) async {
        when(() => helloBloc.state).thenReturn(
          const HelloState(status: HelloAsyncStatus.error),
        );
        await tester.pumpHelloErrorContent(helloBloc: helloBloc);
        await tester.tap(find.byType(TryAgainButton));
        verify(() => helloBloc.add(HelloNameRequested())).called(1);
      },
    );
  });
}

extension on WidgetTester {
  Future<void> pumpHelloErrorContent({required HelloBloc helloBloc}) {
    return pumpApp(
      BlocProvider.value(
        value: helloBloc,
        child: const HelloErrorContent(),
      ),
    );
  }
}

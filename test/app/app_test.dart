import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_web3/app/app.dart';
import 'package:hello_web3/hello/hello.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';

import '../helpers/helpers.dart';

class MockHelloBloc extends MockBloc<HelloEvent, HelloState>
    implements HelloBloc {}

void main() {
  group('App', () {
    late SmartContractRepository smartContractRepository;

    setUp(() {
      smartContractRepository = MockSmartContractRepository();
    });

    testWidgets('renders AppView', (tester) async {
      await tester
          .pumpWidget(App(smartContractRepository: smartContractRepository));
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late HelloBloc helloBloc;

    setUp(() {
      helloBloc = MockHelloBloc();
      when(() => helloBloc.state).thenReturn(
        const HelloState(status: HelloAsyncStatus.success),
      );
    });

    testWidgets('renders HelloPage', (tester) async {
      await tester.pumpAppView(helloBloc: helloBloc);
      expect(find.byType(HelloPage), findsOneWidget);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpAppView({required HelloBloc helloBloc}) {
    return pumpApp(
      BlocProvider.value(
        value: helloBloc,
        child: const AppView(),
      ),
    );
  }
}

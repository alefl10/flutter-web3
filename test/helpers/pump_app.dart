import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_web3/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';

class MockSmartContractRepository extends Mock
    implements SmartContractRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    SmartContractRepository? smartContractRepository,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: smartContractRepository ?? MockSmartContractRepository(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }
}

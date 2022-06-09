import 'package:flutter_test/flutter_test.dart';
import 'package:hello_web3/hello/hello.dart';

void main() {
  group('HelloState', () {
    test('supports value comparison', () {
      const stateA = HelloState();
      final stateB = stateA.copyWith();
      final stateC = stateA.copyWith(status: HelloAsyncStatus.error);
      expect(stateA, stateB);
      expect(stateA, isNot(stateC));
    });
  });
}

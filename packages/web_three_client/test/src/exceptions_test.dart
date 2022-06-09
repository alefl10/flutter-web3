import 'package:flutter_test/flutter_test.dart';
import 'package:web_three_client/web_three_client.dart';

void main() {
  group('WebThreeClientException', () {
    test('toString prints expected text', () {
      expect(
        const WebThreeClientException('test').toString(),
        'WebThreeClientException -> test',
      );
    });
  });

  group('SmartContractException', () {
    test('toString prints expected text', () {
      expect(
        const SmartContractException('test').toString(),
        'SmartContractException: Failed to create SmartContract -> test',
      );
    });
  });
}

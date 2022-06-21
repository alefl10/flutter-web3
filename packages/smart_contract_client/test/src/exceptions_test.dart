import 'package:smart_contract_client/smart_contract_client.dart';
import 'package:test/test.dart';

void main() {
  group('SmartContractClientException', () {
    test('toString prints expected text', () {
      expect(
        const SmartContractClientException('test').toString(),
        'SmartContractClientException -> test',
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

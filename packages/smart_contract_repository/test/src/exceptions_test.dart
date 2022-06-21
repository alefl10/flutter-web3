import 'package:smart_contract_repository/smart_contract_repository.dart';
import 'package:test/test.dart';

void main() {
  group('SmartContractRepositoryException', () {
    test('toString prints expected text', () {
      expect(
        const SmartContractRepositoryException('test').toString(),
        'SmartContractRepositoryException -> test',
      );
    });
  });
}

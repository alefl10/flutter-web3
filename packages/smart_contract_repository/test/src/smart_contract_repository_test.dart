// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:smart_contract_client/smart_contract_client.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';
import 'package:test/test.dart';

class MockSmartContractClient extends Mock implements SmartContractClient {}

void main() {
  group('SmartContractRepository', () {
    const name = 'name';
    late SmartContractClient smartContractClient;
    late SmartContractRepository smartContractRepository;

    setUp(() {
      smartContractClient = MockSmartContractClient();
      smartContractRepository =
          SmartContractRepository(client: smartContractClient);
    });

    test('can be instantiated', () {
      expect(SmartContractRepository(client: smartContractClient), isNotNull);
    });

    group('getName', () {
      test('returns the expected name value', () {
        when(() => smartContractClient.getName()).thenAnswer(
          (_) async => Future.value(name),
        );
        expect(smartContractRepository.getName(), completion(name));
      });

      test('throws SmartContractRepositoryException on any Exception', () {
        when(() => smartContractClient.getName()).thenThrow(Exception());
        expect(
          smartContractRepository.getName(),
          throwsA(isA<SmartContractRepositoryException>()),
        );
      });
    });

    group('setName', () {
      test('completes successfully', () {
        const transactionHash = 'transactionHash';
        when(() => smartContractClient.setName(name: any(named: 'name')))
            .thenAnswer(
          (_) async => Future.value(transactionHash),
        );
        expect(
          smartContractRepository.setName(name: name),
          completion(transactionHash),
        );
      });

      test('throws SmartContractRepositoryException on any Exception', () {
        when(() => smartContractClient.setName(name: any(named: 'name')))
            .thenThrow(
          Exception(),
        );
        expect(
          smartContractRepository.setName(name: name),
          throwsA(isA<SmartContractRepositoryException>()),
        );
      });
    });
  });
}

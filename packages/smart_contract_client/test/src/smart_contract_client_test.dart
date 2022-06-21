// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:smart_contract_client/smart_contract_client.dart';
import 'package:test/test.dart';
import 'package:web3dart/web3dart.dart';

import '../helper/helper.dart';
// import 'package:smart_contract_client/smart_contract_client.dart';

class MockWeb3Client extends Mock implements Web3Client {}

class FakeDeployedContract extends Fake implements DeployedContract {}

class FakeContractFunction extends Fake implements ContractFunction {}

class FakeCredentials extends Fake implements Credentials {}

class FakeTransaction extends Fake implements Transaction {}

void main() {
  group('SmartContractClient', () {
    late Web3Client web3client;
    late SmartContractClient smartContractClient;
    const abi = abiData;
    const privateKey = privateKeyData;

    setUp(() {
      web3client = MockWeb3Client();
      smartContractClient = SmartContractClient(
        abi: abi,
        contractAddress: contractAddress,
        privateKey: privateKey,
        web3client: web3client,
      );
    });

    setUpAll(() {
      registerFallbackValue(FakeDeployedContract());
      registerFallbackValue(FakeContractFunction());
      registerFallbackValue(FakeCredentials());
      registerFallbackValue(Transaction());
    });

    test('can be instantiated', () {
      expect(
        SmartContractClient(
          abi: abi,
          contractAddress: contractAddress,
          privateKey: privateKey,
          web3client: web3client,
        ),
        isNotNull,
      );
    });

    group('getName', () {
      test('returns expected name', () async {
        const name = 'name';
        when(
          () => web3client.call(
            contract: any(named: 'contract'),
            function: any(named: 'function'),
            params: any(named: 'params'),
          ),
        ).thenAnswer((_) async => <dynamic>[name]);

        expect(smartContractClient.getName(), completion(name));
      });

      test(
        'throws SmartContractClientException on SmartContractException',
        () async {
          // Invalid data Strings
          final smartContractClient = SmartContractClient(
            abi: 'abi',
            contractAddress: 'contractAddress',
            privateKey: 'privateKey',
            web3client: web3client,
          );

          expect(
            smartContractClient.getName(),
            throwsA(isA<SmartContractClientException>()),
          );
        },
      );

      test('throws SmartContractClientException on any Exception', () async {
        when(
          () => web3client.call(
            contract: any(named: 'contract'),
            function: any(named: 'function'),
            params: any(named: 'params'),
          ),
        ).thenThrow(Exception());

        expect(
          smartContractClient.getName(),
          throwsA(isA<SmartContractClientException>()),
        );
      });
    });

    group('setName', () {
      test('completes successfully', () async {
        const transactionHash = 'transactionHash';
        when(
          () => web3client.sendTransaction(any(), any()),
        ).thenAnswer((_) => Future.value(transactionHash));

        expect(
          smartContractClient.setName(name: ''),
          completion(transactionHash),
        );
      });

      test('throws SmartContractClientException on any Exception', () async {
        when(
          () => web3client.call(
            contract: any(named: 'contract'),
            function: any(named: 'function'),
            params: any(named: 'params'),
          ),
        ).thenThrow(Exception());

        expect(
          smartContractClient.setName(name: ''),
          throwsA(isA<SmartContractClientException>()),
        );
      });
    });
  });
}

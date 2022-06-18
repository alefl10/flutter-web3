// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_three_client/web_three_client.dart';

import '../helper/helper.dart';
// import 'package:web_three_client/web_three_client.dart';

class MockWeb3Client extends Mock implements Web3Client {}

class FakeDeployedContract extends Fake implements DeployedContract {}

class FakeContractFunction extends Fake implements ContractFunction {}

class FakeCredentials extends Fake implements Credentials {}

class FakeTransaction extends Fake implements Transaction {}

void main() {
  group('WebThreeClient', () {
    late Web3Client web3client;
    late WebThreeClient webThreeClient;
    const abi = abiData;
    const privateKey = privateKeyData;

    setUp(() {
      web3client = MockWeb3Client();
      webThreeClient = WebThreeClient(
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
        WebThreeClient(
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

        expect(webThreeClient.getName(), completion(name));
      });

      test(
        'throws WebThreeClientException on SmartContractException',
        () async {
          // Invalid data Strings
          final webThreeClient = WebThreeClient(
            abi: 'abi',
            contractAddress: 'contractAddress',
            privateKey: 'privateKey',
            web3client: web3client,
          );

          expect(
            webThreeClient.getName(),
            throwsA(isA<WebThreeClientException>()),
          );
        },
      );

      test('throws WebThreeClientException on any Exception', () async {
        when(
          () => web3client.call(
            contract: any(named: 'contract'),
            function: any(named: 'function'),
            params: any(named: 'params'),
          ),
        ).thenThrow(Exception());

        expect(
          webThreeClient.getName(),
          throwsA(isA<WebThreeClientException>()),
        );
      });
    });

    group('setName', () {
      test('completes successfully', () async {
        const transactionHash = 'transactionHash';
        when(
          () => web3client.sendTransaction(any(), any()),
        ).thenAnswer((_) => Future.value(transactionHash));

        expect(webThreeClient.setName(name: ''), completion(transactionHash));
      });

      test('throws WebThreeClientException on any Exception', () async {
        when(
          () => web3client.call(
            contract: any(named: 'contract'),
            function: any(named: 'function'),
            params: any(named: 'params'),
          ),
        ).thenThrow(Exception());

        expect(
          webThreeClient.setName(name: ''),
          throwsA(isA<WebThreeClientException>()),
        );
      });
    });
  });
}

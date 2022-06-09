// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_three_client/web_three_client.dart';
import 'package:web_three_repository/web_three_repository.dart';

class MockWebThreeClient extends Mock implements WebThreeClient {}

void main() {
  group('WebThreeRepository', () {
    const name = 'name';
    late WebThreeClient webThreeClient;
    late WebThreeRepository webThreeRepository;

    setUp(() {
      webThreeClient = MockWebThreeClient();
      webThreeRepository = WebThreeRepository(client: webThreeClient);
    });

    test('can be instantiated', () {
      expect(WebThreeRepository(client: webThreeClient), isNotNull);
    });

    group('getName', () {
      test('returns the expected name value', () {
        when(() => webThreeClient.getName()).thenAnswer(
          (_) async => Future.value(name),
        );
        expect(webThreeRepository.getName(), completion(name));
      });

      test('throws WebThreeRepositoryException on any Exception', () {
        when(() => webThreeClient.getName()).thenThrow(Exception());
        expect(
          webThreeRepository.getName(),
          throwsA(isA<WebThreeRepositoryException>()),
        );
      });
    });

    group('setName', () {
      test('completes successfully', () {
        const transactionHash = 'transactionHash';
        when(() => webThreeClient.setName(name: any(named: 'name'))).thenAnswer(
          (_) async => Future.value(transactionHash),
        );
        expect(
          webThreeRepository.setName(name: name),
          completion(transactionHash),
        );
      });

      test('throws WebThreeRepositoryException on any Exception', () {
        when(() => webThreeClient.setName(name: any(named: 'name'))).thenThrow(
          Exception(),
        );
        expect(
          webThreeRepository.setName(name: name),
          throwsA(isA<WebThreeRepositoryException>()),
        );
      });
    });
  });
}

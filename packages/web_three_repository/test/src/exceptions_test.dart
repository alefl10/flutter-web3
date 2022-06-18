import 'package:test/test.dart';
import 'package:web_three_repository/web_three_repository.dart';

void main() {
  group('WebThreeRepositoryException', () {
    test('toString prints expected text', () {
      expect(
        const WebThreeRepositoryException('test').toString(),
        'WebThreeRepositoryException -> test',
      );
    });
  });
}

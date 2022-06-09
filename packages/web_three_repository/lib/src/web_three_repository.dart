import 'package:web_three_client/web_three_client.dart';
import 'package:web_three_repository/web_three_repository.dart';

/// {@template web_three_repository}
/// Repository to interact with [WebThreeClient]
/// {@endtemplate}
class WebThreeRepository {
  /// {@macro web_three_repository}
  const WebThreeRepository({required WebThreeClient client}) : _client = client;

  final WebThreeClient _client;

  /// It gets the name from the [SmartContract].
  Future<String> getName() async {
    try {
      return _client.getName();
    } catch (e) {
      throw WebThreeRepositoryException(e);
    }
  }

  /// Sets the name of the [SmartContract].
  Future<String> setName({required String name}) async {
    try {
      return _client.setName(name: name);
    } catch (e) {
      throw WebThreeRepositoryException(e);
    }
  }
}

import 'package:smart_contract_client/smart_contract_client.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';

/// {@template smart_contract_repository}
/// Repository to interact with [SmartContractClient]
/// {@endtemplate}
class SmartContractRepository {
  /// {@macro smart_contract_repository}
  const SmartContractRepository({required SmartContractClient client})
      : _client = client;

  final SmartContractClient _client;

  /// It gets the name from the [SmartContract].
  Future<String> getName() async {
    try {
      return _client.getName();
    } catch (e) {
      throw SmartContractRepositoryException(e);
    }
  }

  /// Sets the name of the [SmartContract].
  Future<String> setName({required String name}) async {
    try {
      return _client.setName(name: name);
    } catch (e) {
      throw SmartContractRepositoryException(e);
    }
  }
}

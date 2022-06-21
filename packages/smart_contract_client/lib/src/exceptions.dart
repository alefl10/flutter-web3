import 'package:smart_contract_client/smart_contract_client.dart';

/// {@template smart_contract_client_exception}
/// [Exception] thrown when any [SmartContractClient] methods fail.
/// {@endtemplate}
class SmartContractClientException implements Exception {
  /// {@macro smart_contract_client_exception}
  const SmartContractClientException(this.originalException);

  /// Original [Exception].
  final Object originalException;

  @override
  String toString() =>
      'SmartContractClientException -> ${originalException.toString()}';
}

/// {@template smart_contract_exception}
/// [Exception] thrown when instantiating a [SmartContract]
/// via [SmartContract.fromData].
/// {@endtemplate}
class SmartContractException implements Exception {
  /// {@macro smart_contract_exception}
  const SmartContractException(this.originalException);

  /// Original [Exception].
  final Object originalException;

  @override
  String toString() =>
      'SmartContractException: Failed to create SmartContract -> '
      '${originalException.toString()}';
}

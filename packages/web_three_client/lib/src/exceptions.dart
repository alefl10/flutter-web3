import 'package:web_three_client/web_three_client.dart';

/// {@template web_three_client_exception}
/// [Exception] thrown when any [WebThreeClient] methods fail.
/// {@endtemplate}
class WebThreeClientException implements Exception {
  /// {@macro web_three_client_exception}
  const WebThreeClientException(this.originalException);

  /// Original [Exception].
  final Object originalException;

  @override
  String toString() =>
      'WebThreeClientException -> ${originalException.toString()}';
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

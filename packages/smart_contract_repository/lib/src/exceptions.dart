import 'package:smart_contract_repository/smart_contract_repository.dart';

/// {@template smart_contract_repository_exception}
/// [Exception] thrown when any [SmartContractRepository] methods fail.
/// {@endtemplate}
class SmartContractRepositoryException implements Exception {
  /// {@macro smart_contract_repository_exception}
  const SmartContractRepositoryException(this.originalException);

  /// Original [Exception].
  final Object originalException;

  @override
  String toString() =>
      'SmartContractRepositoryException -> ${originalException.toString()}';
}

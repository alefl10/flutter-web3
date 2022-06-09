import 'package:web_three_repository/web_three_repository.dart';

/// {@template web_three_repository_exception}
/// [Exception] thrown when any [WebThreeRepository] methods fail.
/// {@endtemplate}
class WebThreeRepositoryException implements Exception {
  /// {@macro web_three_repository_exception}
  const WebThreeRepositoryException(this.originalException);

  /// Original [Exception].
  final Object originalException;

  @override
  String toString() =>
      'WebThreeRepositoryException -> ${originalException.toString()}';
}

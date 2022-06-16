import 'package:flutter_dotenv/flutter_dotenv.dart';

extension DotEnvX on DotEnv {
  String get privateKey => env['PRIVATE_KEY']!;

  String get contractAddress => env['CONTRACT_ADDRESS']!;

  String get rcpUrl => env['RCP_URL']!;

  String get wsUrl => env['WS_URL']!;
}

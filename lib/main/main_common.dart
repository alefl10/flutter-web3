import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hello_web3/app/app.dart';
import 'package:hello_web3/extensions/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_three_client/web_three_client.dart';
import 'package:web_three_repository/web_three_repository.dart';

Future<Widget> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  final abi = await rootBundle.loadString('src/artifacts/HelloWeb3.json');
  await dotenv.load();

  final web3Client = Web3Client(
    dotenv.rcpUrl,
    http.Client(),
    socketConnector: () =>
        IOWebSocketChannel.connect(dotenv.wsUrl).cast<String>(),
  );

  final webThreeClient = WebThreeClient(
    web3client: web3Client,
    privateKey: dotenv.privateKey,
    abi: abi,
  );

  final webThreeRepository = WebThreeRepository(client: webThreeClient);

  return App(webThreeRepository: webThreeRepository);
}

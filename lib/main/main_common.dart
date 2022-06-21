import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hello_web3/app/app.dart';
import 'package:hello_web3/extensions/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:smart_contract_client/smart_contract_client.dart';
import 'package:smart_contract_repository/smart_contract_repository.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

Future<Widget> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  final abi = await rootBundle.loadString('web3/artifacts/HelloWeb3.json');
  await dotenv.load();

  final web3Client = Web3Client(
    dotenv.rcpUrl,
    http.Client(),
    socketConnector: () =>
        IOWebSocketChannel.connect(dotenv.wsUrl).cast<String>(),
  );

  final smartContractClient = SmartContractClient(
    abi: abi,
    privateKey: dotenv.privateKey,
    contractAddress: dotenv.contractAddress,
    web3client: web3Client,
  );

  final smartContractRepository =
      SmartContractRepository(client: smartContractClient);

  return App(smartContractRepository: smartContractRepository);
}

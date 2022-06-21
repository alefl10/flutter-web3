import 'package:smart_contract_client/smart_contract_client.dart';
import 'package:web3dart/web3dart.dart';

/// {@template smart_contract_client}
/// Class wrapping around [SmartContractClient].
/// It abstracts away the creation of [DeployedContract] and [ContractFunction].
///
/// It exposes methods to interact and communicate with
/// the deployed [SmartContract].
///
/// {@endtemplate}
class SmartContractClient {
  /// {@macro smart_contract_client}
  SmartContractClient({
    required Web3Client web3client,
    required String privateKey,
    required String abi,
    required String contractAddress,
  })  : _web3Client = web3client,
        _privateKey = privateKey,
        _abi = abi,
        _contractAddress = contractAddress;

  SmartContract get _contract => SmartContract.fromData(
        abiInfo: _abi,
        privateKey: _privateKey,
        contractAddress: _contractAddress,
      );

  final Web3Client _web3Client;
  final String _privateKey;
  final String _abi;
  final String _contractAddress;

  /// It gets the name from the contract.
  ///
  /// It throws a [SmartContractClientException] on any given [Exception].
  Future<String> getName() async {
    // Getting the current name declared in the smart contract.
    try {
      final name = await _web3Client.call(
        contract: _contract,
        function: _contract.getName(),
        params: <dynamic>[],
      );

      return name[0] as String;
    } catch (e) {
      throw SmartContractClientException(e);
    }
  }

  /// Sets the name of the contract to the passed [name] value.
  ///
  /// It throws a [SmartContractClientException] on any given [Exception].
  Future<String> setName({required String name}) async {
    try {
      // Setting the name to name(name defined by user)
      final transactionHash = await _web3Client.sendTransaction(
        _contract.credentials,
        Transaction.callContract(
          contract: _contract,
          function: _contract.setName(),
          parameters: <dynamic>[name],
        ),
      );
      return transactionHash;
    } catch (e) {
      throw SmartContractClientException(e);
    }
  }
}

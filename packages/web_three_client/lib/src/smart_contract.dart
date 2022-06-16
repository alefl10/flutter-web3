import 'dart:convert';

import 'package:web3dart/web3dart.dart';
import 'package:web_three_client/web_three_client.dart';

/// {@template smart_contract}
/// Class extending around [DeployedContract].
/// It simplifies the creation of a [Web3Client] contract
/// and its [ContractFunction].
///
/// To instantiate this class, use its
/// factory constructor [SmartContract.fromData].
/// {@endtemplate}
class SmartContract extends DeployedContract {
  /// {@macro smart_contract}
  SmartContract._(
    super.abi,
    super.address,
    this.credentials,
  );

  /// {@template set_name}
  /// Factory constructor to instantiate a [SmartContract].
  ///
  /// [abiInfo] includes the information about the [DeployedContract] ABI
  /// (Application Binary Interface).
  ///
  /// [privateKey] is the [DeployedContract] private key data.
  /// {@endtemplate}
  factory SmartContract.fromData({
    required String abiInfo,
    required String privateKey,
    required String contractAddress,
  }) {
    try {
      // Reading the contract abi
      final abiDecoded = jsonDecode(abiInfo) as Map<String, dynamic>;
      final abi = jsonEncode(abiDecoded['abi']);
      final address = EthereumAddress.fromHex(contractAddress);

      // Get credentials from our private key
      final credentials = EthPrivateKey.fromHex(privateKey);

      return SmartContract._(
        ContractAbi.fromJson(abi, 'HelloWeb3'),
        address,
        credentials,
      );
    } catch (e) {
      throw SmartContractException(e);
    }
  }

  /// [Credentials] used to interact with the [DeployedContract]
  final Credentials credentials;

  /// [ContractFunction] defined in the [DeployedContract].
  ///
  /// It gets the name from the contract.
  ContractFunction getName() => function('getName');

  /// [ContractFunction] defined in the [DeployedContract].
  ///
  /// Sets the name of the contract.
  ContractFunction setName() => function('setName');
}

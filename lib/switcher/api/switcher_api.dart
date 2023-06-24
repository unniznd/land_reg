import 'package:flutter_web3/ethers.dart';
import 'package:flutter_web3/flutter_web3.dart' as web3;
import '../../common/config.dart';

class SwitcherApiProvider {
  late Contract tokenContract;

  registerLand(
      String owner, String location, int area, int pricePerArea) async {
    final provider = web3.Web3Provider(web3.ethereum!);

    tokenContract = web3.Contract(
      LandNFTConfig.contractAddress,
      LandNFTConfig.jsonAbi,
      provider.getSigner(),
    );

    final tx = await tokenContract.send(
      'registerLand',
      [
        owner,
        location,
        area,
        pricePerArea,
      ],
    );

    await tx.wait();

    return true;
  }
}

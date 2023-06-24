import 'package:flutter_web3/ethers.dart';
import 'package:flutter_web3/flutter_web3.dart' as web3;
import 'package:land_nft/common/land_model.dart';
import '../../common/config.dart';

class MarketApiProvider {
  late Contract tokenContract;

  getListedLand() async {
    final provider = web3.Web3Provider(web3.ethereum!);

    tokenContract = web3.Contract(
      LandNFTConfig.contractAddress,
      LandNFTConfig.jsonAbi,
      provider.getSigner(),
    );
    List<dynamic> result = await tokenContract.call(
      'getListedLand',
      [],
    );
    if (result.isEmpty) {
      return LandModel.fromJson([]);
    } else if (result[0][4] == "0x0000000000000000000000000000000000000000") {
      return LandModel.fromJson([]);
    }

    return LandModel.fromJson(result);
  }

  buyLand(int landId, String address) async {
    final provider = web3.Web3Provider(web3.ethereum!);

    tokenContract = web3.Contract(
      LandNFTConfig.contractAddress,
      LandNFTConfig.jsonAbi,
      provider.getSigner(),
    );

    final tx = await tokenContract.send(
      'buyLand',
      [
        landId,
        address,
      ],
    );

    await tx.wait();

    return true;
  }
}

import 'package:flutter_web3/flutter_web3.dart' as web3;

class WalletConnectApi {
  connectToMetaMask() async {
    if (web3.Ethereum.isSupported) {
      final accs = await web3.ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        String currentAddress = accs.first;

        return {
          "status": 0,
          "message": "Connected to metamask",
          "address": currentAddress,
        };
      } else {
        return {
          "status": 1,
          "message": "No account found",
        };
      }
    } else {
      return {
        "status": 2,
        "message": "Metamask not found",
      };
    }
  }
}

import 'package:flutter/material.dart';

import 'package:land_nft/switcher/switcher_screen.dart';
import 'package:land_nft/wallet_connect/wallet_connect_screen.dart';

class LandNFTConfig {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const WalletConnectScreen(),
    '/home': (context) => const SwitcherScreen(),
  };

  static const jsonAbi =
      '''[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"indexed":false,"internalType":"address payable","name":"oldOwner","type":"address"},{"indexed":false,"internalType":"address payable","name":"newOwner","type":"address"}],"name":"LandBought","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"indexed":false,"internalType":"string","name":"location","type":"string"},{"indexed":false,"internalType":"uint256","name":"area","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"pricePerArea","type":"uint256"},{"indexed":false,"internalType":"address payable","name":"owner","type":"address"}],"name":"LandRegistered","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"indexed":false,"internalType":"address payable","name":"oldOwner","type":"address"},{"indexed":false,"internalType":"address payable","name":"newOwner","type":"address"}],"name":"LandTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"inputs":[{"internalType":"uint256","name":"_landId","type":"uint256"},{"internalType":"address payable","name":"_newOwner","type":"address"}],"name":"buyLand","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_owner","type":"address"}],"name":"getLands","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"location","type":"string"},{"internalType":"uint256","name":"area","type":"uint256"},{"internalType":"uint256","name":"pricePerArea","type":"uint256"},{"internalType":"address payable","name":"owner","type":"address"},{"internalType":"bool","name":"isListed","type":"bool"}],"internalType":"struct LandRegister.Land[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getListedLand","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"location","type":"string"},{"internalType":"uint256","name":"area","type":"uint256"},{"internalType":"uint256","name":"pricePerArea","type":"uint256"},{"internalType":"address payable","name":"owner","type":"address"},{"internalType":"bool","name":"isListed","type":"bool"}],"internalType":"struct LandRegister.Land[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"landCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"lands","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"location","type":"string"},{"internalType":"uint256","name":"area","type":"uint256"},{"internalType":"uint256","name":"pricePerArea","type":"uint256"},{"internalType":"address payable","name":"owner","type":"address"},{"internalType":"bool","name":"isListed","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_landId","type":"uint256"},{"internalType":"uint256","name":"_pricePerArea","type":"uint256"}],"name":"listLand","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address payable","name":"owner","type":"address"},{"internalType":"string","name":"_location","type":"string"},{"internalType":"uint256","name":"_area","type":"uint256"},{"internalType":"uint256","name":"_pricePerArea","type":"uint256"}],"name":"registerLand","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_landId","type":"uint256"},{"internalType":"address payable","name":"_newOwner","type":"address"}],"name":"transferLand","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_landId","type":"uint256"}],"name":"unListLand","outputs":[],"stateMutability":"nonpayable","type":"function"}]''';

  static const contractAddress = "0x698ca0e0c43B823F9D626d0c594007873474C6D7";
}

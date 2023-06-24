import 'package:flutter/material.dart';

abstract class MarketEvent {}

class FetchListedLand extends MarketEvent {}

class BuyLand extends MarketEvent {
  final int landId;
  final String address;
  final BuildContext context;

  BuyLand({
    required this.landId,
    required this.address,
    required this.context,
  });
}

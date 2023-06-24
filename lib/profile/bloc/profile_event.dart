import 'package:flutter/material.dart';

abstract class ProfileEvent {}

class FetchLands extends ProfileEvent {
  final String address;

  FetchLands({required this.address});
}

class ListAndUnlistLand extends ProfileEvent {
  final int landId;
  final int pricePerArea;
  final bool isListed;
  final BuildContext context;

  ListAndUnlistLand({
    required this.landId,
    required this.isListed,
    required this.context,
    required this.pricePerArea,
  });
}

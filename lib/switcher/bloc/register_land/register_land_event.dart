import 'package:flutter/material.dart';

abstract class RegisterLandEvent {}

class RegisterLand extends RegisterLandEvent {
  final String owner, location;
  final int area, pricePerArea;
  final BuildContext context;

  RegisterLand({
    required this.owner,
    required this.location,
    required this.area,
    required this.pricePerArea,
    required this.context,
  });
}

import 'package:land_nft/common/land_model.dart';

abstract class MarketState {}

class MarketInitial extends MarketState {}

class MarketLoading extends MarketState {}

class MarketLoaded extends MarketState {
  final LandModel landModel;

  MarketLoaded({required this.landModel});
}

class MarketError extends MarketState {
  final String message;

  MarketError({required this.message});
}

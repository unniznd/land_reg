import 'package:land_nft/common/land_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final LandModel landModel;

  ProfileLoaded({required this.landModel});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

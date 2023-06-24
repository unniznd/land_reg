abstract class RegisterLandState {}

class RegisterLandInitial extends RegisterLandState {}

class RegisterLandLoading extends RegisterLandState {}

class RegisterLandSuccess extends RegisterLandState {}

class RegisterLandFailure extends RegisterLandState {
  final String error;

  RegisterLandFailure({required this.error});
}

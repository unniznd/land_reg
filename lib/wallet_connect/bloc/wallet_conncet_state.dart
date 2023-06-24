abstract class WalletConnectState {}

class WalletConnectInitial extends WalletConnectState {}

class WalletConnectLoading extends WalletConnectState {}

class WalletConnectSuccess extends WalletConnectState {
  final String address;

  WalletConnectSuccess({required this.address});
}

class WalletConnectError extends WalletConnectState {
  final String message;

  WalletConnectError({required this.message});
}

class WalletConnectNotFound extends WalletConnectState {
  final String message;

  WalletConnectNotFound({required this.message});
}

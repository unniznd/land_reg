import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/wallet_connect_api.dart';
import 'wallet_connect_event.dart';
import 'wallet_conncet_state.dart';

class WalletConnectBloc extends Bloc<ConnectToMetaMask, WalletConnectState> {
  WalletConnectBloc() : super(WalletConnectInitial()) {
    final apiProvider = WalletConnectApi();
    on<ConnectToMetaMask>((event, emit) async {
      emit(WalletConnectLoading());

      try {
        final response = await apiProvider.connectToMetaMask();

        if (response['status'] == 0) {
          emit(WalletConnectSuccess(address: response['address']));
        } else if (response['status'] == 2) {
          emit(WalletConnectNotFound(message: response['message']));
        } else {
          emit(WalletConnectError(message: response['message']));
        }
      } catch (e) {
        emit(WalletConnectError(message: e.toString()));
      }
    });
  }
}

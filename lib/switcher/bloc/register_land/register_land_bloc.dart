import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_nft/switcher/api/switcher_api.dart';
import 'register_land_event.dart';
import 'register_land_state.dart';

class RegisterLandBloc extends Bloc<RegisterLandEvent, RegisterLandState> {
  RegisterLandBloc() : super(RegisterLandInitial()) {
    final switcherApi = SwitcherApiProvider();
    on<RegisterLand>((event, emit) async {
      final scaffoldMessenger = ScaffoldMessenger.of(event.context);
      emit(RegisterLandLoading());
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          content: Row(
            children: [
              Text(
                'Registering Land',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
      try {
        await switcherApi.registerLand(
          event.owner,
          event.location,
          event.area,
          event.pricePerArea,
        );
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Row(
              children: [
                Text(
                  'Registering Land Successful',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
        emit(RegisterLandSuccess());
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Row(
              children: [
                Text(
                  'Registering Land Failed',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
        emit(RegisterLandFailure(error: e.toString()));
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_nft/profile/api/profile_api.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final profileApiProvider = ProfileApiProvider();

    on<FetchLands>((event, emit) async {
      emit(ProfileLoading());
      try {
        final lands = await profileApiProvider.getLands(event.address);
        emit(ProfileLoaded(landModel: lands));
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
    on<ListAndUnlistLand>((event, emit) async {
      if (state is ProfileLoaded) {
        final landModel = (state as ProfileLoaded).landModel;
        final scaffoldMessenger = ScaffoldMessenger.of(event.context);
        for (var element in landModel.results!) {
          if (element.id == event.landId.toString()) {
            element.isLoading = true;
          }
        }
        emit(ProfileLoaded(landModel: landModel));

        try {
          if (!event.isListed) {
            await profileApiProvider.listLand(event.landId, event.pricePerArea);
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Row(
                  children: [
                    Text(
                      'Land listed successfully',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
            for (var element in landModel.results!) {
              if (element.id == event.landId.toString()) {
                element.isLoading = false;
                element.isListed = true;
                element.pricePerArea = event.pricePerArea.toString();
              }
            }
            emit(ProfileLoaded(landModel: landModel));
          } else {
            await profileApiProvider.unlistLand(event.landId);
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Row(
                  children: [
                    Text(
                      'Land unlisted successfully',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
            for (var element in landModel.results!) {
              if (element.id == event.landId.toString()) {
                element.isLoading = false;
                element.isListed = false;
              }
            }
            emit(ProfileLoaded(landModel: landModel));
          }
        } catch (e) {
          for (var element in landModel.results!) {
            if (element.id == event.landId.toString()) {
              element.isLoading = false;
            }
          }
          scaffoldMessenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  Text(
                    event.isListed
                        ? 'Failed to unlist land'
                        : 'Failed to list land',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          emit(ProfileLoaded(landModel: landModel));
        }
      }
    });
  }
}

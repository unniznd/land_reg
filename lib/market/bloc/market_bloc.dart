import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_nft/market/api/market_api.dart';
import 'package:land_nft/common/land_model.dart';
import 'market_event.dart';
import 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc() : super(MarketInitial()) {
    final MarketApiProvider marketApiProvider = MarketApiProvider();
    on<FetchListedLand>((event, emit) async {
      emit(MarketLoading());
      try {
        final LandModel landModel = await marketApiProvider.getListedLand();
        emit(MarketLoaded(landModel: landModel));
      } catch (e) {
        emit(MarketError(message: e.toString()));
      }
    });

    on<BuyLand>((event, emit) async {
      if (state is MarketLoaded) {
        final landModel = (state as MarketLoaded).landModel;
        final scaffoldMessenger = ScaffoldMessenger.of(event.context);
        for (var element in landModel.results!) {
          if (element.id == event.landId.toString()) {
            element.isLoading = true;
          }
        }
        emit(MarketLoaded(landModel: landModel));

        try {
          await marketApiProvider.buyLand(event.landId, event.address);

          scaffoldMessenger.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  Text(
                    'Land bought successfully',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          landModel.count = landModel.count! - 1;
          landModel.results!.removeWhere(
            (element) => element.id == event.landId.toString(),
          );
          emit(MarketLoaded(landModel: landModel));
        } catch (e) {
          for (var element in landModel.results!) {
            if (element.id == event.landId.toString()) {
              element.isLoading = false;
            }
          }
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  Text(
                    'Failed to buy land',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          emit(MarketLoaded(landModel: landModel));
        }
      }
    });
  }
}

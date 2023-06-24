import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/market_bloc.dart';
import 'bloc/market_event.dart';
import 'bloc/market_state.dart';
import 'widget/land_card.dart';

class MarketScreen extends StatefulWidget {
  final String address;
  const MarketScreen({super.key, required this.address});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final MarketBloc marketBloc = MarketBloc();

  @override
  Widget build(BuildContext context) {
    marketBloc.add(FetchListedLand());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "MarketPlace",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<MarketBloc, MarketState>(
                bloc: marketBloc,
                builder: (context, state) {
                  if (state is MarketLoaded) {
                    if (state.landModel.results!.isEmpty) {
                      return const Center(child: Text("No Land Available"));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.landModel.count,
                      itemBuilder: (context, index) {
                        return LandCard(
                          location: state.landModel.results![index].location,
                          owner: state.landModel.results![index].owner,
                          totalLand: state.landModel.results![index].area,
                          pricePerUnit:
                              state.landModel.results![index].pricePerArea,
                          isBuying: state.landModel.results![index].isLoading,
                          onBuy: () {
                            marketBloc.add(
                              BuyLand(
                                landId: int.parse(
                                    state.landModel.results![index].id),
                                address: widget.address,
                                context: context,
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is MarketError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

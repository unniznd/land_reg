import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_nft/profile/bloc/profile_event.dart';
import 'package:land_nft/profile/widget/land_profile_card.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.address,
  });
  final String address;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();
  final TextEditingController pricePerAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    profileBloc.add(FetchLands(
      address: widget.address,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                bloc: profileBloc,
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    if (state.landModel.results!.isEmpty) {
                      return const Center(
                        child: Text("No land found"),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.landModel.count,
                      itemBuilder: (context, index) {
                        return LandProfileCard(
                          location: state.landModel.results![index].location,
                          owner: state.landModel.results![index].owner,
                          totalLand: state.landModel.results![index].area,
                          pricePerUnit:
                              state.landModel.results![index].pricePerArea,
                          isListed: state.landModel.results![index].isListed,
                          isListing: state.landModel.results![index].isLoading,
                          onList: () {
                            pricePerAreaController.text = state
                                .landModel.results![index].pricePerArea
                                .toString();
                            if (!state.landModel.results![index].isListed) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Price per area of land",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    content: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: TextFormField(
                                        controller: pricePerAreaController,
                                        decoration: const InputDecoration(
                                          hintText: "Price per area",
                                          filled: true,
                                          fillColor:
                                              Color.fromRGBO(234, 240, 247, 1),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          profileBloc.add(ListAndUnlistLand(
                                            landId: int.parse(state
                                                .landModel.results![index].id),
                                            isListed: state.landModel
                                                .results![index].isListed,
                                            context: context,
                                            pricePerArea: int.parse(
                                                pricePerAreaController.text),
                                          ));
                                          Navigator.pop(context);
                                        },
                                        child: const Text("List"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              profileBloc.add(ListAndUnlistLand(
                                landId: int.parse(
                                    state.landModel.results![index].id),
                                isListed:
                                    state.landModel.results![index].isListed,
                                context: context,
                                pricePerArea:
                                    int.parse(pricePerAreaController.text),
                              ));
                            }
                          },
                        );
                      },
                    );
                  } else if (state is ProfileError) {
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

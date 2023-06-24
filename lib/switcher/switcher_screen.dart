import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:land_nft/common/widget/left_tab_view.dart';
import 'package:land_nft/profile/profile_screen.dart';
import 'package:land_nft/market/market_screen.dart';
import 'package:land_nft/switcher/bloc/register_land/register_land_bloc.dart';
import 'package:land_nft/switcher/bloc/register_land/register_land_event.dart';
import 'package:land_nft/switcher/bloc/tab_view/left_tab_view_event.dart';
import 'package:land_nft/switcher/widget/register_land_dialog.dart';
import 'bloc/register_land/register_land_state.dart';
import 'bloc/tab_view/left_tab_view_bloc.dart';
import 'bloc/tab_view/left_tab_view_state.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({super.key});

  @override
  State<SwitcherScreen> createState() => _SwitcherScreenState();
}

class _SwitcherScreenState extends State<SwitcherScreen> {
  final LeftTabViewBloc leftTabViewBloc = LeftTabViewBloc();
  final RegisterLandBloc registerLandBloc = RegisterLandBloc();

  bool isBottomNavBar = false;
  final formKey = GlobalKey<FormState>();

  final TextEditingController ownerController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pricePerAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final address = arguments['address'].toString();

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        if (screenWidth < 1000) {
          isBottomNavBar = true;
        } else {
          isBottomNavBar = false;
        }

        return Scaffold(
            body: isBottomNavBar
                ? BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
                    bloc: leftTabViewBloc,
                    builder: (context, state) {
                      if (state is TabViewState) {
                        return IndexedStack(
                          index: state.selectedIndex,
                          children: [
                            MarketScreen(
                              address: address,
                            ),
                            ProfileScreen(
                              address: address,
                            ),
                          ],
                        );
                      }
                      return IndexedStack(
                        index: 0,
                        children: [
                          MarketScreen(
                            address: address,
                          ),
                          ProfileScreen(
                            address: address,
                          ),
                        ],
                      );
                    },
                  )
                : Row(
                    children: [
                      BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
                        bloc: leftTabViewBloc,
                        builder: (context, state) {
                          if (state is TabViewState) {
                            return LeftTabView(
                              screenWidth: screenWidth,
                              selectedIndex: state.selectedIndex,
                              leftTabViewBloc: leftTabViewBloc,
                            );
                          }
                          return LeftTabView(
                            screenWidth: screenWidth,
                            selectedIndex: 0,
                            leftTabViewBloc: leftTabViewBloc,
                          );
                        },
                      ),
                      Expanded(
                        child: BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
                          bloc: leftTabViewBloc,
                          builder: (context, state) {
                            if (state is TabViewState) {
                              if (state.selectedIndex == 0) {
                                return MarketScreen(
                                  address: address,
                                );
                              } else if (state.selectedIndex == 1) {
                                return ProfileScreen(
                                  address: address,
                                );
                              }
                            }
                            return ProfileScreen(
                              address: address,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            bottomNavigationBar: isBottomNavBar
                ? Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 0,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
                      bloc: leftTabViewBloc,
                      builder: (context, state) {
                        const List<String> tabs = [
                          'Market',
                          'Profile',
                        ];
                        const List<HeroIcon> icons = [
                          HeroIcon(
                            HeroIcons.shoppingBag,
                            color: Colors.black,
                          ),
                          HeroIcon(
                            HeroIcons.user,
                            color: Colors.black,
                          ),
                        ];
                        if (state is TabViewState) {
                          return BottomNavigationBar(
                            currentIndex: state.selectedIndex,
                            onTap: (index) {
                              html.window.history.pushState(
                                  null, '', '/${tabs[index].toLowerCase()}');
                              leftTabViewBloc.add(ChangeTabView(index: index));
                            },
                            selectedItemColor: Colors.blue,
                            selectedIconTheme: const IconThemeData(
                                size: 30, color: Colors.blue),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            unselectedItemColor: Colors.black87,
                            selectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                            type: BottomNavigationBarType.fixed,
                            items: tabs
                                .asMap()
                                .map((index, value) => MapEntry(
                                      index,
                                      BottomNavigationBarItem(
                                        icon: icons[index],
                                        label: value,
                                      ),
                                    ))
                                .values
                                .toList(),
                          );
                        }
                        return BottomNavigationBar(
                          currentIndex: 0,
                          onTap: (index) {
                            leftTabViewBloc.add(ChangeTabView(index: index));
                          },
                          items: tabs
                              .asMap()
                              .map((index, value) => MapEntry(
                                    index,
                                    BottomNavigationBarItem(
                                      icon: icons[index],
                                      label: value,
                                    ),
                                  ))
                              .values
                              .toList(),
                        );
                      },
                    ),
                  )
                : null,
            floatingActionButton: address ==
                    '0x5c29c5e8e0df5c2fc7e43b443e05a0c59f490d5e'
                ? BlocBuilder<RegisterLandBloc, RegisterLandState>(
                    bloc: registerLandBloc,
                    builder: (context, state) {
                      if (state is RegisterLandSuccess ||
                          state is RegisterLandInitial) {
                        return FloatingActionButton(
                          onPressed: () {
                            registerLandDialog(
                              context,
                              ownerController,
                              locationController,
                              areaController,
                              pricePerAreaController,
                              formKey,
                              () {
                                if (formKey.currentState!.validate()) {
                                  registerLandBloc.add(
                                    RegisterLand(
                                        owner: ownerController.text,
                                        location: locationController.text,
                                        area: int.parse(areaController.text),
                                        pricePerArea: int.parse(
                                          pricePerAreaController.text,
                                        ),
                                        context: context),
                                  );
                                }
                              },
                            );
                          },
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.add),
                        );
                      }
                      if (state is RegisterLandLoading) {
                        return const FloatingActionButton(
                          onPressed: null,
                          backgroundColor: Colors.blue,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return FloatingActionButton(
                        onPressed: () {
                          registerLandDialog(
                            context,
                            ownerController,
                            locationController,
                            areaController,
                            pricePerAreaController,
                            formKey,
                            () {
                              if (formKey.currentState!.validate()) {
                                registerLandBloc.add(
                                  RegisterLand(
                                      owner: ownerController.text,
                                      location: locationController.text,
                                      area: int.parse(areaController.text),
                                      pricePerArea: int.parse(
                                        pricePerAreaController.text,
                                      ),
                                      context: context),
                                );
                              }
                            },
                          );
                        },
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.add),
                      );
                    },
                  )
                : null);
      },
    );
  }
}

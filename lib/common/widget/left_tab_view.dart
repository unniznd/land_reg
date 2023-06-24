import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:land_nft/switcher/bloc/tab_view/left_tab_view_event.dart';

// ignore: must_be_immutable
class LeftTabView extends StatelessWidget {
  LeftTabView({
    super.key,
    required this.screenWidth,
    required this.selectedIndex,
    required this.leftTabViewBloc,
  });

  final List<String> _tabs = [
    'Market',
    'Profile',
  ];

  final List<HeroIcons> _tabIcons = [
    HeroIcons.shoppingBag,
    HeroIcons.user,
  ];

  int selectedIndex;

  // ignore: prefer_typing_uninitialized_variables
  var leftTabViewBloc;

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth / 5.5,
      color: const Color.fromRGBO(245, 247, 249, 1),
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _tabs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  html.window.history
                      .pushState(null, '', '/${_tabs[index].toLowerCase()}');
                  leftTabViewBloc.add(ChangeTabView(index: index));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color.fromRGBO(68, 97, 242, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      HeroIcon(
                        _tabIcons[index],
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _tabs[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

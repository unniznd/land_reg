import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_nft/switcher/bloc/tab_view/left_tab_view_event.dart';

import 'left_tab_view_state.dart';

class LeftTabViewBloc extends Bloc<ChangeTabView, LeftTabViewState> {
  LeftTabViewBloc() : super(TabViewState(selectedIndex: 0)) {
    on<ChangeTabView>((event, emit) {
      emit(TabViewState(selectedIndex: event.index));
    });
  }
}

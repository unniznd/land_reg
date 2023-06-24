abstract class LeftTabViewState {}

class TabViewState extends LeftTabViewState {
  final int selectedIndex;
  TabViewState({required this.selectedIndex});
}

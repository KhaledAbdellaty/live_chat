import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../ui/screens/calls_screen.dart';
import '../ui/screens/messages_screen.dart';
import '../ui/screens/users_screen.dart';

class NavigateProvider extends ChangeNotifier {
final List<Widget> screensList = [
  ChatScreen(),
  UsersScreen(),
  CallsScreen(),
];
final navigationKey = GlobalKey<CurvedNavigationBarState>();
int currentIndex = 1;
List<Widget> iconsList = [
  const Icon(
    Icons.chat,
    size: 30,
    color: Colors.white,
  ),
  const Icon(
    Icons.home,
    size: 30,
    color: Colors.white,
  ),
  const Icon(
    Icons.call,
    size: 30,
    color: Colors.white,
  ),
];

navigateScreen(int index) {
  currentIndex = index;
  notifyListeners();
}

navigateToScreen(int index) {
  final navigateState = navigationKey.currentState;
  navigateState!.setPage(index);
}
}
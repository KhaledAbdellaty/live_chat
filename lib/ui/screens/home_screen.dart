
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:livechat/database/messages_api.dart';
import 'package:livechat/database/users_api.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String screenRoute = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    UsersApi.instance.getUsers(context);
  }

  @override
  Widget build(BuildContext context) {

    final bottomBarProvider = Provider.of<NavigateProvider>(context);
    return Scaffold(
      //extendBody: true,
      bottomNavigationBar: Consumer<NavigateProvider>(
        builder: (context,provider,child){
          return CurvedNavigationBar(
            key: provider.navigationKey,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            color: Colors.blue[900]!,
            items: provider.iconsList,
            index: provider.currentIndex,
            height: 50,
            onTap: (index){provider.navigateScreen(index);
            print(provider.currentIndex);},
          );
        },
      ),

      body: bottomBarProvider.screensList[bottomBarProvider.currentIndex],
    );
  }
}

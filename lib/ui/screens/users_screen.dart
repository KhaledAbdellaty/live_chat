import 'package:flutter/material.dart';
import 'package:livechat/database/users_api.dart';
import 'package:livechat/providers/navigation_provider.dart';
import 'package:livechat/providers/users_provider.dart';
import 'package:livechat/ui/widgets/header_users.dart';
import 'package:provider/provider.dart';
import '../widgets/users_listview.dart';

class UsersScreen extends StatefulWidget {
  static const String screenRoute = '/users_screen';

  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    UsersApi.instance.getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    final bottomBar = Provider.of<NavigateProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
              children: [
                const Header(),
                const SizedBox(
                  height: 20,
                ),
                UsersListview(userProvider: userProvider, bottomBar: bottomBar),
              ],
        ),
      ),
    );
  }


}



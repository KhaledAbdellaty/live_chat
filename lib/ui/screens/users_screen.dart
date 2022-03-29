import 'package:flutter/material.dart';
import 'package:livechat/database/users_api.dart';
import 'package:livechat/providers/navigation_provider.dart';
import 'package:livechat/providers/users_provider.dart';
import 'package:livechat/ui/widgets/header_users.dart';
import 'package:livechat/ui/widgets/user_widget.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  static const String screenRoute = '/users_screen';

  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    UsersApi.instance.getUsers(context);
    super.initState();
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
                Expanded(
                  child: ListView.builder(
                      itemCount: userProvider.userList.length,
                      itemBuilder: (context, index) {
                        final user = userProvider.userList[index];
                        return InkWell(
                            onTap: () {
                              userProvider.receiverUser.name = user.name;
                              userProvider.receiverUser.id = user.id;
                              userProvider.receiverUser.email = user.id;
                              bottomBar.navigateToScreen(0);
                            },
                            child: Column(
                              children: [
                                UsersWidget(
                                    avatar: user.avatar,
                                    uName: user.name,
                                    lastMessage: user.email),
                                const SizedBox(height: 15,),
                              ],
                            ));
                      }),
                ),
              ],
        ),
      ),
    );
  }


}

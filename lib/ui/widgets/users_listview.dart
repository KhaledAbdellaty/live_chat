import 'package:flutter/material.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/users_provider.dart';
import 'user_widget.dart';

class UsersListview extends StatelessWidget {
  const UsersListview({
    Key? key,
    required this.userProvider,
    required this.bottomBar,
  }) : super(key: key);

  final UsersProvider userProvider;
  final NavigateProvider bottomBar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: userProvider.userList.length,
          itemBuilder: (context, index) {
            final user = userProvider.userList[index];
            return InkWell(
                onTap: () {
                  userProvider.receiverUser.name = user.name;
                  userProvider.receiverUser.id = user.id;
                  userProvider.receiverUser.email = user.email;
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
    );
  }
}
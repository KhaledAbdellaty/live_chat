import 'package:flutter/material.dart';
import 'package:livechat/database/users_api.dart';
import 'package:livechat/providers/users_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
    UsersApi.instance.getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);
    return Material(
      color: Colors.blue[900],
      elevation: 5,
      shadowColor: Colors.blue[900],
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        radius: 26,
                        child: CircleAvatar(
                          radius: 24,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: users.userList.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final user = users.userList[index];
                            return Consumer<NavigateProvider>(
                              builder: (context, provider, child) {
                                return InkWell(
                                  splashColor: Colors.blue.withAlpha(30),
                                  onTap: () {
                                    provider.navigateToScreen(0);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 26,
                                        backgroundImage:
                                            NetworkImage(user.avatar.toString()),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

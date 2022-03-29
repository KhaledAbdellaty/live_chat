import 'package:flutter/cupertino.dart';
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

  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(context),
            searchField(),
            favoriteBar(context, users),
          ],
        ),
      ),
    );
  }

  Container appBar(context) {
    return Container(
      color: Colors.blue[900],
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Contacts',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 34),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                UsersApi.instance.signOut(context);
              },
              child: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container searchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: TextFormField(
          controller: _search,
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.w500),
          cursorColor: Colors.white70,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white70,
            ),
            hintText: 'Search',
            hintStyle:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
            border: InputBorder.none,
            focusColor: Colors.white70,
          ),
        ),
      ),
    );
  }

  Container favoriteBar(BuildContext context, UsersProvider users) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 20),
            child: Text(
              'Favorites',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
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
                        onTap: () {
                          provider.navigateToScreen(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blue[800],
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
      ),
    );
  }
}

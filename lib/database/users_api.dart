
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livechat/models/user_model.dart';
import 'package:livechat/providers/users_provider.dart';
import 'package:provider/provider.dart';

import '../ui/screens/signin_screen.dart';
import 'constants.dart';

class UsersApi{
  UsersApi._();
  static final UsersApi instance = UsersApi._();

  getUsers(BuildContext context)async{
     final List<UserModel> usersList = [];
     final userProvider = Provider.of<UsersProvider>(context,listen: false);
     final  getSnapshot = FirebaseFirestore.instance.collection(usersCollection)
     .where('uid',isNotEqualTo: userProvider.currentUser.id)
         .snapshots();
     getSnapshot.forEach((doc) {
      final data = doc.docs;
      usersList.clear();
      for(var users in data){
        final user = users.data();
        usersList.add(UserModel.fromMap(user));
      }
      userProvider.userList = usersList;
      //userProvider.userList.removeWhere((element) => element.name == userProvider.currentUser.name);
      print(userProvider.userList.length);
    });

  }

  createUser(BuildContext context,String name,String email,String pass)async{
    final userProvider = Provider.of<UsersProvider>(context,listen: false);
    final  user = FirebaseFirestore.instance.collection(usersCollection);
    final _auth = FirebaseAuth.instance;
    _auth.createUserWithEmailAndPassword(email: email, password: pass).then((value) async {
      final newUser = UserModel(
        id: _auth.currentUser!.uid,
        name: name,
        email: email,
        password: pass,
        avatar: 'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
      );
      _auth.currentUser!.updateDisplayName(name);
      await user.add(newUser.toMap());
      userProvider.userList.add(newUser);
    });

  }

  signInUser(BuildContext context,String email,String password)async{
    final userProvider = Provider.of<UsersProvider>(context,listen: false);
    final _auth = FirebaseAuth.instance;
    final signing = userProvider.userList.where((element) => email == element.email);
    if(signing.isNotEmpty){
      _auth.signInWithEmailAndPassword(email: email, password: password).then((user) {
        userProvider.currentUser.name = user.user!.displayName;
        userProvider.currentUser.email = user.user!.email;
        userProvider.currentUser.id = user.user!.uid;
        print('login mail = ${userProvider.currentUser.email}');
        print('login id = ${userProvider.currentUser.id}');
      });
    }else{
      print('no account');
    }

  }

  signOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
  }
}
import 'package:flutter/material.dart';
import 'package:livechat/providers/users_provider.dart';
import 'database/messages_api.dart';

String chatRoomId(String user1, String user2) {
  if (user1[0].toLowerCase().codeUnits[0] >
      user2[0].toLowerCase().codeUnits[0]) {
    return '$user1$user2';
  } else {
    return '$user2$user1';
  }
}

sendMessage(BuildContext context, UsersProvider userProvider,
    TextEditingController text) {
  MessagesApi.instance.sendMessage(
      context,
      chatRoomId(userProvider.currentUser.id.toString(),
          userProvider.receiverUser.id.toString()),
      text.text);
  text.clear();
  FocusScope.of(context).unfocus();
}

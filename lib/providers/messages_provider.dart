import 'package:flutter/material.dart';
import 'package:livechat/models/message_model.dart';

class MessageProvider extends ChangeNotifier{
  List<MessageModel> _messageList = [];

  List<MessageModel> get messageList => _messageList;

  set messageList(List<MessageModel> value) {
    _messageList = value;
    notifyListeners();
  }
}
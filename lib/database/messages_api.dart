
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livechat/models/message_model.dart';
import 'package:livechat/providers/messages_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


import '../providers/users_provider.dart';

class MessagesApi {
  MessagesApi._();

  static final MessagesApi instance = MessagesApi._();
  File? imageFile;
  static DateTime? toDateTime(Timestamp value) {
    if (value == null) {
      return null;
    }
    return value.toDate();
  }

  static dynamic fromDateTimeToMap(DateTime dateTime) {
    if (dateTime == null) return null;

    return dateTime.toUtc();
  }

  Future sendMessage(BuildContext context,String idUser, String message) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chat/$idUser/messages');
    final messageProvider = Provider.of<MessageProvider>(context,listen: false);
    final userProvider = Provider.of<UsersProvider>(context,listen: false);
    final newMessage = MessageModel(
      receiver: userProvider.receiverUser.name,
      sender: userProvider.currentUser.name,
      text: message,
      sentAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toMap());
    messageProvider.messageList.add(newMessage);


  }



  getMessages(BuildContext context,String chatDoc) async {
    final List<MessageModel> messageList = [];
    final messageProvider = Provider.of<MessageProvider>(context,listen: false);
    final snapshot = FirebaseFirestore.instance
        .collection('chat')
        .doc(chatDoc)
        .collection('messages')
        .orderBy('sent_at', descending: true)
        .snapshots();
    snapshot.forEach((data) {
      messageList.clear();
      for (var messages in data.docs) {
        final message = messages.data();
        messageList.add(MessageModel.fromJson(message));
      }
      messageProvider.messageList = messageList;
      print(messageProvider.messageList.length);
    });
  }
//Todo not complete yet Image picker
  Future getImage()async{
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if(value != null){
        imageFile = File(value.path);
        sendImage();
      }
    });
  }
  Future sendImage() async {
    String fileName = Uuid().v1();
    var ref = FirebaseStorage.instance.ref().child('images')
        .child('$fileName.jpg');
    var send = await ref.putFile(imageFile!);
    String imageUrl = await send.ref.getDownloadURL();
    print(imageUrl);
  }


}

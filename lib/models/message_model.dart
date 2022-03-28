import '../database/constants.dart';
import '../database/messages_api.dart';

class MessageModel{
  String? text;
  String? sender;
  String? receiver;
  DateTime? sentAt;

  MessageModel({this.text, this.sender, this.receiver, this.sentAt});

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      columnText : text ,
      columnSender: sender,
      columnReceiver: receiver ,
      columnSentAt: MessagesApi.fromDateTimeToMap(sentAt!),

    };
    return map;
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      text: map[columnText] ,
      sender: map[columnSender] ,
      receiver: map[columnReceiver],
      sentAt: MessagesApi.toDateTime(map[columnSentAt]) ,
    );
  }
}
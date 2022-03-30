import 'package:flutter/material.dart';
import 'package:livechat/database/messages_api.dart';
import 'package:livechat/providers/messages_provider.dart';
import 'package:livechat/providers/users_provider.dart';
import 'package:livechat/ui/widgets/message_widget.dart';
import 'package:provider/provider.dart';
import '../../methods.dart';
import '../../providers/navigation_provider.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = '/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    MessagesApi.instance.getMessages(
        context,
        chatRoomId(userProvider.currentUser.id.toString(),
            userProvider.receiverUser.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Consumer<MessageProvider>(
          builder: (context, provider, child) {
            final list = provider.messageList.length;
            return Column(
              children: [
                appBar(context),
                messagesViewer(list, provider, userProvider),
                const SizedBox(
                  height: 20,
                ),
                bottomSendField(context, userProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded messagesViewer(
      int list, MessageProvider provider, UsersProvider userProvider) {
    return Expanded(
      child: list == 0
          ? const Center(
              child: Text("say hello"),
            )
          : ListView.builder(
              reverse: true,
              itemCount: list,
              itemBuilder: (context, index) {
                final message = provider.messageList[index];
                return MessageWidget(
                  text: message.text.toString(),
                  isMe: userProvider.currentUser.name.toString() ==
                          message.sender.toString()
                      ? true
                      : false,
                );
              }),
    );
  }

  Column bottomSendField(BuildContext context, UsersProvider userProvider) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: Colors.deepOrange,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: _text,
                onSaved: (value) {
                  _text.text = value!;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  hintText: 'Write your message here...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(onPressed: (){
              MessagesApi.instance.getImage();
            }, icon: Icon(Icons.add_a_photo_outlined,color: Colors.blue[900],)),
            TextButton(
                onPressed: () {
                  sendMessage(context, userProvider, _text);
                },
                child: const Text(
                  'send',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          ],
        ),
      ],
    );
  }

  Material appBar(context) {
    final bottomBarProvider =
        Provider.of<NavigateProvider>(context, listen: false);
    final userProvider = Provider.of<UsersProvider>(context);
    return Material(
      elevation: 2,
      child: Row(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                child: Text(
                  userProvider.receiverUser.name.toString(),
                  style: TextStyle(color: Colors.blue[900],fontSize: 18,fontWeight: FontWeight.w600
                  ),
                ),
              ),),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      bottomBarProvider.navigateToScreen(1);
                    },
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.blue[900],
                      size: 40,
                    ),
                  ),)
        ],
      ),
    );
  }
}

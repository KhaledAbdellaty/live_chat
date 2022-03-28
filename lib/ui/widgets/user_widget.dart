
import 'package:flutter/material.dart';

class UsersWidget extends StatelessWidget {
  UsersWidget(
      {Key? key,
        required this.avatar,
        required this.uName,
        required this.lastMessage})
      : super(key: key);
  String? avatar;
  String? uName;
  String? lastMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 30,
              child: CircleAvatar(
                maxRadius: 28,
                backgroundImage: NetworkImage(avatar!),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    lastMessage!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

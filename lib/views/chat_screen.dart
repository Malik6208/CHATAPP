import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container()),


            Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                borderRadius: BorderRadius.circular(13)
              ),

              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5
              ),
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Message'
                        ),
                      )
                  ),
                  IconButton(onPressed: (){},
                      icon: Icon(Icons.send,color: Colors.blue,size: 35,))
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}

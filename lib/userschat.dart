import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  final String otherUsername;

  ChatScreen({required this.otherUsername});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  final List<String> predefinedMessages = [
    "Hi! I am a simulated user and I am here to help with your project.",
    "How are you?",
    "To be or not to be, that's the question.",
    "It's a great pleasure to talk with you!",
    "I'm fine, thanks!",
    "Have a good day!",
    "May God bless your life.",
    "I really need to talk with someone.",
    "Do you want to be my friend?",
    "We have so much things in common.",
    "Now it's time to go. Thank you so much for the time we spent together!",
  ];

  void sendNotification(String email, String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=<AAAADPHBtLo:APA91bF98-SA5Y-veJFNSRMJkb1xG16y-aTTOjIGqX9McSjYKkqYTQyd2MBGFU2Tr9SJpmWCEEFDswM51qik7jskisa3hXiU2isNzeoVTo0JEq93RzhKQr8peI7bp2KQ9M27Xv1fDqIw>',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': '/topics/' + email.replaceAll('@', '_'),
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.otherUsername),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  final sender = _chatMessages[index]['sender'];
                  final message = _chatMessages[index]['message'];

                  if (sender == 'Me') {
                    return ListTile(
                      title: Text('I said: $message'),
                    );
                  } else {
                    return ListTile(
                      title: Text('${widget.otherUsername} said: $message'),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Write a message...',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add({'sender': 'Me', 'message': message});
      _chatMessages.add({
        'sender': widget.otherUsername,
        'message': predefinedMessages[Random().nextInt(predefinedMessages.length)]
      });
    });
    _messageController.clear();
    sendNotification(widget.otherUsername, 'New Message!', message);
  }
}

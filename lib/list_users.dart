import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'userschat.dart';
class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> users = [
      'user1@mycompany.com',
      'user2@mycompany.com',
      'user3@mycompany.com',
      'user4@mycompany.com',
      'user5@mycompany.com',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(users[index]),
            trailing: IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(otherUsername: users[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ),
        ),
      ),
    );
  }
}

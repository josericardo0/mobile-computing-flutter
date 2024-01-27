class UserSelectionScreen extends StatelessWidget {
  final List<String> users;

  UserSelectionScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          String otherUsername = users[index];
          return ListTile(
            title: Text(otherUsername),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(otherUsername: otherUsername),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

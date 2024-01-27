import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'list_users.dart';
import 'registerpage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.chat,
              size: 40.0,
              color: Colors.blue,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                // Handle Forgot Password
              },
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your email and password.'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserListScreen()),
                  );
                }
              },
              child: Text('Authenticate'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final GoogleSignIn googleSignIn = GoogleSignIn();
                final GoogleSignInAccount? googleSignInAccount =
                await googleSignIn.signIn();
                if (googleSignInAccount != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserListScreen()),
                  );
                } else {
                  print('Google Sign-In failed');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Authenticate with Google'),
                  SizedBox(width: 5.0),
                  Image.network(
                    'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
                    height: 20.0,
                    width: 20.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                'I want to register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

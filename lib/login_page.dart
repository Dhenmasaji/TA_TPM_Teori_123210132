import 'package:flutter/material.dart';
import 'home_page.dart';
import 'session.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Dummy login validation
    if (username == 'admin' && password == 'admin') {
      await SessionManager().setLoggedIn(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Masukkan Username & Password yang benar '),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
            'assets/login.jpg', // Ensure you have this image in your assets
            width: 500,
              height: 250,
              fit : BoxFit.cover,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

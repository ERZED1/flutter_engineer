import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {
  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ElevatedButton(
        onPressed: () async {
          await _signOut();
          if (!mounted) return;
          if (_firebaseAuth.currentUser == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          }
        },
        child: const Text(
          'Log Out',
        ),
      ),
    );
  }
}

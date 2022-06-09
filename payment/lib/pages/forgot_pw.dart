import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ForgotPw extends StatefulWidget {
  const ForgotPw({Key? key}) : super(key: key);

  @override
  State<ForgotPw> createState() => _ForgotPwState();
}

class _ForgotPwState extends State<ForgotPw> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  'Kami sudah mengirim link ke email anda! Silahkan cek email anda'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/forgot.png',
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              textAlign: TextAlign.center,
              'Masukan Email Anda! Kami Akan Mengirim Link Reset Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.blue),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('Reset Password'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:payment/pages/home_page.dart';

class VerifikasiPage extends StatefulWidget {
  const VerifikasiPage({Key? key}) : super(key: key);

  @override
  State<VerifikasiPage> createState() => _VerifikasiPageState();
}

class _VerifikasiPageState extends State<VerifikasiPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  // void sendOTP() async {
  //   var res = await EmailAuth.sendOtp(recipientMail: _emailController.text);
  // }

  // void verifyOTP() {
  //   var res = EmailAuth. validate(
  //       recieverMail: _emailController.text, userOTP: _otpController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hallo Silahkan Verifikasi Akun Anda',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/verify.png',
                    height: 250,
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
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Colors.blue,
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                            // suffixIcon: TextButton(
                            //   child: Text('Send OTP'),
                            //   onPressed: () => sendOTP(),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          controller: _otpController,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.code,
                              color: Colors.blue,
                            ),
                            border: InputBorder.none,
                            hintText: 'OTP',
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Verikasi OTP'),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const HomePage()),
                          ),
                          (route) => false);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

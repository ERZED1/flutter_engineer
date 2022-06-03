import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:payment/pages/home_page.dart';
import 'package:payment/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences logindata;

  String email = '';

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(
      () {
        logindata.getString('email');
      },
    );
  }

  @override
  void initState() {
    initial();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (logindata.getString('email') == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[200],
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset("assets/splashback.json"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Bayeue",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

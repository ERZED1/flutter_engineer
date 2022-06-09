import 'package:flutter/material.dart';
import 'package:flutter_bayeue/pages/login_page.dart';
import 'package:flutter_bayeue/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: authProvider.firstTime
          ? Scaffold(
              backgroundColor: const Color.fromARGB(255, 227, 244, 254),
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Image.asset('assets/images/Bayeue.png'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/started.png',
                              height: 300,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Provide Convenience in Transactions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'The ease of transacting can be felt by everyone and tracking every transaction that occurs',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              authProvider.getStarted();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text('GET STARTED'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : LoginPage(),
    );
  }
}

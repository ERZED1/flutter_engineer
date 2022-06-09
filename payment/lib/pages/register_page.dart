import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment/components/constants.dart';
import 'package:payment/pages/home_page.dart';
import 'package:payment/pages/login_page.dart';
import 'package:payment/pages/verifikasi_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  bool isloading = false;

  late SharedPreferences logindata;
  late bool newRegis;

  void togglePassword() {
    setState(() {
      _passwordVisible1 = !_passwordVisible1;
    });
  }

  void togglePassword2() {
    setState(() {
      _passwordVisible2 = !_passwordVisible2;
    });
  }

  void checkRegis() async {
    logindata = await SharedPreferences.getInstance();
    newRegis = logindata.getBool('regis') ?? true;
    if (!mounted) return;
    if (newRegis == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkRegis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hallo Silahkan Daftar Akun Anda',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/regis.png',
                    height: 250,
                  ),
                  const SizedBox(
                    height: 30,
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
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          obscureText: !_passwordVisible1,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              splashRadius: 1,
                              icon: Icon(
                                _passwordVisible1
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: togglePassword,
                            ),
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
                          controller: _passwordConfirmController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be null';
                            } else if (value.length < 6) {
                              return 'Enter at least 6 Characters';
                            } else if (_passwordConfirmController.text !=
                                _passwordController.text) {
                              return 'Password must be the same';
                            }
                            return null;
                          },
                          obscureText: !_passwordVisible2,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              splashRadius: 1,
                              icon: Icon(
                                _passwordVisible2
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: togglePassword2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () async {
                        String email = _emailController.text;
                        String pass = _passwordController.text;
                        final isValidForm = formKey.currentState!.validate();
                        if (isValidForm) {
                          logindata.setString('email', email);
                          setState(() {
                            isloading = true;
                          });
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: pass);
                            logindata.setBool('login', false);
                            if (!mounted) return;
                            await Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return const VerifikasiPage();
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return Align(
                                      child: SizeTransition(
                                        sizeFactor: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 750),
                                ),
                                (route) => false);
                            setState(() {
                              isloading = false;
                            });
                          } on FirebaseAuthException catch (e) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Ops! Login Failed"),
                                content: Text('${e.message}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Okay'),
                                  )
                                ],
                              ),
                            );
                          }
                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah Punya Akun? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const LoginPage()),
                              ),
                              (route) => false);
                        },
                        child: const Text(
                          ' Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

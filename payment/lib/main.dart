import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment/pages/splash_screens.dart';
import 'package:payment/pages/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}

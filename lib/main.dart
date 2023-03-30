import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vedic_heals/constants/global_variables.dart';
import 'package:vedic_heals/models/blog_model.dart';
import 'package:vedic_heals/provider/user_provider.dart';
import 'package:vedic_heals/screens/auth%20Screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vedic_heals/screens/home_page.dart';
import 'package:vedic_heals/services/database.dart';
import 'package:vedic_heals/widgets/loading.dart';
import 'package:provider/provider.dart';
import './models/disease_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        StreamProvider<List<DiseaseModel>>.value(
          value: Database().diseases,
          initialData: const [],
        ),
        StreamProvider<List<BlogModel>>.value(
          value: Database().bolgs,
          initialData: const [],
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.eczar().fontFamily,
          useMaterial3: true,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  if (kDebugMode) {
                    print(FirebaseAuth.instance.currentUser!.uid);
                  }
                  return AnimatedSplashScreen(
                    duration: 3000,
                    splash: const Image(
                      image: AssetImage('assets/images/yoga.png'),
                    ),
                    nextScreen: const HomePage(),
                    splashTransition: SplashTransition.scaleTransition,
                    backgroundColor: textColor,
                  );
                } else if (snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Some Error Occurred',
                      ),
                    ),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Loading(),
                );
              }
              return AnimatedSplashScreen(
                duration: 3000,
                splash: const Image(
                  image: AssetImage('assets/images/yoga.png'),
                ),
                nextScreen: const SignUpScreen(),
                splashTransition: SplashTransition.scaleTransition,
                backgroundColor: textColor,
              );
            }),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

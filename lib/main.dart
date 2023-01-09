import 'package:firebase_core/firebase_core.dart';
import 'package:fit_memoir/constants.dart';
import 'package:fit_memoir/firebase_options.dart';
import 'package:fit_memoir/providers/global_providers.dart';
import 'package:fit_memoir/providers/page_details_provider.dart';
import 'package:fit_memoir/screens/details_screen.dart';
import 'package:fit_memoir/screens/login_screen.dart';
import 'package:fit_memoir/widgets/bottom_nav_bar.dart';
import 'package:fit_memoir/widgets/category_card.dart';
import 'package:fit_memoir/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/user_greeting_display.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

// https://github.com/kritikavg/meditation-app.git

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Memoire',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: kTextColor,
            ),
      ),
      home: LoginScreen(),
    );
  }
}

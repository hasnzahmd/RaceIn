import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:race_in/constants/custom_colors.dart';
import 'components/splash.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('cacheBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Titillium',
        appBarTheme: const AppBarTheme(
            backgroundColor: CustomColors.f1red,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Titillium',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
            centerTitle: true),
      ),
      title: 'RaceIn',
      home: const Splash(),
    );
  }
}

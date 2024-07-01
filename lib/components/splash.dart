import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_in/constants/custom_colors.dart';
import '../pages/home.dart';
import '../data/data_notifier.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final dataNotifier = Provider.of<DataNotifier>(context, listen: false);

    final dataInitialization =
        dataNotifier.initializeData(context); // Pass context here
    final timeout = Future.delayed(const Duration(seconds: 5));
    await Future.any([dataInitialization, timeout]);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.f1red,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/f1w.png'),
          height: 200.0,
          width: 200.0,
        ),
      ),
    );
  }
}

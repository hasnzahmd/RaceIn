import 'package:flutter/material.dart';
import 'package:race_in/constants/custom_colors.dart';
import '../pages/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _splashState();
}

class _splashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
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
        ));
  }
}

import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class Standings extends StatefulWidget {
  const Standings({super.key});

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Standings'),
      body: Center(
        child: Text('Standings page'),
      ),
    );
  }
}

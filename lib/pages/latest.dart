import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class Latest extends StatefulWidget {
  const Latest({super.key});

  @override
  State<Latest> createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Latest'),
      body: Center(
        child: Text('Latest page'),
      ),
    );
  }
}

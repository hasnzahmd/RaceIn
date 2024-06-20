import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 8),
        child: Image.asset(
          'assets/images/f1w.png',
        ),
      ),
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, size: 25, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

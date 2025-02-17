import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => Navigator.of(context).pop(),
      splashRadius: 28,
      icon: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ],
      ),
    );
  }
}

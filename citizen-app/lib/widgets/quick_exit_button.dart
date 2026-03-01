import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuickExitButton extends StatelessWidget {
  const QuickExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () => SystemNavigator.pop(),
      child: const Icon(Icons.exit_to_app, color: Colors.white),
    );
  }
}

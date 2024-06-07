import 'package:flutter/material.dart';

class RedirectDialogue extends StatelessWidget {
  const RedirectDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Text("Redirecting..."),
      actions: [TextButton(onPressed: null, child: Text("Ok"))],
    );
  }
}

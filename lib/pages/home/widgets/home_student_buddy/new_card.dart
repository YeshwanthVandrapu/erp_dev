import 'package:flutter/material.dart';
import 'student_buddy_card.dart';

class NewCard extends StatelessWidget {
  const NewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 250,
          ),
          child: const StudentCard(),
        ),
      ),
    );
  }
}

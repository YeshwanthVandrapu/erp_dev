import 'package:flutter/material.dart';

class EventCard1 extends StatelessWidget {
  const EventCard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Image(
            image: AssetImage('res/images/welcome_illustration1.png'),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                "Orientation 2024",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
              Divider(
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text("Start Date"),
              const SizedBox(height: 12),
              const Text("here date will go"),
              const Flexible(
                child: Text(
                  "Please Welcome us with the orientation programme of the upcoming cohort of 2028.The event is packed with fun stuff and cool games. See you all at the OAT.",
                  style: TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(children: [
                  WidgetSpan(child: Icon(Icons.group_outlined)),
                  TextSpan(text: "Students and Faculty"),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

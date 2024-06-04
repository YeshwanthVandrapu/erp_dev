import 'package:erp_dev/pages/home/widgets/welcome_card/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: GetBuilder<UserController>(builder: (controller) {
              if (controller.user == null) {
                return const CircularProgressIndicator();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${"Welcome, ${controller.user!.name}"}👋",
                            style: GoogleFonts.urbanist(
                              fontSize: 24,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff004B50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: const Color(0xff307178),
                          ),
                          children: [
                            const TextSpan(
                                text:
                                    'We are so excited to have you on-board! Kindly fill in all the information in this form to initiate your registration as a bonafide student of the University.\n\nLast Date to complete your application is '),
                            TextSpan(
                              text: controller.user!.date,
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.visible,
                        // maxLines: 7,
                      ),
                    ),
                    // const Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 39, 92, 157)),
                        foregroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 189, 226, 238)),
                      ),
                      onPressed: () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Onboarding Application",
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const WidgetSpan(
                              child: Icon(
                                Icons.open_in_new,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
          if (width > 700)
            const Expanded(
              child: Image(
                  image: AssetImage('res/images/welcome_illustration1.png')),
            ),
        ],
      ),
    );
  }
}

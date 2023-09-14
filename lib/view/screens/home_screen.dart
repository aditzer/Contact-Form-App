import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Contact Form App"),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/rocket.gif", fit: BoxFit.cover)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 25), // Adjust the padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width*0.1),
                    width: double.infinity,
                    child: CustomButton(buttonText: "Contact Us", onTap: () => Navigator.of(context).pushNamed('/contactForm')),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width*0.1),
                    width: double.infinity,
                    child: CustomButton(buttonText: "View Forms", onTap: () => Navigator.of(context).pushNamed('/viewForms')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

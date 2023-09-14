import 'package:contact_form_app/common/theme/app_theme.dart';
import 'package:contact_form_app/model/user_form.dart';
import 'package:flutter/material.dart';

class UserFormWidget extends StatelessWidget {
  final UserForm userForm;
  const UserFormWidget({super.key, required this.userForm});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, color: primaryColor, size: width*0.1),
              const SizedBox(height: 5),
              Text(userForm.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.email, color: primaryColor),
                  const SizedBox(width: 15),
                  Expanded(child: Text(userForm.email, style: const TextStyle(fontSize: 18, color: primaryColor))),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.call, color: primaryColor),
                  const SizedBox(width: 15),
                  Expanded(child: Text(userForm.phoneNumber, style: const TextStyle(fontSize: 18, color: primaryColor))),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.home, color: primaryColor),
                  const SizedBox(width: 15),
                  Expanded(child: Text(userForm.address, style: const TextStyle(fontSize: 18, color: primaryColor))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

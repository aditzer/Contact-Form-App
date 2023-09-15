import 'package:contact_form_app/view/widgets/custom_snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/contact_form_bloc.dart';
import '../../common/constants/ui_constants.dart';
import '../../model/user_form.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_loading_widget.dart';
import '../widgets/custom_textfield.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  late double height, width;

  @override
  void dispose() {
    // to avoid any memory leaks dispose all the textControllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: BlocListener<ContactFormBloc, ContactFormState>(
        listener: (context, state) {
          if (state is ContactFormSuccess) {
            // form submitted successfully
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(state.message));
            _clearTextFields();
          }
          else if (state is ContactFormError) {
            // some error in submitting form
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(state.message));
          }
        },
        child: BlocBuilder<ContactFormBloc, ContactFormState>(
          builder: (context, state) {
            if (state is ContactFormLoading) {
              // if we are in loading state
              return const CustomLoadingWidget();
            } else {
              // not loading state
              return _contactFormScreen();
            }
        }),
      ),
    );
  }

  // the main contact form ui
  Widget _contactFormScreen() {
    return Stack(
      children: [
        // setting background gif animation
        Positioned.fill(
            child: Image.asset("assets/background.gif",
                fit: BoxFit.cover)),

        // setting all textFields and submit button
        ListView(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.1, vertical: 20),
          children: [
            Icon(Icons.message, color: Colors.white, size: width * 0.3),
            const SizedBox(height: 20),
            CustomTextField(
                controller: _nameController,
                hintText: "Enter your name",
                iconData: Icons.person),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _emailController,
                hintText: "Enter your email",
                iconData: Icons.mail),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _phoneController,
                hintText: "Enter your phone number",
                iconData: Icons.call),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _addressController,
                hintText: "Enter your address",
                iconData: Icons.house),
            SizedBox(height: height * 0.05),
            CustomButton(
                buttonText: "Submit", onTap: () => _onTapSubmit())
          ],
        ),
      ],
    );
  }

  // submitting our form
  void _onTapSubmit() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;

    if(_allFieldsValid(name, email, phone, address)) {
      final UserForm userForm = UserForm(
          name: name, email: email, phoneNumber: phone, address: address);
      BlocProvider.of<ContactFormBloc>(context).add(AddContactForm(userForm));
    }
  }

  // check if all textField have valid data
  bool _allFieldsValid(String name, String email, String phone, String address) {
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(invalidNameSnackBar);
    } else if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(invalidEmailSnackBar);
    } else if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(invalidPhoneSnackBar);
    } else if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(invalidAddressSnackBar);
    } else {
      return true;
    }
    return false;
  }

  // clears all textFields
  void _clearTextFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_form_app/bloc/contact_form_bloc.dart';
import 'package:contact_form_app/data/repository.dart';
import 'package:contact_form_app/view/screens/all_forms_screen.dart';
import 'package:contact_form_app/view/screens/contact_form_screen.dart';
import 'package:contact_form_app/view/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.clearPersistence();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactFormBloc(FireStoreRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/contactForm': (context) => const ContactFormScreen(),
          '/viewForms': (context) => const ViewFormsScreen(),
        },
      ),
    );
  }
}
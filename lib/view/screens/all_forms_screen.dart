import 'package:contact_form_app/bloc/contact_form_bloc.dart';
import 'package:contact_form_app/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_form.dart';
import '../widgets/custom_loading_widget.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/user_form_widget.dart';

class ViewFormsScreen extends StatefulWidget {
  const ViewFormsScreen({super.key});

  @override
  State<ViewFormsScreen> createState() => _ViewFormsScreenState();
}

class _ViewFormsScreenState extends State<ViewFormsScreen> {
  late double height, width;

  @override
  void initState() {
    // load all forms upon initialization
    BlocProvider.of<ContactFormBloc>(context).add(LoadContactForms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forms List"),
      ),
      body: BlocListener<ContactFormBloc, ContactFormState>(
        listener: (context, state) {
          if (state is ContactFormError) {
            // some error in loading forms
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(state.message));
          }
        },
        child: BlocBuilder<ContactFormBloc, ContactFormState>(
          bloc: BlocProvider.of<ContactFormBloc>(context),
          builder: (context, state) {
            if (state is ContactFormLoading) {
              // if we are in loading state
              return const CustomLoadingWidget();
            }
            else if (state is ContactFormError) {
              return _errorScreen(state.message);
            }
            else if (state is ContactFormLoaded) {
              List<UserForm> list = state.forms;
              return _formsList(list);
            }
            else {
              return Container();
            }
          }
        ),
      ),
    );
  }

  // show list of all forms
  Widget _formsList(List<UserForm> list) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset("assets/background.gif",
                fit: BoxFit.cover)),
        RefreshIndicator(
          onRefresh: ()=> _onRefresh(),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return UserFormWidget(userForm: list[index]);
            }
          ),
        ),
      ],
    );
  }

  // when state is errorState, we show error screen
  Widget _errorScreen(String message) {
    return RefreshIndicator(
      onRefresh: ()=> _onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: height*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.png"),
              const SizedBox(height: 20),
              Text(message, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: primaryColor))
            ],
          ),
        ),
      ),
    );
  }

  // upon pull to refresh fetch data from fireStore again
   _onRefresh() {
    BlocProvider.of<ContactFormBloc>(context).add(LoadContactForms());
  }
}

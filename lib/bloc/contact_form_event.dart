part of 'contact_form_bloc.dart';

@immutable
abstract class ContactFormEvent {}

class LoadContactForms extends ContactFormEvent {}

class AddContactForm extends ContactFormEvent {
  final UserForm userForm;

  AddContactForm(this.userForm);
}

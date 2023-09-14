part of 'contact_form_bloc.dart';

@immutable
abstract class ContactFormState {}

class ContactFormInitial extends ContactFormState {}

class ContactFormLoading extends ContactFormState {}

class ContactFormLoaded extends ContactFormState {
  final List<UserForm> forms;

  ContactFormLoaded(this.forms);
}

class ContactFormSuccess extends ContactFormState {
  final String message;

  ContactFormSuccess(this.message);
}

class ContactFormError extends ContactFormState {
  final String message;

  ContactFormError(this.message);
}
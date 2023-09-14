import 'package:bloc/bloc.dart';
import 'package:contact_form_app/data/repository.dart';
import 'package:contact_form_app/model/user_form.dart';
import 'package:meta/meta.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final FireStoreRepository _fireStoreRepository;

  ContactFormBloc(this._fireStoreRepository) : super(ContactFormInitial()) {
    on<LoadContactForms>((event, emit) async {
      try {
        emit(ContactFormLoading());
        final stream = await _fireStoreRepository.getForms();
        final forms = await stream.first;
        emit(ContactFormLoaded(forms));
      } catch (e) {
        // if connection is off this will execute
        emit(ContactFormError(e.toString()));
      }
    });

    on<AddContactForm>((event, emit) async {
      try {
        emit(ContactFormLoading());
        await _fireStoreRepository.addForm(event.userForm);
        emit(ContactFormSuccess('Thanks for your response!'));
      } catch (e) {
        // if connection is off this will execute
        emit(ContactFormError(e.toString()));
      }
    });
  }
}

# Contact Form App
This is a Flutter using which users can fill a contact form which will be stored in  firestore database.
*I have also added additional functionality using which all the submitted forms can be seen.*

To access the apk and demo video of the app go to this link: https://drive.google.com/drive/folders/1PGlf8NJ7HUixS5ROKBcyV7aV_Iq1SU9Y?usp=sharing

## Components of App
    1. This App uses Flutter Bloc state management library.
    2. Firebase firestore has been used to store data.

## Working of App
### Level-0 Diagram
1. User can interact with UI which will produce some event.
2. The event is dealt by Bloc and then Bloc takes help of repository.
3. Repository connects with Firestore to get data.
4. Bloc emits some state according to results produced by repository.
5. UI changes are made based on those states.

![level_0_diagram](https://github.com/aditzer/Contact-Form-App/assets/53402554/0663a921-02ad-4fe0-b238-6d432cbced56)

The app allows users to submit a form and also read all forms which have been submitted by all users.

### Contact Form Submission
1. Once user submits a valid form, the AddContactForm event is generated.
2. Bloc emits Loading state, to set UI to load.
3. Bloc calls addForm from repository.
4. Repository calls firestore functions to add form data.
5. Firestore returns document reference or error.
6. Repository returns document reference or error.
7. If adding was successful then ContactFormSuccess state is generated otherwise ContactFormError State is generated.
   
![contact_forms_diagram](https://github.com/aditzer/Contact-Form-App/assets/53402554/7d203553-4055-44cf-9f36-e3c8457ec178)

### View All Forms
1. Once view all forms screens is initialized, the LoadContactForm event is generated.
2. Bloc emits Loading state, to set UI to load.
3. Bloc calls getForms from repository.
4. Repository calls firestore functions to get form data.
5. Firestore returns data or error.
6. Repository returns data or error.
7. If adding was successful then ContactFormLoaded state is generated otherwise ContactFormError State is generated.
   
![view_all_forms_diagram](https://github.com/aditzer/Contact-Form-App/assets/53402554/52cf1580-c9a4-479c-9497-552d1a21d4c9)

### Error Handling
1. When user tries to submit form without internet connection or if any error occurrs while adding the data to firestore, the error snackbar will be shown.
2. When user tries to view all forms without internet connection or if any error occurrs while fetching the data from firestore, the error screen will be shown.
3. If internet connection is back on again, user can refresh and data will be fetched.
